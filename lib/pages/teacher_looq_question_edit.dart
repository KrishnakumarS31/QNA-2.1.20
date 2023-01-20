import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Entity/demo_question_model.dart';
import 'package:qna_test/Pages/teacher_looq_preview.dart';

import '../Components/custom_radio_option.dart';
import 'teacher_qn_preview.dart';

class LooqQuestionEdit extends StatefulWidget {
  const LooqQuestionEdit({
    Key? key, required this.question,
  }) : super(key: key);

  final DemoQuestionModel question;
  @override
  LooqQuestionEditState createState() => LooqQuestionEditState();
}

class LooqQuestionEditState extends State<LooqQuestionEdit> {
  late int _count;
  String? _groupValue;
  List<int?>? selected=[];
  TextEditingController subjectController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController subtopicController = TextEditingController();
  TextEditingController classRoomController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  IconData showIcon=Icons.expand_circle_down_outlined;
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  @override
  void initState() {
    super.initState();
    _groupValue=widget.question.questionType;
    subjectController.text=widget.question.subject!;
    topicController.text=widget.question.topic!;
    subtopicController.text=widget.question.subTopic!;
    classRoomController.text=widget.question.studentClass!;
    questionController.text=widget.question.question!;
    urlController.text=widget.question.url!;
    adviceController.text=widget.question.advice!;
    selected=widget.question.correctChoice;
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: const Color.fromRGBO(82, 165, 160, 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      MyRadioOption<String>(
                        icon: Icons.check_box_outlined,
                        value: 'mcq',
                        groupValue: _groupValue,
                        onChanged: _valueChangedHandler(),
                        label: 'MCQ',
                      ),
                      MyRadioOption<String>(
                        icon: Icons.account_tree_outlined,
                        value: 'Survey',
                        groupValue: _groupValue,
                        onChanged: _valueChangedHandler(),
                        label: 'Survey',
                      ),
                      MyRadioOption<String>(
                        icon: Icons.library_books_sharp,
                        value: 'Descriptive',
                        groupValue: _groupValue,
                        onChanged: _valueChangedHandler(),
                        label: 'Descriptive',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.clear_sharp,
                          size: height * 0.028,
                          color: const Color.fromRGBO(28, 78, 80, 1),
                        ),
                        onPressed: () {
                          setState(() {
                            subjectController.text='';
                            topicController.text='';
                            subtopicController.text='';
                            classRoomController.text='';
                            questionController.text='';
                            urlController.text='';
                            adviceController.text='';
                            //selected='';
                          });
                        },
                      ),
                      Text(
                        "Clear All",
                        style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.018,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
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
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //height: height * 0.060,
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              child: Row(children: [
                                SizedBox(width: width * 0.10),
                                Text("Subject and Topic",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.020)),
                                SizedBox(width: width * 0.25),
                                //SizedBox(width: height * 0.025),
                                IconButton(
                                  icon:  Icon(showIcon,color: const Color.fromRGBO(255, 255, 255, 1),size: height * 0.03,),
                                  onPressed: () {
                                    changeIcon(showIcon);
                                  },)
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
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.018
                                    ),
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
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.018
                                    ),
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
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.018
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'SUB TOPIC',
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
                                      hintText: 'Type Sub Topic Here',
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
                                        color: const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.018
                                    ),
                                    decoration: InputDecoration(
                                      labelText: "CLASS",
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
                  margin:
                  EdgeInsets.only(left: width * 0.05, right: width * 0.04),
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
                            fontSize: height * 0.018
                        ),
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
                          hintText: "Type Question Here",
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(82, 165, 160, 1)),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onChanged: (val){
                          setState(() {
                            widget.question.question=val;
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
                      "Add Choices",
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
                      "Correct Answer",
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
                ChooseWidget(question: widget.question, selected: selected, height: height, width: width),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _count++;
                            print(_count);
                          });
                        }, child: Text(
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
                        margin:
                        EdgeInsets.only(left: width * 0.05, right: width * 0.04),
                        child:
                        Row(children: [
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
                      )]),
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
                    hintText: "Suggest what to study if answered incorrectly",
                  ),
                  onChanged: (val){
                    setState(() {
                      widget.question.advice=val;
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
                  onChanged: (val){
                    setState(() {
                      widget.question.url=val;
                    });
                  },
                ),
                SizedBox(height: height * 0.030),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        maximumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              onPressed:() {
                                //List<String> temp=[];
                                // for(int i=0;i< _values.length;i++){
                                //   temp.add(_values[i]['value']);
                                // }
                                setState(() {
                                  widget.question.subject=subjectController.text;
                                  widget.question.topic=topicController.text;
                                  widget.question.subTopic=subtopicController.text;
                                  widget.question.studentClass=classRoomController.text;
                                  widget.question.question=questionController.text;
                                  widget.question.questionType='mcq';
                                  widget.question.correctChoice=[1];
                                  widget.question.advice=adviceController.text;
                                  widget.question.url=urlController.text;
                                  //demoQuestionModel.choices=temp;
                                });

                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child:  TeacherLooqPreview(question: widget.question,),
                                  ),
                                );
                              },
                              child: const Text("Preview"),
                            ),
                          ]),
                      onPressed: () {}
                  ),
                ),
              ]
              ),
            )
        )
    );
  }

  changeIcon(IconData pramIcon){
    if(pramIcon==Icons.expand_circle_down_outlined){
      setState(() {
        showIcon=Icons.arrow_circle_up_outlined;
      });
    }
    else{
      setState(() {
        showIcon=Icons.expand_circle_down_outlined;
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

  final DemoQuestionModel question;
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
        for (int j=1; j<=widget.question.choices!.length; j++)
          GestureDetector(
            onTap: (){
              setState(() {
                if(widget.selected!.contains(j)){
                  widget.selected!.remove(j);
                }
                else{
                  widget.selected!.add(j);
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
                        color: const Color.fromRGBO(209, 209, 209, 1)
                    ),
                    color: (widget.question.correctChoice!.contains(j)) ? const Color.fromRGBO(82, 165, 160, 1) :const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: widget.width * 0.02,),
                        Expanded(
                          child: Text('${widget.question.choices![j-1]}',
                            style: TextStyle(
                              color: (widget.question.correctChoice!.contains(j)) ? const Color.fromRGBO(255, 255, 255, 1) :const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: widget.height * 0.0162,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ])
              ),
            ),
          )


      ],
    );
  }
}
