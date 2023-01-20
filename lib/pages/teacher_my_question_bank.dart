import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_qnBank.dart';
import 'package:qna_test/Pages/teacher_questionBank_page.dart';
import 'package:qna_test/pages/teacher_question_delete_page.dart';

import '../Components/custom_radio_option.dart';
import '../Entity/demo_question_model.dart';
import '../Entity/question_model.dart';
import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';
import '../Providers/question_prepare_provider.dart';
import 'teacher_prepare_preview_qnBank.dart';

class TeacherMyQuestionBank extends StatefulWidget {
  const TeacherMyQuestionBank({
    Key? key
  }) : super(key: key);

  @override
  TeacherMyQuestionBankState createState() => TeacherMyQuestionBankState();
}

class TeacherMyQuestionBankState extends State<TeacherMyQuestionBank> {
  List<DemoQuestionModel> quesList =[];

  @override
  void initState() {
    super.initState();

    quesList = Provider.of<QuestionPrepareProvider>(context, listen: false).getAllQuestion;
    print("from provider");
    for(int i=0;i<quesList.length;i++){
      print(quesList[i].question);
    }
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
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

          toolbarHeight: height * 0.100,
          centerTitle: true,
          title: Text(
            "My Question Bank",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
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
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: width * 0.055,right: width * 0.055),
                height: height * 0.7,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: height * 0.03,),
                      for ( DemoQuestionModel i in quesList )
                        QuestionPreview(height: height, width: width,question: i,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.05,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                  minimumSize: const Size(280, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(39),
                  ),
                ),
                //shape: StadiumBorder(),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const TeacherQuestionBank(),
                    ),
                  );
                },
                child: Text(
                  'Back to Questions',
                  style: TextStyle(
                      fontSize: height * 0.025,
                      fontFamily: "Inter",
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        )
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
  final DemoQuestionModel question;

  @override
  Widget build(BuildContext context) {
    String answer='';
    for(int i=0;i<question.correctChoice!.length;i++){
      int j=1;
      j=question.correctChoice![i]!;
      answer='$answer ${question.choices![j-1]}';
      //question.choices[question.correctChoice[i]];
    }
    return Container(
      child: Column(
        children: [
          Container(
            height: height * 0.04,
            width: width * 0.9,
            color: Color.fromRGBO(82, 165, 160, 0.1),
            child: Padding(
              padding:  EdgeInsets.only(right: width * 0.02,left: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        question.subject,
                        style: TextStyle(
                            fontSize: height * 0.017,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(28, 78, 80, 1),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "  |  ${question.topic} - ${question.subTopic}",
                        style: TextStyle(
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),

                  Text(
                    question.studentClass,
                    style: TextStyle(
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        color: Color.fromRGBO(28, 78, 80, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.01,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              question.question,
              style: TextStyle(
                  fontSize: height * 0.0175,
                  fontFamily: "Inter",
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: height * 0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                answer,
                style: TextStyle(
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    color: Color.fromRGBO(82, 165, 160, 1),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                question.questionType,
                style: TextStyle(
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    color: Color.fromRGBO(82, 165, 160, 1),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: height * 0.01,),
          Divider()

        ],
      ),
    );
  }
}

