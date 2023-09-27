import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher/question/question_preview.dart';
import 'package:qna_test/DataSource/design.dart';
import '../../../Components/custom_incorrect_popup.dart';
import '../../../Entity/Teacher/choice_entity.dart';
import '../../../Entity/Teacher/edit_question_model.dart';
import '../../../Entity/Teacher/question_entity.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../Entity/Teacher/response_entity.dart';
import '../../../Entity/user_details.dart';
import '../../../EntityModel/login_entity.dart';
import '../../../Providers/LanguageChangeProvider.dart';
import '../../../Providers/question_prepare_provider_final.dart';
import '../../../Services/qna_service.dart';

Color textColor = const Color.fromRGBO(48, 145, 139, 1);

class EditExistingQuestion extends StatefulWidget {
  EditExistingQuestion({Key? key, required this.question}) : super(key: key);
  Question question;

  @override
  EditExistingQuestionState createState() => EditExistingQuestionState();
}

class EditExistingQuestionState extends State<EditExistingQuestion> {
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
  EditQuestionModel editQuestion =
      EditQuestionModel(editChoices: [], addChoices: [], removeChoices: []);
  List<AddChoice> m = [];

  alertDialogDeleteQuestion(BuildContext context, double height) {
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
        AppLocalizations.of(context)!.no,
        // 'No',
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
        AppLocalizations.of(context)!.yes,
        //'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () async {
        UserDetails userDetails = UserDetails();
        userDetails =
            Provider.of<LanguageChangeProvider>(context, listen: false)
                .userDetails;
        LoginModel statusCode = await QnaService.deleteQuestion(
            widget.question.questionId!, userDetails);
        //Provider.of<QuestionPrepareProviderFinal>(context, listen: false).deleteQuestionList(widget.questionIndex);
        if (statusCode.code == 200) {
          //Navigator.pushNamedAndRemoveUntil(context, '/teacherQuestionBank',(route) => route.isFirst);
          Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank',
              ModalRoute.withName('/teacherSelectionPage'));
        } else {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: CustomDialog(
                title: AppLocalizations.of(context)!.alert_popup,
                //"OOPS!",
                content: statusCode.message!,
                //'please enter the correct password',
                button: "Ok",
                numberOfScreenBack: 2,
              ),
            ),
          );
          //Navigator.of(context).pop();
        }
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
            AppLocalizations.of(context)!.confirm,
            //'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!.want_to_del_qn,
        // 'Are you sure you want to delete this Question?',
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

  showAlertDialog(BuildContext context, double height, String? value) {
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
        AppLocalizations.of(context)!.no,
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
        AppLocalizations.of(context)!.yes,
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
          questionController.text = '';
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
            AppLocalizations.of(context)!.alert_popup,
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
        AppLocalizations.of(context)!.want_to_clear_qn,
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
  final formKey = GlobalKey<FormState>();
  final questionFormKey = GlobalKey<FormState>();
  Question finalQuestion = Question();
  late SharedPreferences loginData;
  List<Choice> tempChoiceList = [];
  int tempAddChoiceId = -100;
  AddChoice addChoice = AddChoice();
  List<int> tempChoiceId = [];
  List<int> addChoiceId = [];
  List<int> editChoiceId = [];
  int descriptiveChId = -100;

  addField() {
    setState(() {
      widget.question.choices?.add(Choice(choiceText: '', rightChoice: false));
      chooses.add(TextEditingController());
      radioList.add(false);
      editQuestion.addChoices?.add(AddChoice(
          questionId: tempAddChoiceId, choiceText: '', rightChoice: false));
      tempChoiceId.add(tempAddChoiceId);
      addChoiceId.add(tempAddChoiceId);
      tempAddChoiceId++;
    });
  }

  removeItem(i) {
    setState(() {
      if (addChoiceId.contains(tempChoiceId[i])) {
        int index = addChoiceId.indexOf(tempChoiceId[i]);
        addChoiceId.removeAt(index);
        editQuestion.addChoices?.removeAt(index);
      } else {
        if (editChoiceId.contains(tempChoiceId[i])) {
          int index = editChoiceId.indexOf(tempChoiceId[i]);
          editChoiceId.removeAt(index);
          editQuestion.editChoices?.removeAt(index);
        }
      }
      chooses.removeAt(i);
      radioList.removeAt(i);
      editQuestion.removeChoices!.add(tempChoiceId[i]);
      widget.question.choices?.removeAt(i);
      tempChoiceId.removeAt(i);
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
    subjectController.text = widget.question.subject!;
    topicController.text = widget.question.topic!;
    degreeController.text = widget.question.degreeStudent!;
    semesterController.text = widget.question.semester!;
    _questionTypeValue = widget.question.questionType!;
    questionController.text = widget.question.question!;
    adviceController.text = widget.question.advisorText!;
    urlController.text = widget.question.advisorUrl!;
    if (widget.question.questionType != "Descriptive") {
      for (int i = 0; i < widget.question.choices!.length; i++) {
        tempChoiceList.add(widget.question.choices![i]);
        TextEditingController tempChoice = TextEditingController();
        tempChoice.text = widget.question.choices![i].choiceText!;
        chooses.add(tempChoice);
        radioList.add(widget.question.choices![i].rightChoice!);
        tempChoiceId.add(widget.question.choices![i].questionChoiceId!);
      }
    } else {
      Choice ch = Choice();
      tempChoiceList.add(ch);
      TextEditingController tempChoice = TextEditingController();
      tempChoice.text = '';
      chooses.add(tempChoice);
      radioList.add(false);
      tempChoiceId.add(descriptiveChId);
      descriptiveChId++;
    }
    setData();
  }

  setData() async {
    loginData = await SharedPreferences.getInstance();
    List<Question> quesList =
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .getAllQuestion;
    if (quesList.isNotEmpty) {
      setState(() {
        subjectController.text = quesList[0].subject ?? '';
        topicController.text = quesList[0].topic ?? '';
        degreeController.text = quesList[0].degreeStudent ?? '';
        semesterController.text = quesList[0].semester ?? '';
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
        if (constraints.maxWidth <= 960 && constraints.maxWidth >= 500) {
          return WillPopScope(
              onWillPop: () async => false,
              child: OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                return orientation == Orientation.landscape &&
                        constraints.maxHeight <= 500
                    ? Scaffold(
                        resizeToAvoidBottomInset: true,
                        backgroundColor: Colors.white,
                        endDrawer: const EndDrawerMenuTeacher(),
                        appBar: AppBar(
                          iconTheme: IconThemeData(
                              color: appBarChevronColor, size: height * 0.07),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          leading: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: height * 0.07,
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
                                  "Edit Question",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.045,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]),
                          flexibleSpace: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                        ),
                        body: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.023,
                                left: height * 0.045,
                                right: height * 0.045,
                                bottom: height * 0.023),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      height: height * 0.75,
                                      width: width * 0.93,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              153, 153, 153, 0.5),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.023,
                                              left: height * 0.023,
                                              right: height * 0.023),
                                          child: Column(
                                            children: [
                                              showIcon ==
                                                      Icons
                                                          .expand_circle_down_outlined
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Wrap(
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02),
                                                                      child: Text(
                                                                          //AppLocalizations.of(context)!.subject_topic,
                                                                          "Question Details",
                                                                          style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: height * 0.020)),
                                                                    ),
                                                                    // SizedBox(width: width * 0.25),
                                                                    // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                                    IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        showIcon,
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        size: height *
                                                                            0.03,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        changeIcon(
                                                                            showIcon);
                                                                      },
                                                                    )
                                                                  ]),
                                                              const Divider(
                                                                thickness: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question type container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question Type",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "MCQ",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'MCQ',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "Survey",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Survey',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          value:
                                                                              "Descriptive",
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Descriptive',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                50.0),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Form(
                                                                key:
                                                                    questionFormKey,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        questionController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              102,
                                                                              102,
                                                                              102,
                                                                              0.3),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              height * 0.016),
                                                                      hintText:
                                                                          "Type Question here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                    onChanged:
                                                                        (val) {
                                                                      questionFormKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "Enter Question";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Answer",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0)
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: width * 0.02,
                                                                              top: width * 0.01),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                      : Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: width * 0.02),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                                width: width * 0.15,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0,
                                                                    )
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(bottom: height * 0.02, left: width * 0.02, top: width * 0.02),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "${String.fromCharCode(97 + i)}.",
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
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
                                                                                        icon: Icon(
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
                                                                      : Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    bottom: height * 0.02,
                                                                                    left: width * 0.02,
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018)),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();

                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?[index] = addChoice;
                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();

                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;

                                                                                                setState(() {
                                                                                                  editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                                  editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                                });
                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.13,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                              editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                              editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                                editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = !radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                            _onRadioChange(i);
                                                                                            setState(() {
                                                                                              radioList;
                                                                                            });
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.03,
                                                                                            radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.11,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            removeItem(i);
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.03,
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
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02,
                                                                          bottom: width *
                                                                              0.02,
                                                                          right:
                                                                              width * 0.02),
                                                                      child: TextField(
                                                                          controller: answerController,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            hintStyle: TextStyle(
                                                                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: height * 0.016),
                                                                            hintText:
                                                                                "Type Answer here",
                                                                            enabledBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                          )))
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02),
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            Text(
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
                                                                        onPressed:
                                                                            () {
                                                                          addField();
                                                                        },
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Advisor Container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Advisor",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      adviceController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  maxLines:
                                                                      null,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.016),
                                                                    hintText:
                                                                        "Suggest what to study if answered incorrectly",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      urlController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.016),
                                                                    hintText:
                                                                        "URL - Any reference (Optional)",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
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
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Wrap(
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                                    Form(
                                                                      key:
                                                                          formKey,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: width * 0.02),
                                                                        child: Text(
                                                                            //AppLocalizations.of(context)!.subject_topic,
                                                                            "Question Details",
                                                                            style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: height * 0.040)),
                                                                      ),
                                                                    ),
                                                                    // SizedBox(width: width * 0.25),
                                                                    // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                                    IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        showIcon,
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        size: height *
                                                                            0.07,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        changeIcon(
                                                                            showIcon);
                                                                      },
                                                                    )
                                                                  ]),
                                                              const Divider(
                                                                thickness: 2,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: height *
                                                                        0.02),
                                                                child: Text(
                                                                  //AppLocalizations.of(context)!.my_qn_bank,
                                                                  "Subject",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.04,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      subjectController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.035),
                                                                    hintText:
                                                                        "Type here",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    // focusedBorder: OutlineInputBorder(
                                                                    //     borderSide: const BorderSide(
                                                                    //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                    //     borderRadius: BorderRadius.circular(15)),
                                                                    // border: OutlineInputBorder(
                                                                    //     borderRadius: BorderRadius.circular(15)),
                                                                  ),
                                                                  onChanged:
                                                                      (val) {
                                                                    formKey
                                                                        .currentState!
                                                                        .validate();
                                                                  },
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                        "") {
                                                                      return "Enter Subject";
                                                                    } else if (!RegExp(
                                                                            r"^[^\s].*$")
                                                                        .hasMatch(
                                                                            value!)) {
                                                                      return "Enter alphanumeric charecter only";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: height *
                                                                        0.02),
                                                                child: Text(
                                                                  //AppLocalizations.of(context)!.my_qn_bank,
                                                                  "Topic",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.04,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      topicController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.035),
                                                                    hintText:
                                                                        "Type here",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    // focusedBorder: OutlineInputBorder(
                                                                    //     borderSide: const BorderSide(
                                                                    //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                    //     borderRadius: BorderRadius.circular(15)),
                                                                    // border: OutlineInputBorder(
                                                                    //     borderRadius: BorderRadius.circular(15)),
                                                                  ),
                                                                  onChanged:
                                                                      (val) {
                                                                    formKey
                                                                        .currentState!
                                                                        .validate();
                                                                  },
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                        "") {
                                                                      return "Enter Topic";
                                                                    } else if (!RegExp(
                                                                            r"^[^\s].*$")
                                                                        .hasMatch(
                                                                            value!)) {
                                                                      return "Enter alphanumeric charecter only";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: height *
                                                                        0.02),
                                                                child: Text(
                                                                  //AppLocalizations.of(context)!.my_qn_bank,
                                                                  "Degree",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.04,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      degreeController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.035),
                                                                    hintText:
                                                                        "Type here",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    // focusedBorder: OutlineInputBorder(
                                                                    //     borderSide: const BorderSide(
                                                                    //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                    //     borderRadius: BorderRadius.circular(15)),
                                                                    // border: OutlineInputBorder(
                                                                    //     borderRadius: BorderRadius.circular(15)),
                                                                  ),
                                                                  onChanged:
                                                                      (val) {
                                                                    formKey
                                                                        .currentState!
                                                                        .validate();
                                                                  },
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                        "") {
                                                                      return "Enter Degree";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: height *
                                                                        0.02),
                                                                child: Text(
                                                                  //AppLocalizations.of(context)!.my_qn_bank,
                                                                  "Semester (optional)",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontSize:
                                                                        height *
                                                                            0.04,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      semesterController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.035),
                                                                    hintText:
                                                                        "Type here",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
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
                                                                height: height *
                                                                    0.1,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question type container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question Type",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.040)),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "MCQ",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'MCQ',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.035)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "Survey",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Survey',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.035)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          value:
                                                                              "Descriptive",
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Descriptive',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.035)),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                50.0),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.040)),
                                                              ),
                                                              Form(
                                                                key:
                                                                    questionFormKey,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        questionController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              102,
                                                                              102,
                                                                              102,
                                                                              0.3),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              height * 0.035),
                                                                      hintText:
                                                                          "Type Question here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onChanged:
                                                                        (val) {
                                                                      questionFormKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "Enter Question";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Answer",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.040)),
                                                              ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0)
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: width * 0.02,
                                                                              top: width * 0.01),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                      fontSize: height * 0.034,
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
                                                                      : Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: width * 0.02),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                      fontSize: height * 0.034,
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
                                                                                    fontSize: height * 0.034,
                                                                                    fontFamily: "Inter",
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: width * 0.15,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0,
                                                                    )
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(bottom: height * 0.02, left: width * 0.02, top: width * 0.02),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      SizedBox(width: width * 0.02, child: Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.040))),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.040),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.04),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
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
                                                                                        icon: Icon(
                                                                                          size: height * 0.07,
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
                                                                      : Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    bottom: height * 0.02,
                                                                                    left: width * 0.02,
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Text("${String.fromCharCode(97 + i)}.",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontFamily: 'Inter',
                                                                                            fontWeight: FontWeight.w400,
                                                                                            fontSize: height * 0.040,
                                                                                          )),
                                                                                      SizedBox(width: width * 0.01),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.040),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.04),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?[index] = addChoice;

                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();

                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                //editQuestion.addChoices?[index]=addChoice;
                                                                                                setState(() {
                                                                                                  editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                                  editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                                });
                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.13,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                              editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                              editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                                editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = !radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                            _onRadioChange(i);
                                                                                            setState(() {
                                                                                              radioList;
                                                                                            });
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.07,
                                                                                            radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.11,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            removeItem(i);
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.07,
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
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02,
                                                                          bottom: width *
                                                                              0.02,
                                                                          right:
                                                                              width * 0.02),
                                                                      child: TextField(
                                                                          controller: answerController,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            hintStyle: TextStyle(
                                                                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: height * 0.035),
                                                                            hintText:
                                                                                "Type Answer here",
                                                                            enabledBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                          )))
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02),
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            Text(
                                                                          //AppLocalizations.of(context)!.subject_topic,
                                                                          "+Add choice",
                                                                          //textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                              color: const Color.fromRGBO(82, 165, 160, 1),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              decoration: TextDecoration.underline,
                                                                              fontSize: height * 0.035),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          addField();
                                                                        },
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Advisor Container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Advisor",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.040)),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      adviceController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  maxLines:
                                                                      null,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.035),
                                                                    hintText:
                                                                        "Suggest what to study if answered incorrectly",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      urlController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.035),
                                                                    hintText:
                                                                        "URL - Any reference (Optional)",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
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
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(height: height * 0.015),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            alertDialogDeleteQuestion(
                                                context, height);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors
                                                .white, // <-- Button color
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: width * 0.02,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                          ),
                                        ),
                                        SizedBox(height: width * 0.005),
                                        Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                            "Delete",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.035)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              for (int i = 0;
                                                  i < tempChoiceList.length;
                                                  i++) {
                                                editQuestion.removeChoices
                                                    ?.add(tempChoiceId[i]);
                                              }
                                              tempChoiceId = [];
                                              subjectController.text = '';
                                              topicController.text = '';
                                              degreeController.text = '';
                                              semesterController.text = '';
                                              questionController.text = '';
                                              answerController.text = '';
                                              tempChoiceList = [];
                                              chooses = [];
                                              radioList = [];
                                              adviceController.text = '';
                                              urlController.text = '';
                                              //questionMvp2=Question();
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors
                                                .white, // <-- Button color
                                          ),
                                          child: Icon(
                                            Icons.refresh,
                                            size: width * 0.02,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                          ),
                                        ),
                                        SizedBox(height: width * 0.005),
                                        Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                            "Clear All",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.035)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            editQuestion.subject =
                                                subjectController.text;
                                            editQuestion.topic =
                                                topicController.text;
                                            editQuestion.semester =
                                                semesterController.text;
                                            editQuestion
                                                    .editQuestionModelClass =
                                                degreeController.text;
                                            editQuestion.question =
                                                questionController.text;
                                            editQuestion.questionType =
                                                _questionTypeValue;
                                            editQuestion.advisorUrl =
                                                urlController.text;
                                            editQuestion.advisorText =
                                                adviceController.text;
                                            UserDetails userDetails =
                                                UserDetails();
                                            userDetails = Provider.of<
                                                        LanguageChangeProvider>(
                                                    context,
                                                    listen: false)
                                                .userDetails;
                                            if (((showIcon ==
                                                        Icons
                                                            .expand_circle_down_outlined) ||
                                                    formKey.currentState!
                                                        .validate()) &&
                                                questionFormKey.currentState!
                                                    .validate()) {
                                              if (_questionTypeValue == 'MCQ' &&
                                                  !radioList.contains(true)) {
                                              } else if (_questionTypeValue ==
                                                      'Survey' &&
                                                  tempChoiceList.isEmpty) {
                                              } else {
                                                ResponseEntity statusCode =
                                                    await QnaService
                                                        .editQuestionTeacherService(
                                                            editQuestion,
                                                            widget.question
                                                                .questionId,
                                                            userDetails);
                                                if (statusCode.code == 200) {
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          '/teacherQuestionBank',
                                                          ModalRoute.withName(
                                                              '/teacherSelectionPage'));
                                                }
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor:
                                                const Color.fromRGBO(82, 165,
                                                    160, 1), // <-- Button color
                                          ),
                                          child: Icon(Icons.check,
                                              size: width * 0.02,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: width * 0.005),
                                        Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                            "Save Changes",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.035)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))
                    : Scaffold(
                        resizeToAvoidBottomInset: true,
                        backgroundColor: Colors.white,
                        endDrawer: const EndDrawerMenuTeacher(),
                        appBar: AppBar(
                          iconTheme: IconThemeData(
                              color: appBarChevronColor, size: height * 0.05),
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
                                  "Edit Question",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.025,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]),
                          flexibleSpace: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                        ),
                        body: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.023,
                                left: height * 0.045,
                                right: height * 0.045,
                                bottom: height * 0.023),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                      height: height * 0.75,
                                      width: width * 0.93,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              153, 153, 153, 0.5),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.023,
                                              left: height * 0.023,
                                              right: height * 0.023),
                                          child: Column(
                                            children: [
                                              showIcon ==
                                                      Icons
                                                          .expand_circle_down_outlined
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Wrap(
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02),
                                                                      child: Text(
                                                                          //AppLocalizations.of(context)!.subject_topic,
                                                                          "Question Details",
                                                                          style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: height * 0.020)),
                                                                    ),
                                                                    // SizedBox(width: width * 0.25),
                                                                    // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                                    IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        showIcon,
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        size: height *
                                                                            0.03,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        changeIcon(
                                                                            showIcon);
                                                                      },
                                                                    )
                                                                  ]),
                                                              const Divider(
                                                                thickness: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question type container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question Type",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "MCQ",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'MCQ',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "Survey",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Survey',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          value:
                                                                              "Descriptive",
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Descriptive',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                50.0),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Form(
                                                                key:
                                                                    questionFormKey,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        questionController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              102,
                                                                              102,
                                                                              102,
                                                                              0.3),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              height * 0.016),
                                                                      hintText:
                                                                          "Type Question here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                    onChanged:
                                                                        (val) {
                                                                      questionFormKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "Enter Question";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Answer",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0)
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: width * 0.02,
                                                                              top: width * 0.01),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                      : Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: width * 0.02),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                                width: width * 0.15,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0,
                                                                    )
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(bottom: height * 0.02, left: width * 0.02, top: width * 0.02),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "${String.fromCharCode(97 + i)}.",
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
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
                                                                                        icon: Icon(
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
                                                                      : Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    bottom: height * 0.02,
                                                                                    left: width * 0.02,
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018)),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();

                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?[index] = addChoice;
                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();

                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;

                                                                                                setState(() {
                                                                                                  editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                                  editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                                });
                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.13,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                              editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                              editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                                editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = !radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                            _onRadioChange(i);
                                                                                            setState(() {
                                                                                              radioList;
                                                                                            });
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.03,
                                                                                            radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.11,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            removeItem(i);
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.03,
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
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02,
                                                                          bottom: width *
                                                                              0.02,
                                                                          right:
                                                                              width * 0.02),
                                                                      child: TextField(
                                                                          controller: answerController,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            hintStyle: TextStyle(
                                                                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: height * 0.016),
                                                                            hintText:
                                                                                "Type Answer here",
                                                                            enabledBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                          )))
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02),
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            Text(
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
                                                                        onPressed:
                                                                            () {
                                                                          addField();
                                                                        },
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Advisor Container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Advisor",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      adviceController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  maxLines:
                                                                      null,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.016),
                                                                    hintText:
                                                                        "Suggest what to study if answered incorrectly",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      urlController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.016),
                                                                    hintText:
                                                                        "URL - Any reference (Optional)",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
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
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Form(
                                                          key:formKey,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    153,
                                                                    153,
                                                                    153,
                                                                    0.5),
                                                              ),
                                                              // borderRadius: BorderRadius.all(
                                                              //     Radius.circular(10)),
                                                            ),
                                                            child: Wrap(
                                                              children: [
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                                      Padding(
                                                                          padding:
                                                                        EdgeInsets.only(left: width * 0.02),
                                                                          child: Text(
                                                                        //AppLocalizations.of(context)!.subject_topic,
                                                                        "Question Details",
                                                                        style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: height * 0.020)),
                                                                        ),
                                                                      // SizedBox(width: width * 0.25),
                                                                      // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                                      IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          showIcon,
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              28,
                                                                              78,
                                                                              80,
                                                                              1),
                                                                          size: height *
                                                                              0.03,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          changeIcon(
                                                                              showIcon);
                                                                        },
                                                                      )
                                                                    ]),
                                                                const Divider(
                                                                  thickness: 2,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      top: height *
                                                                          0.02),
                                                                  child: Text(
                                                                    //AppLocalizations.of(context)!.my_qn_bank,
                                                                    "Subject",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.02,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        subjectController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                          fontSize:
                                                                              height *
                                                                                  0.016),
                                                                      hintText:
                                                                          "Type here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                    onChanged:
                                                                        (val) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "Enter Subject";
                                                                      } else if (!RegExp(
                                                                              r"^[^\s].*$")
                                                                          .hasMatch(
                                                                              value!)) {
                                                                        return "Enter alphanumeric charecter only";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      top: height *
                                                                          0.02),
                                                                  child: Text(
                                                                    //AppLocalizations.of(context)!.my_qn_bank,
                                                                    "Topic",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.02,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        topicController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                          fontSize:
                                                                              height *
                                                                                  0.016),
                                                                      hintText:
                                                                          "Type here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                    onChanged:
                                                                        (val) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "Enter Topic";
                                                                      } else if (!RegExp(
                                                                              r"^[^\s].*$")
                                                                          .hasMatch(
                                                                              value!)) {
                                                                        return "Enter alphanumeric charecter only";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      top: height *
                                                                          0.02),
                                                                  child: Text(
                                                                    //AppLocalizations.of(context)!.my_qn_bank,
                                                                    "Degree/Class",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.02,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        degreeController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                          fontSize:
                                                                              height *
                                                                                  0.016),
                                                                      hintText:
                                                                          "Type here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                    onChanged:
                                                                        (val) {
                                                                      formKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "Enter Degree/Class";
                                                                      } else if (!RegExp(
                                                                              r"^[^\s].*$")
                                                                          .hasMatch(
                                                                              value!)) {
                                                                        return "Enter alphanumeric charecter only";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      top: height *
                                                                          0.02),
                                                                  child: Text(
                                                                    //AppLocalizations.of(context)!.my_qn_bank,
                                                                    "Semester (optional)",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontSize:
                                                                          height *
                                                                              0.02,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        semesterController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                          fontSize:
                                                                              height *
                                                                                  0.016),
                                                                      hintText:
                                                                          "Type here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
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
                                                                  height: height *
                                                                      0.1,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question type container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question Type",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "MCQ",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'MCQ',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "Survey",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Survey',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          value:
                                                                              "Descriptive",
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Descriptive',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                50.0),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Question container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Question",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Form(
                                                                key:
                                                                    questionFormKey,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        questionController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              102,
                                                                              102,
                                                                              102,
                                                                              0.3),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              height * 0.016),
                                                                      hintText:
                                                                          "Type Question here",
                                                                      enabledBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          const UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onChanged:
                                                                        (val) {
                                                                      questionFormKey
                                                                          .currentState!
                                                                          .validate();
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "Enter Question";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Answer",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0)
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: width * 0.02,
                                                                              top: width * 0.01),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                      : Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: width * 0.02),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerLeft,
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context)!.choices,
                                                                                    //"Choices",
                                                                                    style: TextStyle(
                                                                                      color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                                width: width * 0.15,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? const SizedBox(
                                                                      height: 0,
                                                                    )
                                                                  : _questionTypeValue ==
                                                                          "Survey"
                                                                      ? Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(bottom: height * 0.02, left: width * 0.02, top: width * 0.02),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018)),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            setState(() {
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
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
                                                                                        icon: Icon(
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
                                                                      : Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              for (int i = 0; i < chooses.length; i++)
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    bottom: height * 0.02,
                                                                                    left: width * 0.02,
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Text("${String.fromCharCode(97 + i)}.",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontFamily: 'Inter',
                                                                                            fontWeight: FontWeight.w400,
                                                                                            fontSize: height * 0.018,
                                                                                          )),
                                                                                      SizedBox(width: width * 0.01),
                                                                                      Expanded(
                                                                                        child: TextFormField(
                                                                                          controller: chooses[i],
                                                                                          style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,
                                                                                          decoration: InputDecoration(
                                                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                            hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                            hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                            //"Type Option Here",
                                                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                          ),
                                                                                          onFieldSubmitted: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();
                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                editQuestion.addChoices?[index] = addChoice;

                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                          onTapOutside: (t) {
                                                                                            setState(() {
                                                                                              String val = chooses[i].text;
                                                                                              EditChoice editChoice = EditChoice();

                                                                                              chooses[i].text = val;
                                                                                              widget.question.choices![i].choiceText = val;
                                                                                              if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                                //editQuestion.addChoices?.removeAt(index);
                                                                                                addChoice.rightChoice = radioList[i];
                                                                                                addChoice.questionId = tempChoiceId[i];
                                                                                                addChoice.choiceText = val;
                                                                                                //editQuestion.addChoices?[index]=addChoice;
                                                                                                setState(() {
                                                                                                  editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                                  editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                                });
                                                                                                //editQuestion.addChoices?.add(addChoice);
                                                                                              } else {
                                                                                                if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                  int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                  //editQuestion.editChoices?.removeAt(index);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?[index] = editChoice;
                                                                                                  //editQuestion.editChoices?.add(editChoice);
                                                                                                } else {
                                                                                                  editChoiceId.add(tempChoiceId[i]);
                                                                                                  editChoice.rightChoice = radioList[i];
                                                                                                  editChoice.choiceId = tempChoiceId[i];
                                                                                                  editChoice.choiceText = val;
                                                                                                  editQuestion.editChoices?.add(editChoice);
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.13,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                              editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                              editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                                editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = !radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = chooses[i].text;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                            _onRadioChange(i);
                                                                                            setState(() {
                                                                                              radioList;
                                                                                            });
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.03,
                                                                                            radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                            color: const Color.fromRGBO(82, 165, 160, 1),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.11,
                                                                                        child: IconButton(
                                                                                          onPressed: () {
                                                                                            removeItem(i);
                                                                                          },
                                                                                          icon: Icon(
                                                                                            size: height * 0.03,
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
                                                              _questionTypeValue ==
                                                                      "Descriptive"
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02,
                                                                          bottom: width *
                                                                              0.02,
                                                                          right:
                                                                              width * 0.02),
                                                                      child: TextField(
                                                                          controller: answerController,
                                                                          keyboardType: TextInputType.text,
                                                                          decoration: InputDecoration(
                                                                            hintStyle: TextStyle(
                                                                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: height * 0.016),
                                                                            hintText:
                                                                                "Type Answer here",
                                                                            enabledBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                const UnderlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                              ),
                                                                            ),
                                                                          )))
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02),
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            Text(
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
                                                                        onPressed:
                                                                            () {
                                                                          addField();
                                                                        },
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),

                                                        //Advisor Container
                                                        Container(
                                                          width: width * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  153,
                                                                  153,
                                                                  153,
                                                                  0.5),
                                                            ),
                                                            // borderRadius: BorderRadius.all(
                                                            //     Radius.circular(10)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    top: width *
                                                                        0.02),
                                                                child: Text(
                                                                    //AppLocalizations.of(context)!.subject_topic,
                                                                    "Advisor",
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            28,
                                                                            78,
                                                                            80,
                                                                            1),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            height *
                                                                                0.020)),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      adviceController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  maxLines:
                                                                      null,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.016),
                                                                    hintText:
                                                                        "Suggest what to study if answered incorrectly",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    right: width *
                                                                        0.02),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      urlController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                        fontSize:
                                                                            height *
                                                                                0.016),
                                                                    hintText:
                                                                        "URL - Any reference (Optional)",
                                                                    enabledBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        const UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                      ),
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
                                                                height: height *
                                                                    0.015,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(height: height * 0.015),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            alertDialogDeleteQuestion(
                                                context, height);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors
                                                .white, // <-- Button color
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: width * 0.04,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                          ),
                                        ),
                                        SizedBox(height: width * 0.005),
                                        Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                            "Delete",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.016)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              for (int i = 0;
                                                  i < tempChoiceList.length;
                                                  i++) {
                                                editQuestion.removeChoices
                                                    ?.add(tempChoiceId[i]);
                                              }
                                              tempChoiceId = [];
                                              subjectController.text = '';
                                              topicController.text = '';
                                              degreeController.text = '';
                                              semesterController.text = '';
                                              questionController.text = '';
                                              answerController.text = '';
                                              tempChoiceList = [];
                                              chooses = [];
                                              radioList = [];
                                              adviceController.text = '';
                                              urlController.text = '';
                                              //questionMvp2=Question();
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors
                                                .white, // <-- Button color
                                          ),
                                          child: Icon(
                                            Icons.refresh,
                                            size: width * 0.04,
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                          ),
                                        ),
                                        SizedBox(height: width * 0.005),
                                        Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                            "Clear All",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.016)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            editQuestion.subject =
                                                subjectController.text;
                                            editQuestion.topic =
                                                topicController.text;
                                            editQuestion.semester =
                                                semesterController.text;
                                            editQuestion
                                                    .editQuestionModelClass =
                                                degreeController.text;
                                            editQuestion.question =
                                                questionController.text;
                                            editQuestion.questionType =
                                                _questionTypeValue;
                                            editQuestion.advisorUrl =
                                                urlController.text;
                                            editQuestion.advisorText =
                                                adviceController.text;
                                            UserDetails userDetails =
                                                UserDetails();
                                            userDetails = Provider.of<
                                                        LanguageChangeProvider>(
                                                    context,
                                                    listen: false)
                                                .userDetails;
                                            if (((showIcon ==
                                                        Icons
                                                            .expand_circle_down_outlined) ||
                                                    formKey.currentState!
                                                        .validate()) &&
                                                questionFormKey.currentState!
                                                    .validate()) {
                                              if (_questionTypeValue == 'MCQ' &&
                                                  !radioList.contains(true)) {
                                              } else if (_questionTypeValue ==
                                                      'Survey' &&
                                                  tempChoiceList.isEmpty) {
                                              } else {
                                                ResponseEntity statusCode =
                                                    await QnaService
                                                        .editQuestionTeacherService(
                                                            editQuestion,
                                                            widget.question
                                                                .questionId,
                                                            userDetails);
                                                if (statusCode.code == 200) {
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          '/teacherQuestionBank',
                                                          ModalRoute.withName(
                                                              '/teacherSelectionPage'));
                                                }
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor:
                                                const Color.fromRGBO(82, 165,
                                                    160, 1), // <-- Button color
                                          ),
                                          child: Icon(Icons.check,
                                              size: width * 0.04,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: width * 0.005),
                                        Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                            "Save Changes",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    28, 78, 80, 1),
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
                        ));
              }));
        } else if (constraints.maxWidth > 960) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  endDrawer: const EndDrawerMenuTeacher(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                        color: appBarChevronColor, size: height * 0.05),
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
                            "Edit Question",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width * 0.7,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: height * 0.7,
                                  width: width * 0.93,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          153, 153, 153, 0.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          showIcon ==
                                                  Icons
                                                      .expand_circle_down_outlined
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Wrap(
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02),
                                                                  child: Text(
                                                                      //AppLocalizations.of(context)!.subject_topic,
                                                                      "Question Details",
                                                                      style: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              28,
                                                                              78,
                                                                              80,
                                                                              1),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              height * 0.020)),
                                                                ),
                                                                // SizedBox(width: width * 0.25),
                                                                // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                                IconButton(
                                                                  icon: Icon(
                                                                    showIcon,
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    size:
                                                                        height *
                                                                            0.03,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    changeIcon(
                                                                        showIcon);
                                                                  },
                                                                )
                                                              ]),
                                                          const Divider(
                                                            thickness: 2,
                                                          ),
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
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Question Type",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: height *
                                                                          0.02),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "MCQ",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'MCQ',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "Survey",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Survey',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          value:
                                                                              "Descriptive",
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Descriptive',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),

                                                    //Question container
                                                    Container(
                                                      width: width * 0.9,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Question",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          Form(
                                                            key:
                                                                questionFormKey,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  right: width *
                                                                      0.02),
                                                              child:
                                                                  TextFormField(
                                                                maxLines: null,
                                                                controller:
                                                                    questionController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                decoration:
                                                                    InputDecoration(
                                                                  //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                      fontSize:
                                                                          height *
                                                                              0.016),
                                                                  hintText:
                                                                      "Type Question here",
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  // focusedBorder: OutlineInputBorder(
                                                                  //     borderSide: const BorderSide(
                                                                  //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                  // border: OutlineInputBorder(
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                ),
                                                                onChanged:
                                                                    (val) {
                                                                  questionFormKey
                                                                      .currentState!
                                                                      .validate();
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    return "Enter Question";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.015,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Answer",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          _questionTypeValue ==
                                                                  "Descriptive"
                                                              ? const SizedBox(
                                                                  height: 0)
                                                              : _questionTypeValue ==
                                                                      "Survey"
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02,
                                                                          top: width *
                                                                              0.01),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                AppLocalizations.of(context)!.choices,
                                                                                //"Choices",
                                                                                style: TextStyle(
                                                                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                  fontSize: height * 0.014,
                                                                                  fontFamily: "Inter",
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.02,
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
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                width * 0.23,
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.choices,
                                                                              //"Choices",
                                                                              style: TextStyle(
                                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                fontSize: height * 0.014,
                                                                                fontFamily: "Inter",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: width * 0.060),
                                                                            child:
                                                                                Container(
                                                                              // alignment:
                                                                              //     Alignment.center,s

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
                                                                          ),
                                                                          SizedBox(
                                                                              width: width * 0.11),
                                                                        ],
                                                                      ),
                                                                    ),
                                                          _questionTypeValue ==
                                                                  "Descriptive"
                                                              ? const SizedBox(
                                                                  height: 0,
                                                                )
                                                              : _questionTypeValue ==
                                                                      "Survey"
                                                                  ? Form(
                                                                      key:
                                                                          _formKey,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          for (int i = 0;
                                                                              i < chooses.length;
                                                                              i++)
                                                                            Padding(
                                                                              padding: EdgeInsets.only(bottom: height * 0.02, left: width * 0.02, top: height * 0.01),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: SizedBox(
                                                                                      //height: height * 0.05,
                                                                                      width: width * 0.18,
                                                                                      child: TextFormField(
                                                                                        controller: chooses[i],
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        maxLines: null,
                                                                                        decoration: InputDecoration(
                                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                          hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                          hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                          //"Type Option Here",
                                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                        ),
                                                                                        onFieldSubmitted: (t) {
                                                                                          String val = chooses[i].text;
                                                                                          EditChoice editChoice = EditChoice();
                                                                                          setState(() {
                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![i].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                        onTapOutside: (t) {
                                                                                          String val = chooses[i].text;
                                                                                          EditChoice editChoice = EditChoice();
                                                                                          setState(() {
                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(width: width * 0.03),
                                                                                  SizedBox(
                                                                                    width: width * 0.05,
                                                                                    child: IconButton(
                                                                                      onPressed: () {
                                                                                        removeItem(i);
                                                                                      },
                                                                                      icon: Icon(
                                                                                        size: height * 0.03,
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
                                                                  : Form(
                                                                      key:
                                                                          _formKey,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          for (int i = 0;
                                                                              i < chooses.length;
                                                                              i++)
                                                                            Padding(
                                                                              padding: EdgeInsets.only(
                                                                                bottom: height * 0.02,
                                                                                left: width * 0.02,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                  SizedBox(width: width * 0.01),
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: SizedBox(
                                                                                      //height: height * 0.05,
                                                                                      width: width * 0.18,
                                                                                      child: TextFormField(
                                                                                        controller: chooses[i],
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        maxLines: null,
                                                                                        decoration: InputDecoration(
                                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                          hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                          hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                          //"Type Option Here",
                                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                        ),
                                                                                        onFieldSubmitted: (t) {
                                                                                          setState(() {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![i].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                              //editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              editQuestion.addChoices?[index] = addChoice;

                                                                                              //editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                //editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?[index] = editChoice;
                                                                                                //editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                        onTapOutside: (t) {
                                                                                          setState(() {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![i].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                              //editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              setState(() {
                                                                                                editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                                editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                              });
                                                                                              //editQuestion.addChoices?[index]=addChoice;
                                                                                              //editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                //editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?[index] = editChoice;
                                                                                                //editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: width * 0.1,
                                                                                    child: IconButton(
                                                                                      onPressed: () {
                                                                                        EditChoice editChoice = EditChoice();
                                                                                        if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                          int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                          editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                          editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                          editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                        } else {
                                                                                          if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                            editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                            editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                            editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                          } else {
                                                                                            editChoiceId.add(tempChoiceId[i]);
                                                                                            editChoice.rightChoice = !radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = chooses[i].text;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          }
                                                                                        }
                                                                                        _onRadioChange(i);
                                                                                        setState(() {
                                                                                          radioList;
                                                                                        });
                                                                                      },
                                                                                      icon: Icon(
                                                                                        size: height * 0.03,
                                                                                        radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                        color: const Color.fromRGBO(82, 165, 160, 1),
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
                                                                                        size: height * 0.03,
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
                                                          _questionTypeValue ==
                                                                  "Descriptive"
                                                              ? Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      bottom:
                                                                          width *
                                                                              0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child: TextField(
                                                                      controller: answerController,
                                                                      keyboardType: TextInputType.text,
                                                                      decoration: InputDecoration(
                                                                        hintStyle: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                102,
                                                                                102,
                                                                                102,
                                                                                0.3),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: height * 0.016),
                                                                        hintText:
                                                                            "Type Answer here",
                                                                        enabledBorder:
                                                                            const UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0.3),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            const UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0.3),
                                                                          ),
                                                                        ),
                                                                      )))
                                                              : Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02),
                                                                  child:
                                                                      TextButton(
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.subject_topic,
                                                                      "+Add choice",
                                                                      //textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          fontSize:
                                                                              height * 0.020),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      addField();
                                                                    },
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),

                                                    //Advisor Container
                                                    Container(
                                                      width: width * 0.9,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Advisor",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    right: width *
                                                                        0.02),
                                                            child: TextField(
                                                              controller:
                                                                  adviceController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              maxLines: null,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "Suggest what to study if answered incorrectly",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    right: width *
                                                                        0.02),
                                                            child: TextField(
                                                              controller:
                                                                  urlController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "URL - Any reference (Optional)",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
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
                                                            height:
                                                                height * 0.015,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Form(
                                                      key: formKey,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromRGBO(153,
                                                                153, 153, 0.5),
                                                          ),
                                                          // borderRadius: BorderRadius.all(
                                                          //     Radius.circular(10)),
                                                        ),
                                                        child: Wrap(
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: width *
                                                                            0.02),
                                                                    child: Text(
                                                                        //AppLocalizations.of(context)!.subject_topic,
                                                                        "Question Details",
                                                                        style: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                28,
                                                                                78,
                                                                                80,
                                                                                1),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize: height * 0.020)),
                                                                  ),
                                                                  // SizedBox(width: width * 0.25),
                                                                  // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                                  IconButton(
                                                                    icon: Icon(
                                                                      showIcon,
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      size: height *
                                                                          0.03,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      changeIcon(
                                                                          showIcon);
                                                                    },
                                                                  )
                                                                ]),
                                                            const Divider(
                                                              thickness: 2,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  top: height *
                                                                      0.02),
                                                              child: Text(
                                                                //AppLocalizations.of(context)!.my_qn_bank,
                                                                "Subject",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  right: width *
                                                                      0.02),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    subjectController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                      fontSize:
                                                                          height *
                                                                              0.016),
                                                                  hintText:
                                                                      "Type here",
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  // focusedBorder: OutlineInputBorder(
                                                                  //     borderSide: const BorderSide(
                                                                  //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                  // border: OutlineInputBorder(
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                ),
                                                                onChanged:
                                                                    (val) {
                                                                  formKey
                                                                      .currentState!
                                                                      .validate();
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    return "Enter Subject";
                                                                  } else if (!RegExp(
                                                                          r"^[^\s].*$")
                                                                      .hasMatch(
                                                                          value!)) {
                                                                    return "Enter alphanumeric charecter only";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  top: height *
                                                                      0.02),
                                                              child: Text(
                                                                //AppLocalizations.of(context)!.my_qn_bank,
                                                                "Topic",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  right: width *
                                                                      0.02),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    topicController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                      fontSize:
                                                                          height *
                                                                              0.016),
                                                                  hintText:
                                                                      "Type here",
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  // focusedBorder: OutlineInputBorder(
                                                                  //     borderSide: const BorderSide(
                                                                  //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                  // border: OutlineInputBorder(
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                ),
                                                                onChanged:
                                                                    (val) {
                                                                  formKey
                                                                      .currentState!
                                                                      .validate();
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    return "Enter topic";
                                                                  } else if (!RegExp(
                                                                          r"^[^\s].*$")
                                                                      .hasMatch(
                                                                          value!)) {
                                                                    return "Enter alphanumeric charecter only";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  top: height *
                                                                      0.02),
                                                              child: Text(
                                                                //AppLocalizations.of(context)!.my_qn_bank,
                                                                "Degree/Class",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  right: width *
                                                                      0.02),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    degreeController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                      fontSize:
                                                                          height *
                                                                              0.016),
                                                                  hintText:
                                                                      "Type here",
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  // focusedBorder: OutlineInputBorder(
                                                                  //     borderSide: const BorderSide(
                                                                  //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                  // border: OutlineInputBorder(
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                ),
                                                                onChanged:
                                                                    (val) {
                                                                  formKey
                                                                      .currentState!
                                                                      .validate();
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    return "Enter Degree/Class";
                                                                  } else if (!RegExp(
                                                                          r"^[^\s].*$")
                                                                      .hasMatch(
                                                                          value!)) {
                                                                    return "Enter alphanumeric charecter only";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  top: height *
                                                                      0.02),
                                                              child: Text(
                                                                //AppLocalizations.of(context)!.my_qn_bank,
                                                                "Semester (optional)",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  right: width *
                                                                      0.02),
                                                              child: TextField(
                                                                controller:
                                                                    semesterController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                      fontSize:
                                                                          height *
                                                                              0.016),
                                                                  hintText:
                                                                      "Type here",
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
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
                                                              height:
                                                                  height * 0.1,
                                                            )
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
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Question Type",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: height *
                                                                          0.02),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "MCQ",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'MCQ',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          value:
                                                                              "Survey",
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Survey',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          value:
                                                                              "Descriptive",
                                                                          activeColor: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          groupValue:
                                                                              _questionTypeValue,
                                                                          onChanged:
                                                                              (value) {
                                                                            // setState(() {
                                                                            //   _questionTypeValue = value.toString();
                                                                            // });
                                                                          },
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Descriptive',
                                                                              //textAlign: TextAlign.left,
                                                                              style: TextStyle(color: const Color.fromRGBO(28, 78, 80, 1), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.016)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),

                                                    //Question container
                                                    Container(
                                                      width: width * 0.9,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Question",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          Form(
                                                            key:
                                                                questionFormKey,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  right: width *
                                                                      0.02),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    questionController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                maxLines: null,
                                                                decoration:
                                                                    InputDecoration(
                                                                  //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                      fontSize:
                                                                          height *
                                                                              0.016),
                                                                  hintText:
                                                                      "Type Question here",
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  // focusedBorder: OutlineInputBorder(
                                                                  //     borderSide: const BorderSide(
                                                                  //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                  // border: OutlineInputBorder(
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                ),
                                                                onChanged:
                                                                    (val) {
                                                                  questionFormKey
                                                                      .currentState!
                                                                      .validate();
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    return "Enter Question";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.015,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Answer",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          _questionTypeValue ==
                                                                  "Descriptive"
                                                              ? const SizedBox(
                                                                  height: 0)
                                                              : _questionTypeValue ==
                                                                      "Survey"
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.02,
                                                                          top: width *
                                                                              0.01),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                AppLocalizations.of(context)!.choices,
                                                                                //"Choices",
                                                                                style: TextStyle(
                                                                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                  fontSize: height * 0.014,
                                                                                  fontFamily: "Inter",
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.02,
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
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.012),
                                                                      child:
                                                                          SizedBox(
                                                                        width: width *
                                                                            0.6,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: SizedBox(
                                                                                child: Text(
                                                                                  AppLocalizations.of(context)!.choices,
                                                                                  //"Choices",
                                                                                  style: TextStyle(
                                                                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                    fontSize: height * 0.014,
                                                                                    fontFamily: "Inter",
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              alignment: Alignment.center,
                                                                              width: width * 0.1,
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
                                                                            SizedBox(width: width * 0.20)
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                          _questionTypeValue ==
                                                                  "Descriptive"
                                                              ? const SizedBox(
                                                                  height: 0,
                                                                )
                                                              : _questionTypeValue ==
                                                                      "Survey"
                                                                  ? Form(
                                                                      key:
                                                                          _formKey,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          for (int i = 0;
                                                                              i < chooses.length;
                                                                              i++)
                                                                            Padding(
                                                                              padding: EdgeInsets.only(bottom: height * 0.02, left: width * 0.02, top: height * 0.01),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: SizedBox(
                                                                                      //height: height * 0.05,
                                                                                      width: width * 0.23,
                                                                                      child: TextFormField(
                                                                                        controller: chooses[i],
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        maxLines: null,
                                                                                        decoration: InputDecoration(
                                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                          hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                          hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                          //"Type Option Here",
                                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                        ),
                                                                                        onFieldSubmitted: (t) {
                                                                                          String val = chooses[i].text;
                                                                                          EditChoice editChoice = EditChoice();
                                                                                          setState(() {
                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![i].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                        onTapOutside: (t) {
                                                                                          String val = chooses[i].text;
                                                                                          EditChoice editChoice = EditChoice();
                                                                                          setState(() {
                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(width: width * 0.03),
                                                                                  SizedBox(
                                                                                    width: width * 0.05,
                                                                                    child: IconButton(
                                                                                      onPressed: () {
                                                                                        removeItem(i);
                                                                                      },
                                                                                      icon: Icon(
                                                                                        size: height * 0.03,
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
                                                                  : Form(
                                                                      key:
                                                                          _formKey,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          for (int i = 0;
                                                                              i < chooses.length;
                                                                              i++)
                                                                            Padding(
                                                                              padding: EdgeInsets.only(
                                                                                bottom: height * 0.02,
                                                                                left: width * 0.02,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                  SizedBox(width: width * 0.01),
                                                                                  SizedBox(
                                                                                    width: width * 0.28,
                                                                                    child: TextFormField(
                                                                                      controller: chooses[i],
                                                                                      style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                      keyboardType: TextInputType.multiline,
                                                                                      maxLines: null,
                                                                                      decoration: InputDecoration(
                                                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                        hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                        hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                        //"Type Option Here",
                                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                      ),
                                                                                      onFieldSubmitted: (t) {
                                                                                        setState(() {
                                                                                          String val = chooses[i].text;
                                                                                          EditChoice editChoice = EditChoice();

                                                                                          chooses[i].text = val;
                                                                                          widget.question.choices![i].choiceText = val;
                                                                                          if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                            //editQuestion.addChoices?.removeAt(index);
                                                                                            addChoice.rightChoice = radioList[i];
                                                                                            addChoice.questionId = tempChoiceId[i];
                                                                                            addChoice.choiceText = val;
                                                                                            editQuestion.addChoices?[index] = addChoice;
                                                                                            //editQuestion.addChoices?.add(addChoice);
                                                                                          } else {
                                                                                            if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                              //editQuestion.editChoices?.removeAt(index);
                                                                                              editChoice.rightChoice = radioList[i];
                                                                                              editChoice.choiceId = tempChoiceId[i];
                                                                                              editChoice.choiceText = val;
                                                                                              editQuestion.editChoices?[index] = editChoice;
                                                                                              //editQuestion.editChoices?.add(editChoice);
                                                                                            } else {
                                                                                              editChoiceId.add(tempChoiceId[i]);
                                                                                              editChoice.rightChoice = radioList[i];
                                                                                              editChoice.choiceId = tempChoiceId[i];
                                                                                              editChoice.choiceText = val;
                                                                                              editQuestion.editChoices?.add(editChoice);
                                                                                            }
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                      onTapOutside: (t) {
                                                                                        setState(() {
                                                                                          String val = chooses[i].text;
                                                                                          EditChoice editChoice = EditChoice();
                                                                                          chooses[i].text = val;
                                                                                          widget.question.choices![i].choiceText = val;
                                                                                          if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                            //editQuestion.addChoices?.removeAt(index);
                                                                                            addChoice.rightChoice = radioList[i];
                                                                                            addChoice.questionId = tempChoiceId[i];
                                                                                            addChoice.choiceText = val;
                                                                                            setState(() {
                                                                                              editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                              editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                            });
                                                                                            //editQuestion.addChoices?[index]=addChoice;
                                                                                            //editQuestion.addChoices?.add(addChoice);
                                                                                          } else {
                                                                                            if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                              //editQuestion.editChoices?.removeAt(index);
                                                                                              editChoice.rightChoice = radioList[i];
                                                                                              editChoice.choiceId = tempChoiceId[i];
                                                                                              editChoice.choiceText = val;
                                                                                              editQuestion.editChoices?[index] = editChoice;
                                                                                              //editQuestion.editChoices?.add(editChoice);
                                                                                            } else {
                                                                                              editChoiceId.add(tempChoiceId[i]);
                                                                                              editChoice.rightChoice = radioList[i];
                                                                                              editChoice.choiceId = tempChoiceId[i];
                                                                                              editChoice.choiceText = val;
                                                                                              editQuestion.editChoices?.add(editChoice);
                                                                                            }
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: width * 0.02,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: width * 0.05,
                                                                                    child: IconButton(
                                                                                      onPressed: () {
                                                                                        EditChoice editChoice = EditChoice();
                                                                                        if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                          int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                          editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                          editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                          editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                        } else {
                                                                                          if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                            editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                            editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                            editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                          } else {
                                                                                            editChoiceId.add(tempChoiceId[i]);
                                                                                            editChoice.rightChoice = !radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = chooses[i].text;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          }
                                                                                        }
                                                                                        _onRadioChange(i);
                                                                                        setState(() {
                                                                                          radioList;
                                                                                        });
                                                                                      },
                                                                                      icon: Icon(
                                                                                        size: height * 0.03,
                                                                                        radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                        color: const Color.fromRGBO(82, 165, 160, 1),
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
                                                                                        size: height * 0.03,
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
                                                          _questionTypeValue ==
                                                                  "Descriptive"
                                                              ? Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02,
                                                                      bottom:
                                                                          width *
                                                                              0.02,
                                                                      right: width *
                                                                          0.02),
                                                                  child: TextField(
                                                                      controller: answerController,
                                                                      keyboardType: TextInputType.text,
                                                                      decoration: InputDecoration(
                                                                        hintStyle: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                102,
                                                                                102,
                                                                                102,
                                                                                0.3),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: height * 0.016),
                                                                        hintText:
                                                                            "Type Answer here",
                                                                        enabledBorder:
                                                                            const UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0.3),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            const UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0.3),
                                                                          ),
                                                                        ),
                                                                      )))
                                                              : Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02),
                                                                  child:
                                                                      TextButton(
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.subject_topic,
                                                                      "+Add choice",
                                                                      //textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          fontSize:
                                                                              height * 0.020),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      addField();
                                                                    },
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),

                                                    //Advisor Container
                                                    Container(
                                                      width: width * 0.9,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Advisor",
                                                                //textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    right: width *
                                                                        0.02),
                                                            child: TextField(
                                                              controller:
                                                                  adviceController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              maxLines: null,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "Suggest what to study if answered incorrectly",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    right: width *
                                                                        0.02),
                                                            child: TextField(
                                                              controller:
                                                                  urlController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "URL - Any reference (Optional)",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
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
                                                            height:
                                                                height * 0.015,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(height: height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        alertDialogDeleteQuestion(
                                            context, height);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 2,
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor:
                                            Colors.white, // <-- Button color
                                      ),
                                      child: Icon(
                                        size: height * 0.05,
                                        Icons.close,
                                        color: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                      ),
                                    ),
                                    SizedBox(height: width * 0.005),
                                    Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                        "Delete",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
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
                                        setState(() {
                                          for (int i = 0;
                                              i < tempChoiceList.length;
                                              i++) {
                                            editQuestion.removeChoices
                                                ?.add(tempChoiceId[i]);
                                          }
                                          tempChoiceId = [];
                                          subjectController.text = '';
                                          topicController.text = '';
                                          degreeController.text = '';
                                          semesterController.text = '';
                                          questionController.text = '';
                                          answerController.text = '';
                                          tempChoiceList = [];
                                          chooses = [];
                                          radioList = [];
                                          adviceController.text = '';
                                          urlController.text = '';
                                          //questionMvp2=Question();
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 2,
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor:
                                            Colors.white, // <-- Button color
                                      ),
                                      child: Icon(
                                        size: height * 0.05,
                                        Icons.refresh,
                                        color: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                      ),
                                    ),
                                    SizedBox(height: width * 0.005),
                                    Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                        "Clear All",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.016)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        editQuestion.subject =
                                            subjectController.text;
                                        editQuestion.topic =
                                            topicController.text;
                                        editQuestion.semester =
                                            semesterController.text;
                                        editQuestion.editQuestionModelClass =
                                            degreeController.text;
                                        editQuestion.question =
                                            questionController.text;
                                        editQuestion.questionType =
                                            _questionTypeValue;
                                        editQuestion.advisorUrl =
                                            urlController.text;
                                        editQuestion.advisorText =
                                            adviceController.text;
                                        editQuestion.questionType =
                                            _questionTypeValue;

                                        //editQuestion.choices = widget.question.choices;
                                        // CreateQuestionModel createQuestion = CreateQuestionModel(questions: []);
                                        // createQuestion.questions?.add(question);
                                        UserDetails userDetails = UserDetails();
                                        userDetails =
                                            Provider.of<LanguageChangeProvider>(
                                                    context,
                                                    listen: false)
                                                .userDetails;
                                        if (((showIcon ==
                                                    Icons
                                                        .expand_circle_down_outlined) ||
                                                formKey.currentState!
                                                    .validate()) &&
                                            questionFormKey.currentState!
                                                .validate()) {
                                          if (_questionTypeValue == 'MCQ' &&
                                              !radioList.contains(true)) {
                                          } else if (_questionTypeValue ==
                                                  'Survey' &&
                                              tempChoiceList.isEmpty) {
                                          } else {
                                            ResponseEntity statusCode =
                                                await QnaService
                                                    .editQuestionTeacherService(
                                                        editQuestion,
                                                        widget.question
                                                            .questionId,
                                                        userDetails);
                                            if (statusCode.code == 200) {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/teacherQuestionBank',
                                                      ModalRoute.withName(
                                                          '/teacherSelectionPage'));
                                            }
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 2,
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1),
                                        ),
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor: const Color.fromRGBO(
                                            82,
                                            165,
                                            160,
                                            1), // <-- Button color
                                      ),
                                      child: Icon(
                                          size: height * 0.05,
                                          Icons.check,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: width * 0.005),
                                    Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                        "Save Changes",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                28, 78, 80, 1),
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
                    ),
                  )));
        } else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  endDrawer: const EndDrawerMenuTeacher(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                        color: appBarChevronColor, size: height * 0.05),
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
                            "Edit Question",
                            style: TextStyle(
                              color: const Color.fromRGBO(28, 78, 80, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(color: Colors.white),
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
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                        153, 153, 153, 0.5),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        showIcon ==
                                                Icons
                                                    .expand_circle_down_outlined
                                            ? Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromRGBO(
                                                            153, 153, 153, 0.5),
                                                      ),
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child: Text(
                                                                //AppLocalizations.of(context)!.subject_topic,
                                                                "Question Details",
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.020)),
                                                          ),
                                                          // SizedBox(width: width * 0.25),
                                                          // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                          IconButton(
                                                            icon: Icon(
                                                              showIcon,
                                                              color: const Color
                                                                  .fromRGBO(28,
                                                                  78, 80, 1),
                                                              size:
                                                                  height * 0.03,
                                                            ),
                                                            onPressed: () {
                                                              changeIcon(
                                                                  showIcon);
                                                            },
                                                          )
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.02),
                                                  //Question type container
                                                  Container(
                                                    width: width * 0.9,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromRGBO(
                                                            153, 153, 153, 0.5),
                                                      ),
                                                      // borderRadius: BorderRadius.all(
                                                      //     Radius.circular(10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                              "Question Type",
                                                              //textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      height *
                                                                          0.020)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Row(
                                                                children: [
                                                                  Radio(
                                                                    activeColor:
                                                                        const Color
                                                                            .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                    value:
                                                                        "MCQ",
                                                                    groupValue:
                                                                        _questionTypeValue,
                                                                    onChanged:
                                                                        (value) {
                                                                      // setState(() {
                                                                      //   _questionTypeValue = value.toString();
                                                                      // });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                        'MCQ',
                                                                        //textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                28,
                                                                                78,
                                                                                80,
                                                                                1),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
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
                                                                    activeColor:
                                                                        const Color
                                                                            .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                    value:
                                                                        "Survey",
                                                                    groupValue:
                                                                        _questionTypeValue,
                                                                    onChanged:
                                                                        (value) {
                                                                      // setState(() {
                                                                      //   _questionTypeValue = value.toString();
                                                                      // });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                        'Survey',
                                                                        //textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                28,
                                                                                78,
                                                                                80,
                                                                                1),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
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
                                                                    value:
                                                                        "Descriptive",
                                                                    activeColor:
                                                                        const Color
                                                                            .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                    groupValue:
                                                                        _questionTypeValue,
                                                                    onChanged:
                                                                        (value) {
                                                                      // setState(() {
                                                                      //   _questionTypeValue = value.toString();
                                                                      // });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                        'Descriptive',
                                                                        //textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                28,
                                                                                78,
                                                                                80,
                                                                                1),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
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
                                                  Container(
                                                    width: width * 0.9,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromRGBO(
                                                            153, 153, 153, 0.5),
                                                      ),
                                                      // borderRadius: BorderRadius.all(
                                                      //     Radius.circular(10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                              "Question",
                                                              //textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      height *
                                                                          0.020)),
                                                        ),
                                                        Form(
                                                          key: questionFormKey,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  questionController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "Type Question here",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                // focusedBorder: OutlineInputBorder(
                                                                //     borderSide: const BorderSide(
                                                                //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                                // border: OutlineInputBorder(
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                              ),
                                                              onChanged: (val) {
                                                                questionFormKey
                                                                    .currentState!
                                                                    .validate();
                                                              },
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    "") {
                                                                  return "Enter Question";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                              "Answer",
                                                              //textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      height *
                                                                          0.020)),
                                                        ),
                                                        _questionTypeValue ==
                                                                "Descriptive"
                                                            ? const SizedBox(
                                                                height: 0)
                                                            : _questionTypeValue ==
                                                                    "Survey"
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.choices,
                                                                              //"Choices",
                                                                              style: TextStyle(
                                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                fontSize: height * 0.014,
                                                                                fontFamily: "Inter",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * 0.02,
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
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.choices,
                                                                              //"Choices",
                                                                              style: TextStyle(
                                                                                color: const Color.fromRGBO(51, 51, 51, 1),
                                                                                fontSize: height * 0.014,
                                                                                fontFamily: "Inter",
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * 0.13,
                                                                          child:
                                                                              Text(
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            AppLocalizations.of(context)!.correct_answer,
                                                                            //"Correct\nAnswer",
                                                                            style:
                                                                                TextStyle(
                                                                              color: const Color.fromRGBO(51, 51, 51, 1),
                                                                              fontSize: height * 0.014,
                                                                              fontFamily: "Inter",
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * 0.11,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                        _questionTypeValue ==
                                                                "Descriptive"
                                                            ? const SizedBox(
                                                                height: 0,
                                                              )
                                                            : _questionTypeValue ==
                                                                    "Survey"
                                                                ? Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < chooses.length;
                                                                            i++)
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              bottom: height * 0.02,
                                                                              left: 8,
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                Expanded(
                                                                                  child: TextFormField(
                                                                                    controller: chooses[i],
                                                                                    style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                    keyboardType: TextInputType.multiline,
                                                                                    maxLines: null,
                                                                                    decoration: InputDecoration(
                                                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                      hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                      hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                      //"Type Option Here",
                                                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                    ),
                                                                                    onFieldSubmitted: (t) {
                                                                                      String val = chooses[i].text;
                                                                                      EditChoice editChoice = EditChoice();
                                                                                      setState(() {
                                                                                        chooses[i].text = val;
                                                                                        widget.question.choices![i].choiceText = val;
                                                                                        if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                          int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                          editQuestion.addChoices?.removeAt(index);
                                                                                          addChoice.rightChoice = radioList[i];
                                                                                          addChoice.questionId = tempChoiceId[i];
                                                                                          addChoice.choiceText = val;
                                                                                          editQuestion.addChoices?.add(addChoice);
                                                                                        } else {
                                                                                          if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                            editQuestion.editChoices?.removeAt(index);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          } else {
                                                                                            editChoiceId.add(tempChoiceId[i]);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          }
                                                                                        }
                                                                                      });
                                                                                    },
                                                                                    onTapOutside: (t) {
                                                                                      String val = chooses[i].text;
                                                                                      EditChoice editChoice = EditChoice();
                                                                                      setState(() {
                                                                                        chooses[i].text = val;
                                                                                        widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                        if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                          int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                          editQuestion.addChoices?.removeAt(index);
                                                                                          addChoice.rightChoice = radioList[i];
                                                                                          addChoice.questionId = tempChoiceId[i];
                                                                                          addChoice.choiceText = val;
                                                                                          editQuestion.addChoices?.add(addChoice);
                                                                                        } else {
                                                                                          if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                            editQuestion.editChoices?.removeAt(index);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          } else {
                                                                                            editChoiceId.add(tempChoiceId[i]);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          }
                                                                                        }
                                                                                      });
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
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < chooses.length;
                                                                            i++)
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              bottom: height * 0.02,
                                                                              left: 8,
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                Expanded(
                                                                                  child: TextFormField(
                                                                                    controller: chooses[i],
                                                                                    style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                    keyboardType: TextInputType.multiline,
                                                                                    maxLines: null,
                                                                                    decoration: InputDecoration(
                                                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                      hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                      hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                      //"Type Option Here",
                                                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                    ),
                                                                                    onFieldSubmitted: (t) {
                                                                                      setState(() {
                                                                                        String val = chooses[i].text;
                                                                                        EditChoice editChoice = EditChoice();
                                                                                        chooses[i].text = val;
                                                                                        widget.question.choices![i].choiceText = val;
                                                                                        if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                          int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                          //editQuestion.addChoices?.removeAt(index);
                                                                                          addChoice.rightChoice = radioList[i];
                                                                                          addChoice.questionId = tempChoiceId[i];
                                                                                          addChoice.choiceText = val;
                                                                                          editQuestion.addChoices?[index] = addChoice;

                                                                                          //editQuestion.addChoices?.add(addChoice);
                                                                                        } else {
                                                                                          if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                            //editQuestion.editChoices?.removeAt(index);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?[index] = editChoice;
                                                                                            //editQuestion.editChoices?.add(editChoice);
                                                                                          } else {
                                                                                            editChoiceId.add(tempChoiceId[i]);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          }
                                                                                        }
                                                                                      });
                                                                                    },
                                                                                    onTapOutside: (t) {
                                                                                      setState(() {
                                                                                        String val = chooses[i].text;
                                                                                        EditChoice editChoice = EditChoice();
                                                                                        chooses[i].text = val;
                                                                                        widget.question.choices![i].choiceText = val;
                                                                                        if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                          int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                          //editQuestion.addChoices?.removeAt(index);
                                                                                          addChoice.rightChoice = radioList[i];
                                                                                          addChoice.questionId = tempChoiceId[i];
                                                                                          addChoice.choiceText = val;
                                                                                          setState(() {
                                                                                            editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                            editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                          });
                                                                                          //editQuestion.addChoices?[index]=addChoice;
                                                                                          //editQuestion.addChoices?.add(addChoice);
                                                                                        } else {
                                                                                          if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                            //editQuestion.editChoices?.removeAt(index);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?[index] = editChoice;
                                                                                            //editQuestion.editChoices?.add(editChoice);
                                                                                          } else {
                                                                                            editChoiceId.add(tempChoiceId[i]);
                                                                                            editChoice.rightChoice = radioList[i];
                                                                                            editChoice.choiceId = tempChoiceId[i];
                                                                                            editChoice.choiceText = val;
                                                                                            editQuestion.editChoices?.add(editChoice);
                                                                                          }
                                                                                        }
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: width * 0.13,
                                                                                  child: IconButton(
                                                                                    onPressed: () {
                                                                                      EditChoice editChoice = EditChoice();
                                                                                      if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                        int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                        editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                        editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                        editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                      } else {
                                                                                        if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                          int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                          editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                          editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                          editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                        } else {
                                                                                          editChoiceId.add(tempChoiceId[i]);
                                                                                          editChoice.rightChoice = !radioList[i];
                                                                                          editChoice.choiceId = tempChoiceId[i];
                                                                                          editChoice.choiceText = chooses[i].text;
                                                                                          editQuestion.editChoices?.add(editChoice);
                                                                                        }
                                                                                      }
                                                                                      _onRadioChange(i);
                                                                                    },
                                                                                    icon: Icon(
                                                                                      radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                      color: const Color.fromRGBO(82, 165, 160, 1),
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
                                                        _questionTypeValue ==
                                                                "Descriptive"
                                                            ? Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.02,
                                                                    bottom:
                                                                        width *
                                                                            0.02),
                                                                child:
                                                                    TextField(
                                                                        controller:
                                                                            answerController,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .text,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.016),
                                                                          hintText:
                                                                              "Type Answer here",
                                                                          enabledBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                            ),
                                                                          ),
                                                                          focusedBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                            ),
                                                                          ),
                                                                        )))
                                                            : TextButton(
                                                                child: Text(
                                                                  //AppLocalizations.of(context)!.subject_topic,
                                                                  "+Add choice",
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color.fromRGBO(
                                                                          82,
                                                                          165,
                                                                          160,
                                                                          1),
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      fontSize:
                                                                          height *
                                                                              0.020),
                                                                ),
                                                                onPressed: () {
                                                                  addField();
                                                                },
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),

                                                  //Advisor Container
                                                  Container(
                                                    width: width * 0.9,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromRGBO(
                                                            153, 153, 153, 0.5),
                                                      ),
                                                      // borderRadius: BorderRadius.all(
                                                      //     Radius.circular(10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                              "Advisor",
                                                              //textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      height *
                                                                          0.020)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.02),
                                                          child: TextField(
                                                            controller:
                                                                adviceController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            maxLines: null,
                                                            decoration:
                                                                InputDecoration(
                                                              //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                  fontSize:
                                                                      height *
                                                                          0.016),
                                                              hintText:
                                                                  "Suggest what to study if answered incorrectly",
                                                              enabledBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.02),
                                                          child: TextField(
                                                            controller:
                                                                urlController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                  fontSize:
                                                                      height *
                                                                          0.016),
                                                              hintText:
                                                                  "URL - Any reference (Optional)",
                                                              enabledBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
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
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Form(
                                                    key: formKey,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromRGBO(153,
                                                              153, 153, 0.5),
                                                        ),
                                                        // borderRadius: BorderRadius.all(
                                                        //     Radius.circular(10)),
                                                      ),
                                                      child: Wrap(
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                // SizedBox(width: width<700?width * 0.02:width * 0.03,),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.02),
                                                                  child: Text(
                                                                      //AppLocalizations.of(context)!.subject_topic,
                                                                      "Question Details",
                                                                      style: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              28,
                                                                              78,
                                                                              80,
                                                                              1),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              height * 0.020)),
                                                                ),
                                                                // SizedBox(width: width * 0.25),
                                                                // SizedBox(width: width<700?width * 0.3:width * 0.70),
                                                                IconButton(
                                                                  icon: Icon(
                                                                    showIcon,
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        28,
                                                                        78,
                                                                        80,
                                                                        1),
                                                                    size:
                                                                        height *
                                                                            0.03,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    changeIcon(
                                                                        showIcon);
                                                                  },
                                                                )
                                                              ]),
                                                          const Divider(
                                                            thickness: 2,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: height *
                                                                        0.02),
                                                            child: Text(
                                                              //AppLocalizations.of(context)!.my_qn_bank,
                                                              "Subject",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.02,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  subjectController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "Type here",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                // focusedBorder: OutlineInputBorder(
                                                                //     borderSide: const BorderSide(
                                                                //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                                // border: OutlineInputBorder(
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                              ),
                                                              onChanged: (val) {
                                                                formKey
                                                                    .currentState!
                                                                    .validate();
                                                              },
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    "") {
                                                                  return "Enter Subject";
                                                                } else if (!RegExp(
                                                                        r"^[^\s].*$")
                                                                    .hasMatch(
                                                                        value!)) {
                                                                  return "Enter alphanumeric charecter only";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: height *
                                                                        0.02),
                                                            child: Text(
                                                              //AppLocalizations.of(context)!.my_qn_bank,
                                                              "Topic",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.02,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  topicController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "Type here",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                // focusedBorder: OutlineInputBorder(
                                                                //     borderSide: const BorderSide(
                                                                //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                                // border: OutlineInputBorder(
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                              ),
                                                              onChanged: (val) {
                                                                formKey
                                                                    .currentState!
                                                                    .validate();
                                                              },
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    "") {
                                                                  return "Enter Topic";
                                                                } else if (!RegExp(
                                                                        r"^[^\s].*$")
                                                                    .hasMatch(
                                                                        value!)) {
                                                                  return "Enter alphanumeric charecter only";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: height *
                                                                        0.02),
                                                            child: Text(
                                                              //AppLocalizations.of(context)!.my_qn_bank,
                                                              "Degree/Class",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.02,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  degreeController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "Type here",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                // focusedBorder: OutlineInputBorder(
                                                                //     borderSide: const BorderSide(
                                                                //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                                // border: OutlineInputBorder(
                                                                //     borderRadius: BorderRadius.circular(15)),
                                                              ),
                                                              onChanged: (val) {
                                                                formKey
                                                                    .currentState!
                                                                    .validate();
                                                              },
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    "") {
                                                                  return "Enter Degree/Class";
                                                                } else if (!RegExp(
                                                                        r"^[^\s].*$")
                                                                    .hasMatch(
                                                                        value!)) {
                                                                  return "Enter alphanumeric charecter only";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        width *
                                                                            0.02,
                                                                    top: height *
                                                                        0.02),
                                                            child: Text(
                                                              //AppLocalizations.of(context)!.my_qn_bank,
                                                              "Semester (optional)",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    28,
                                                                    78,
                                                                    80,
                                                                    1),
                                                                fontSize:
                                                                    height *
                                                                        0.02,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            child: TextField(
                                                              controller:
                                                                  semesterController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                    fontSize:
                                                                        height *
                                                                            0.016),
                                                                hintText:
                                                                    "Type here",
                                                                enabledBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.3),
                                                                  ),
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
                                                            height:
                                                                height * 0.1,
                                                          )
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
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromRGBO(
                                                            153, 153, 153, 0.5),
                                                      ),
                                                      // borderRadius: BorderRadius.all(
                                                      //     Radius.circular(10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                              "Question Type",
                                                              //textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      height *
                                                                          0.020)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Row(
                                                                children: [
                                                                  Radio(
                                                                    activeColor:
                                                                        const Color
                                                                            .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                    value:
                                                                        "MCQ",
                                                                    groupValue:
                                                                        _questionTypeValue,
                                                                    onChanged:
                                                                        (value) {
                                                                      // setState(() {
                                                                      //   _questionTypeValue = value.toString();
                                                                      // });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                        'MCQ',
                                                                        //textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                28,
                                                                                78,
                                                                                80,
                                                                                1),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
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
                                                                    activeColor:
                                                                        const Color
                                                                            .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                    value:
                                                                        "Survey",
                                                                    groupValue:
                                                                        _questionTypeValue,
                                                                    onChanged:
                                                                        (value) {
                                                                      // setState(() {
                                                                      //   _questionTypeValue = value.toString();
                                                                      // });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                        'Survey',
                                                                        //textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                28,
                                                                                78,
                                                                                80,
                                                                                1),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
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
                                                                    value:
                                                                        "Descriptive",
                                                                    activeColor:
                                                                        const Color
                                                                            .fromRGBO(
                                                                            82,
                                                                            165,
                                                                            160,
                                                                            1),
                                                                    groupValue:
                                                                        _questionTypeValue,
                                                                    onChanged:
                                                                        (value) {
                                                                      // setState(() {
                                                                      //   _questionTypeValue = value.toString();
                                                                      // });
                                                                    },
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                        'Descriptive',
                                                                        //textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                            color: const Color.fromRGBO(
                                                                                28,
                                                                                78,
                                                                                80,
                                                                                1),
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w400,
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
                                                      key: questionFormKey,
                                                      child: Container(
                                                        width: width * 0.9,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromRGBO(153,
                                                                153, 153, 0.5),
                                                          ),
                                                          // borderRadius: BorderRadius.all(
                                                          //     Radius.circular(10)),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  //AppLocalizations.of(context)!.subject_topic,
                                                                  "Question",
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          height *
                                                                              0.020)),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: width *
                                                                          0.02),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    questionController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                      fontSize:
                                                                          height *
                                                                              0.016),
                                                                  hintText:
                                                                      "Type Question here",
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  focusedBorder:
                                                                      const UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.3),
                                                                    ),
                                                                  ),
                                                                  // focusedBorder: OutlineInputBorder(
                                                                  //     borderSide: const BorderSide(
                                                                  //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                  // border: OutlineInputBorder(
                                                                  //     borderRadius: BorderRadius.circular(15)),
                                                                ),
                                                                onChanged:
                                                                    (val) {
                                                                  questionFormKey
                                                                      .currentState
                                                                      ?.validate();
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    return "Enter Question";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: height *
                                                                  0.015,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  //AppLocalizations.of(context)!.subject_topic,
                                                                  "Answer",
                                                                  //textAlign: TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          28,
                                                                          78,
                                                                          80,
                                                                          1),
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          height *
                                                                              0.020)),
                                                            ),
                                                            _questionTypeValue ==
                                                                    "Descriptive"
                                                                ? const SizedBox(
                                                                    height: 0)
                                                                : _questionTypeValue ==
                                                                        "Survey"
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Text(
                                                                                  AppLocalizations.of(context)!.choices,
                                                                                  //"Choices",
                                                                                  style: TextStyle(
                                                                                    color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                    : Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Text(
                                                                                  AppLocalizations.of(context)!.choices,
                                                                                  //"Choices",
                                                                                  style: TextStyle(
                                                                                    color: const Color.fromRGBO(51, 51, 51, 1),
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
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                            _questionTypeValue ==
                                                                    "Descriptive"
                                                                ? const SizedBox(
                                                                    height: 0,
                                                                  )
                                                                : _questionTypeValue ==
                                                                        "Survey"
                                                                    ? Form(
                                                                        key:
                                                                            _formKey,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            for (int i = 0;
                                                                                i < chooses.length;
                                                                                i++)
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  bottom: height * 0.02,
                                                                                  left: 8,
                                                                                ),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                    Expanded(
                                                                                      child: TextFormField(
                                                                                        controller: chooses[i],
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        maxLines: null,
                                                                                        decoration: InputDecoration(
                                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                          hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                          hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                          //"Type Option Here",
                                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                        ),
                                                                                        onFieldSubmitted: (t) {
                                                                                          setState(() {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();
                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![i].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                        onTapOutside: (t) {
                                                                                          setState(() {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();

                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![widget.question.choices!.length].choiceText = val;
                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];
                                                                                              addChoice.choiceText = val;
                                                                                              editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
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
                                                                        key:
                                                                            _formKey,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            for (int i = 0;
                                                                                i < chooses.length;
                                                                                i++)
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  bottom: height * 0.02,
                                                                                  left: 8,
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Text("${String.fromCharCode(97 + i)}.", style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.020)),
                                                                                    SizedBox(width: height * 0.01),
                                                                                    Expanded(
                                                                                      child: TextFormField(
                                                                                        controller: chooses[i],
                                                                                        style: TextStyle(color: Colors.black, fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.018),
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        maxLines: null,
                                                                                        decoration: InputDecoration(
                                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                          hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3), fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: height * 0.02),
                                                                                          hintText: AppLocalizations.of(context)!.type_op_here,
                                                                                          //"Type Option Here",
                                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                        ),
                                                                                        onTapOutside: (t) {
                                                                                          setState(() {
                                                                                            String val = chooses[i].text;
                                                                                            EditChoice editChoice = EditChoice();

                                                                                            chooses[i].text = val;
                                                                                            widget.question.choices![i].choiceText = val;

                                                                                            if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = addChoiceId.indexOf(tempChoiceId[i]);

                                                                                              //editQuestion.addChoices?.removeAt(index);
                                                                                              addChoice.rightChoice = radioList[i];
                                                                                              addChoice.questionId = tempChoiceId[i];

                                                                                              addChoice.choiceText = val;

                                                                                              setState(() {
                                                                                                editQuestion.addChoices?[index].choiceText = addChoice.choiceText;
                                                                                                editQuestion.addChoices?[index].rightChoice = addChoice.rightChoice;
                                                                                              });

                                                                                              //editQuestion.addChoices?.add(addChoice);
                                                                                            } else {
                                                                                              if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                                int index = tempChoiceId.indexOf(tempChoiceId[i]);

                                                                                                //editQuestion.editChoices?.removeAt(index);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?[index] = editChoice;

                                                                                                //editQuestion.editChoices?.add(editChoice);
                                                                                              } else {
                                                                                                //int index = tempChoiceId.indexOf(tempChoiceId[i]);
                                                                                                editChoiceId.add(tempChoiceId[i]);
                                                                                                editChoice.rightChoice = radioList[i];
                                                                                                editChoice.choiceId = tempChoiceId[i];
                                                                                                editChoice.choiceText = val;
                                                                                                editQuestion.editChoices?.add(editChoice);
                                                                                              }
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: width * 0.13,
                                                                                      child: IconButton(
                                                                                        onPressed: () {
                                                                                          EditChoice editChoice = EditChoice();
                                                                                          if (addChoiceId.contains(tempChoiceId[i])) {
                                                                                            int index = addChoiceId.indexOf(tempChoiceId[i]);
                                                                                            editQuestion.addChoices![index].choiceText = chooses[i].text;
                                                                                            editQuestion.addChoices![index].questionId = tempChoiceId[i];
                                                                                            editQuestion.addChoices![index].rightChoice = !radioList[i];
                                                                                          } else {
                                                                                            if (editChoiceId.contains(tempChoiceId[i])) {
                                                                                              int index = editChoiceId.indexOf(tempChoiceId[i]);
                                                                                              editQuestion.editChoices![index].choiceText = chooses[i].text;
                                                                                              editQuestion.editChoices![index].choiceId = tempChoiceId[i];
                                                                                              editQuestion.editChoices![index].rightChoice = !radioList[i];
                                                                                            } else {
                                                                                              editChoiceId.add(tempChoiceId[i]);
                                                                                              editChoice.rightChoice = !radioList[i];
                                                                                              editChoice.choiceId = tempChoiceId[i];
                                                                                              editChoice.choiceText = chooses[i].text;
                                                                                              editQuestion.editChoices?.add(editChoice);
                                                                                            }
                                                                                          }
                                                                                          _onRadioChange(i);
                                                                                          setState(() {
                                                                                            radioList;
                                                                                          });
                                                                                        },
                                                                                        icon: Icon(
                                                                                          radioList[i] ? Icons.radio_button_checked_outlined : Icons.radio_button_unchecked_outlined,
                                                                                          color: const Color.fromRGBO(82, 165, 160, 1),
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
                                                            _questionTypeValue ==
                                                                    "Descriptive"
                                                                ? Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: width *
                                                                            0.02,
                                                                        bottom: width *
                                                                            0.02),
                                                                    child: TextField(
                                                                        controller: answerController,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: InputDecoration(
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.016),
                                                                          hintText:
                                                                              "Type Answer here",
                                                                          enabledBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                            ),
                                                                          ),
                                                                          focusedBorder:
                                                                              const UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromRGBO(0, 0, 0, 0.3),
                                                                            ),
                                                                          ),
                                                                        )))
                                                                : TextButton(
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.subject_topic,
                                                                      "+Add choice",
                                                                      //textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              82,
                                                                              165,
                                                                              160,
                                                                              1),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          fontSize:
                                                                              height * 0.020),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      addField();
                                                                    },
                                                                  ),
                                                          ],
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),

                                                  //Advisor Container
                                                  Container(
                                                    width: width * 0.9,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromRGBO(
                                                            153, 153, 153, 0.5),
                                                      ),
                                                      // borderRadius: BorderRadius.all(
                                                      //     Radius.circular(10)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              //AppLocalizations.of(context)!.subject_topic,
                                                              "Advisor",
                                                              //textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      28,
                                                                      78,
                                                                      80,
                                                                      1),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      height *
                                                                          0.020)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.02),
                                                          child: TextField(
                                                            controller:
                                                                adviceController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            maxLines: null,
                                                            decoration:
                                                                InputDecoration(
                                                              //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                  fontSize:
                                                                      height *
                                                                          0.016),
                                                              hintText:
                                                                  "Suggest what to study if answered incorrectly",
                                                              enabledBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.02),
                                                          child: TextField(
                                                            controller:
                                                                urlController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              //floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                                  fontSize:
                                                                      height *
                                                                          0.016),
                                                              hintText:
                                                                  "URL - Any reference (Optional)",
                                                              enabledBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
                                                              ),
                                                              focusedBorder:
                                                                  const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.3),
                                                                ),
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
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.015,
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(height: height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      alertDialogDeleteQuestion(
                                          context, height);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.white, // <-- Button color
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                  ),
                                  Text(
                                      //AppLocalizations.of(context)!.subject_topic,
                                      "Delete",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              28, 78, 80, 1),
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
                                      setState(() {
                                        for (int i = 0;
                                            i < tempChoiceList.length;
                                            i++) {
                                          editQuestion.removeChoices
                                              ?.add(tempChoiceId[i]);
                                        }
                                        tempChoiceId = [];
                                        subjectController.text = '';
                                        topicController.text = '';
                                        degreeController.text = '';
                                        semesterController.text = '';
                                        questionController.text = '';
                                        answerController.text = '';
                                        tempChoiceList = [];
                                        chooses = [];
                                        radioList = [];
                                        adviceController.text = '';
                                        urlController.text = '';
                                        //questionMvp2=Question();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.white, // <-- Button color
                                    ),
                                    child: const Icon(
                                      Icons.refresh,
                                      color: Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                  ),
                                  Text(
                                      //AppLocalizations.of(context)!.subject_topic,
                                      "Clear All",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              28, 78, 80, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: height * 0.016)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      editQuestion.subject =
                                          subjectController.text;
                                      editQuestion.topic = topicController.text;
                                      editQuestion.semester =
                                          semesterController.text;
                                      editQuestion.editQuestionModelClass =
                                          degreeController.text;
                                      editQuestion.question =
                                          questionController.text;
                                      editQuestion.questionType =
                                          _questionTypeValue;
                                      editQuestion.advisorUrl =
                                          urlController.text;
                                      editQuestion.advisorText =
                                          adviceController.text;

                                      UserDetails userDetails = UserDetails();
                                      userDetails =
                                          Provider.of<LanguageChangeProvider>(
                                                  context,
                                                  listen: false)
                                              .userDetails;

                                      if ((formKey.currentState!.validate()) &&
                                          questionFormKey.currentState!
                                              .validate()) {
                                        ResponseEntity statusCode =
                                            await QnaService
                                                .editQuestionTeacherService(
                                                    editQuestion,
                                                    widget.question.questionId,
                                                    userDetails);

                                        if (statusCode.code == 200) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/teacherQuestionBank',
                                                  ModalRoute.withName(
                                                      '/teacherSelectionPage'));
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                      ),
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color.fromRGBO(
                                          82, 165, 160, 1), // <-- Button color
                                    ),
                                    child: const Icon(Icons.check,
                                        color: Colors.white),
                                  ),
                                  Text(
                                      //AppLocalizations.of(context)!.subject_topic,
                                      "Save Changes",
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              28, 78, 80, 1),
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
    if (pramIcon == Icons.arrow_circle_up_outlined) {
      setState(() {
        showIcon = Icons.expand_circle_down_outlined;
      });
    } else {
      setState(() {
        showIcon = Icons.arrow_circle_up_outlined;
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
