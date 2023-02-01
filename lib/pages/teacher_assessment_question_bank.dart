import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_preview_qnBank.dart';
import 'package:qna_test/pages/teacher_assessment_question_bank.dart';
import 'package:qna_test/pages/teacher_looq_search_question.dart';
import 'package:qna_test/pages/teacher_selected_questions_assessment.dart';

import '../Entity/demo_question_model.dart';
import '../Providers/question_prepare_provider.dart';
import 'teacher_prepare_qnBank.dart';


class TeacherAssessmentQuestionBank extends StatefulWidget {
  const TeacherAssessmentQuestionBank({
    Key? key,

  }) : super(key: key);


  @override
  TeacherAssessmentQuestionBankState createState() => TeacherAssessmentQuestionBankState();
}

class TeacherAssessmentQuestionBankState extends State<TeacherAssessmentQuestionBank> {
  bool additionalDetails = true;
  TextEditingController teacherQuestionBankSearchController=TextEditingController();
  List<DemoQuestionModel> quesList =getData();
  static List<DemoQuestionModel> getData() {
    const data=[
      {
        "id":1,
        "questionType":"MCQ",
        "subject":"Maths",
        "topic":"ADD",
        "subTopic":"Add",
        "studentClass":"2",
        "question":"2 + 2",
        "choices":["1","2","4","0"],
        "correctChoice":[3],
        "advice":"agraefweg",
        "url":"waffar"
      },
      {
        "id":2,
        "questionType":"MCQ",
        "subject":"Maths",
        "topic":"ADD",
        "subTopic":"Add",
        "studentClass":"2",
        "question":"2 + 2",
        "choices":["1","2","4","0"],
        "correctChoice":[3],
        "advice":"agraefweg",
        "url":"waffar"
      },
      {
        "id":3,
        "questionType":"MCQ",
        "subject":"Maths",
        "topic":"ADD",
        "subTopic":"Add",
        "studentClass":"2",
        "question":"2 + 2",
        "choices":["1","2","4","0"],
        "correctChoice":[3],
        "advice":"agraefweg",
        "url":"waffar"
      },
      {
        "id":4,
        "questionType":"MCQ",
        "subject":"Maths",
        "topic":"ADD",
        "subTopic":"Add",
        "studentClass":"2",
        "question":"2 + 2",
        "choices":["1","2","4","0"],
        "correctChoice":[3],
        "advice":"agraefweg",
        "url":"waffar"
      },
      {
        "id":5,
        "questionType":"MCQ",
        "subject":"Maths",
        "topic":"ADD",
        "subTopic":"Add",
        "studentClass":"2",
        "question":"2 + 2",
        "choices":["1","2","4","0"],
        "correctChoice":[3],
        "advice":"agraefweg",
        "url":"waffar"
      }

    ];
    return data.map<DemoQuestionModel>(DemoQuestionModel.fromJson).toList();
  }

  showAdditionalDetails(){
    setState(() {
      !additionalDetails;
    });
  }


  @override
  void initState() {
    super.initState();
    //quesList = Provider.of<QuestionPrepareProvider>(context, listen: false).getAllQuestion;
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
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
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon:const Icon(
                Icons.menu,
                size: 40.0,
                color: Colors.white,
              ), onPressed: () {
              Navigator.of(context).pop();
            },
            ),
          ),
        ],
        leading: IconButton(
          icon:const Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.white,
          ), onPressed: () {
          Navigator.of(context).pop();
        },
        ),
        toolbarHeight: height * 0.100,
        centerTitle: true,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "SEARCH RESULTS",
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: height * 0.0225,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "MY QUESTION BANK",
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
      body: Padding(
        padding:  EdgeInsets.only(left: width * 0.025,right: width * 0.025),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            TextField(
              controller: teacherQuestionBankSearchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.016),
                hintText: "Maths, 10th, 2022, CBSE, Science",
                suffixIcon:
                Column(
                    children: [
                      Container(
                          height: height * 0.073,
                          width: width*0.13,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color: Color.fromRGBO(82, 165, 160, 1),
                          ),
                          child: IconButton(
                            iconSize: height * 0.04,
                            color: const Color.fromRGBO(255, 255, 255, 1), onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //     type: PageTransitionType.rightToLeft,
                            //     child:  TeacherAssessmentSearched(),
                            //   ),
                            // );
                          }, icon: const Icon(Icons.search),
                          )),
                    ]),
                focusedBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                    borderRadius: BorderRadius.circular(15)
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              enabled: true,
              onChanged: (value) {
              },
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tap to Review/Edit/Delete",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: const Color.fromRGBO(153, 153, 153, 1),
                    fontSize: height * 0.015,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),),
                Row(
                  children: [
                    Text("My Questions",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),),
                    SizedBox(width: width*0.02,),
                    Icon(Icons.circle_rounded,color: const Color.fromRGBO(82, 165, 160, 1),)
                  ],
                )
              ],
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Container(
              height: height * 0.6,
              width: width * 0.9,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for ( DemoQuestionModel i in quesList )
                      QuestionPreview(height: height, width: width,question: i,),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02,),
            Center(
              child: Container(
                width: width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                      minimumSize: const Size(280, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                      side: const BorderSide(
                        color: Color.fromRGBO(82, 165, 160, 1),
                      )
                  ),
                  //shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const TeacherSelectedQuestionAssessment(),
                      ),
                    );
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                        fontSize: height * 0.025,
                        fontFamily: "Inter",
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02,),
          ],
        ),
      ),
    );
  }

}



class QuestionPreview extends StatefulWidget {
  const QuestionPreview({
    Key? key,
    required this.height,
    required this.width,
    required this.question,
  }) : super(key: key);

  final double height;
  final double width;
  final DemoQuestionModel question;

  @override
  State<QuestionPreview> createState() => _QuestionPreviewState();
}

class _QuestionPreviewState extends State<QuestionPreview> {
  bool? valuefirst = false;
  List<DemoQuestionModel> selectedQuestion=[];
  @override
  Widget build(BuildContext context) {

    String answer='';
    for(int i=1;i<=widget.question.correctChoice!.length;i++){
      int j=1;
      j=widget.question.correctChoice![i-1]!;
      answer='$answer ${widget.question.choices![j-1]}';
      //question.choices[question.correctChoice[i]];
    }
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            checkColor: Color.fromRGBO(255, 255, 255, 1),
            activeColor: Color.fromRGBO(82, 165, 160, 1),
            value: valuefirst,
            onChanged: (bool? value) {
              setState(() {
                valuefirst = value;
              });
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: widget.height * 0.04,
                width: widget.width * 0.75,
                color: Color.fromRGBO(82, 165, 160, 0.1),
                child: Padding(
                  padding:  EdgeInsets.only(right: widget.width * 0.02,left: widget.width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.question.subject,
                            style: TextStyle(
                                fontSize: widget.height * 0.017,
                                fontFamily: "Inter",
                                color: Color.fromRGBO(28, 78, 80, 1),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "  |  ${widget.question.topic} - ${widget.question.subTopic}",
                            style: TextStyle(
                                fontSize: widget.height * 0.015,
                                fontFamily: "Inter",
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),

                      Text(
                        widget.question.studentClass,
                        style: TextStyle(
                            fontSize: widget.height * 0.015,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(28, 78, 80, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: widget.height * 0.01,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.question.questionType,
                  style: TextStyle(
                      fontSize: widget.height * 0.0175,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(28, 78, 80, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: widget.height * 0.01,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.question.question,
                  style: TextStyle(
                      fontSize: widget.height * 0.0175,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: widget.height * 0.01,),
              Divider()

            ],
          ),
        ],
      ),
    );
  }
}