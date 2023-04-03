import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/custom_radio_option.dart';
import '../Entity/Teacher/choice_entity.dart';
import '../Entity/Teacher/question_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class PreparePreviewQnBank extends StatefulWidget {
  PreparePreviewQnBank(
      {Key? key,
      required this.question,
      this.finalQuestion})
      : super(key: key);

  final Question question;
  Question? finalQuestion;

  @override
  PreparePreviewQnBankState createState() => PreparePreviewQnBankState();
}

class PreparePreviewQnBankState extends State<PreparePreviewQnBank> {
  late String _groupValue;
  List<Choice>? selected = [];
  TextEditingController subjectController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController subtopicController = TextEditingController();
  TextEditingController classRoomController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  IconData showIcon = Icons.expand_circle_down_outlined;

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  final List<TextEditingController> chooses = [];
  final List<bool> radioList = [];
  final _formKey = GlobalKey<FormState>();

  _onRadioChange(int key) {
    setState(() {
      radioList[key] = !radioList[key];
    });
  }

  addField() {
    setState(() {
      chooses.add(TextEditingController());
      radioList.add(false);
    });
  }

  removeItem(i) {
    setState(() {
      chooses.removeAt(i);
      radioList.removeAt(i);
    });
  }

  @override
  void initState() {
    super.initState();
    _groupValue = widget.finalQuestion!.questionType!;
    subjectController.text = widget.finalQuestion!.subject!;
    topicController.text = widget.finalQuestion!.topic!;
    subtopicController.text = widget.finalQuestion!.subTopic!;
    classRoomController.text = widget.finalQuestion!.datumClass!;
    questionController.text = widget.finalQuestion!.question!;
    urlController.text = widget.finalQuestion!.advisorUrl!;
    adviceController.text = widget.finalQuestion!.advisorText!;
    selected = widget.finalQuestion!.choices;
    for (int i = 0; i < widget.finalQuestion!.choices!.length; i++) {
      chooses.add(TextEditingController());
      chooses[i].text = widget.finalQuestion!.choices![i]!.choiceText!;
      radioList.add(false);
      if (widget.finalQuestion!.choices![i].rightChoice!) {
        radioList[i] = true;
      }
    }
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
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.edit_en_caps,
                      //"EDIT QUESTION",
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
                            value: AppLocalizations.of(context)!.mcq,
                            //'mcq',
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
                            label: 'Survey',
                          ),
                          MyRadioOption<String>(
                            icon: Icons.library_books_sharp,
                            value: AppLocalizations.of(context)!.descriptive,
                            //'Descriptive',
                            groupValue: _groupValue,
                            onChanged: _valueChangedHandler(),
                            label: 'Descriptive',
                          ),
                        ],
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
                                icon: Icon(
                                  Icons.clear_sharp,
                                  size: height * 0.028,
                                  color: const Color.fromRGBO(28, 78, 80, 1),
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
                                    //selected='';
                                  });
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.clear_all,
                                //"Clear All",
                                style: TextStyle(
                                  color: const Color.fromRGBO(28, 78, 80, 1),
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
                      //width: width * 10,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color.fromRGBO(82, 165, 160, 1)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  //height: height * 0.060,
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  child: Row(children: [
                                    SizedBox(width: width * 0.10),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .subject_topic,
                                        //"Subject and Topic",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.020)),
                                    SizedBox(width: width * 0.25),
                                    //SizedBox(width: height * 0.025),
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
                                    // IconButton(
                                    //   icon: const Icon(
                                    //     Icons.arrow_circle_up_sharp,
                                    //     size: 30,
                                    //     color: Color.fromRGBO(255, 255, 255, 1),
                                    //   ),
                                    //   onPressed: () {
                                    //     changeIcon(showIcon);
                                    //   },
                                    // ),
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
                                          labelText:
                                              AppLocalizations.of(context)!
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
                                          hintText:
                                              AppLocalizations.of(context)!
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
                                          labelText:
                                              AppLocalizations.of(context)!
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
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .topic_hint,
                                          //"Type Topic Here",
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
                                          labelText:
                                              AppLocalizations.of(context)!
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
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .sub_topic_hint,
                                          //'Type Sub Topic Here',
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
                                          labelText:
                                              AppLocalizations.of(context)!
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
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .type_here,
                                          //"Type Here",
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
                              AppLocalizations.of(context)!.qn_qn_page,
                              //"Question",
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
                              hintText: AppLocalizations.of(context)!.type_here,
                              //"Type Question Here",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onChanged: (val) {
                              setState(() {
                                widget.question.question = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.010),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //   children: [
                        Text(
                          AppLocalizations.of(context)!.choices,
                          // "Choices",
                          style: TextStyle(
                            color: const Color.fromRGBO(51, 51, 51, 1),
                            fontSize: height * 0.018,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        Text(
                          AppLocalizations.of(context)!.correct_answer,
                          // "Correct Answer",
                          style: TextStyle(
                            color: const Color.fromRGBO(51, 51, 51, 1),
                            fontSize: height * 0.018,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.010),
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
                                      //radioIcon,
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
                                      //radioIcon,
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
                                // "Advisor",
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
                      ),
                      onChanged: (val) {
                        setState(() {
                          widget.question.advisorText = val;
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
                        hintText: AppLocalizations.of(context)!.url_reference,
                        //"URL - Any reference (Optional)",
                      ),
                      onChanged: (val) {
                        setState(() {
                          widget.question.advisorUrl = val;
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
                                    //List<String> temp=[];
                                    // for(int i=0;i< _values.length;i++){
                                    //   temp.add(_values[i]['value']);
                                    // }
                                    setState(() {
                                      List<Choice> temp = [];
                                      for (int i = 0; i < chooses.length; i++) {
                                        Choice ch = Choice();
                                        temp.add(ch);
                                        temp[i].choiceText = chooses[i].text;
                                        temp[i].rightChoice = false;
                                        if (radioList[i]) {
                                          temp[i].rightChoice = radioList[i];
                                        }
                                      }
                                      widget.finalQuestion?.subject =
                                          subjectController.text;
                                      widget.finalQuestion?.topic =
                                          topicController.text;
                                      widget.finalQuestion?.subTopic =
                                          subtopicController.text;
                                      widget.finalQuestion?.datumClass =
                                          classRoomController.text;
                                      widget.finalQuestion?.question =
                                          questionController.text;
                                      widget.finalQuestion?.advisorText =
                                          adviceController.text;
                                      widget.finalQuestion?.advisorUrl =
                                          urlController.text;
                                      widget.finalQuestion?.choices = temp;
                                    });

                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     type: PageTransitionType.rightToLeft,
                                    //     child: TeacherPreparePreview(
                                    //         finalQuestion: widget.finalQuestion,
                                    //         question: widget.question,
                                    //         setLocale: widget.setLocale),
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.preview,
                                    //"Preview"
                                  ),
                                ),
                              ]),
                          onPressed: () {}),
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
  final List<int?>? selected;
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
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.selected!.contains(j)) {
                  widget.selected!.remove(j);
                } else {
                  widget.selected!.add(j);
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.height * 0.013),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: widget.width * 0.744,
                      height: widget.height * 0.0412,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: const Color.fromRGBO(209, 209, 209, 1)),
                        color: (widget.question.choices!
                                .contains(widget.question.choices![j]))
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
                                '${widget.question.choices![j - 1]}',
                                style: TextStyle(
                                  color: (widget.question.choices!.contains(
                                          widget.question.choices![j]))
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(102, 102, 102, 1),
                                  fontSize: widget.height * 0.0162,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ])),
                  widget.selected!.contains(j)
                      ? const Icon(
                          Icons.radio_button_checked,
                          color: Color.fromRGBO(82, 165, 160, 1),
                        )
                      : const Icon(
                          Icons.radio_button_off_outlined,
                          color: Color.fromRGBO(82, 165, 160, 1),
                        ),
                  SizedBox(
                    width: widget.width * 0.02,
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}
