import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Pages/teacher_prepare_qnBank.dart';
import 'package:qna_test/pages/teacher_my_question_bank.dart';
import 'package:qna_test/pages/teacher_question_delete_page.dart';

import '../Components/custom_radio_option.dart';
import '../Entity/demo_question_model.dart';
import '../Entity/question_model.dart';
import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';
import '../Providers/question_prepare_provider.dart';
import 'teacher_prepare_preview_qnBank.dart';

class TeacherAddMyQuestionBank extends StatefulWidget {
  const TeacherAddMyQuestionBank({
    Key? key
  }) : super(key: key);

  @override
  TeacherAddMyQuestionBankState createState() => TeacherAddMyQuestionBankState();
}

class TeacherAddMyQuestionBankState extends State<TeacherAddMyQuestionBank> {


 List<DemoQuestionModel> quesList =[];

 showAlertDialog(BuildContext context,double height) {
   // set up the buttons
   Widget cancelButton = ElevatedButton(
     style: ElevatedButton.styleFrom(
         primary: Colors.white,
         textStyle: TextStyle(
             fontSize: height * 0.02,
             fontFamily: "Inter",
             color: Color.fromRGBO(48, 145, 139, 1),
             fontWeight: FontWeight.w500),),
     child: Text(
       'No',
     style: TextStyle(
         fontSize: height * 0.02,
         fontFamily: "Inter",
         color: Color.fromRGBO(48, 145, 139, 1),
         fontWeight: FontWeight.w500),),
     onPressed:  () {
       Navigator.of(context).pop();
     },
   );
   Widget continueButton = ElevatedButton(
     style: ElevatedButton.styleFrom(
       primary: Color.fromRGBO(82, 165, 160, 1),
       textStyle: TextStyle(
           fontSize: height * 0.02,
           fontFamily: "Inter",
           color: Color.fromRGBO(48, 145, 139, 1),
           fontWeight: FontWeight.w500),),
     child: Text(
       'Yes',
       style: TextStyle(
           fontSize: height * 0.02,
           fontFamily: "Inter",
           color: Color.fromRGBO(250, 250, 250, 1),
           fontWeight: FontWeight.w500),),
     onPressed:  () {
       Navigator.push(
         context,
         PageTransition(
           type: PageTransitionType.rightToLeft,
           child: const TeacherMyQuestionBank(),
         ),
       );
     },
   );
   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: Text(
       'Confirm',
       style: TextStyle(
           fontSize: height * 0.02,
           fontFamily: "Inter",
           color: Color.fromRGBO(0, 106, 100, 1),
           fontWeight: FontWeight.w700),
     ),
     content: Text(
       'Are you sure you want to submit to My Question Bank?',
       style: TextStyle(
           fontSize: height * 0.02,
           fontFamily: "Inter",
           color: Color.fromRGBO(51, 51, 51, 1),
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
    quesList = Provider.of<QuestionPrepareProvider>(context, listen: false).getAllQuestion;
    print("--------------------------");
    print(quesList);
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
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
                  'ADD',
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "MY QUESTION",
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
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: height * 0.0375,left: width * 0.055,right: width * 0.055),
                child: Container(
                  height: height * 0.1412,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(82, 165, 160, 0.08),
                      border: Border.all(
                        color: Color.fromRGBO(28, 78, 80, 0.08),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: width* 0.02,right: width* 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              quesList[0].subject,
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontFamily: "Inter",
                                  color: Color.fromRGBO(28, 78, 80, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '26/12/2022',
                              style: TextStyle(
                                  fontSize: height * 0.015,
                                  fontFamily: "Inter",
                                  color: Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width* 0.02,right: width* 0.02),
                        child: Divider(),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: width* 0.02),
                        child: Row(
                          children: [
                            Text(
                              quesList[0].topic,
                              style: TextStyle(
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  color: Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: width * 0.01,),
                            Text(
                              '|',
                              style: TextStyle(
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  color: Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: width * 0.01,),
                            Text(
                              quesList[0].subTopic,
                              style: TextStyle(
                                  fontSize: height * 0.0175,
                                  fontFamily: "Inter",
                                  color: Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: width* 0.02),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            quesList[0].studentClass,
                            style: TextStyle(
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: width * 0.055,right: width * 0.055),
                    height: height * 0.55,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ListView.builder(
                          //   itemCount: quesList.length,
                          //     itemBuilder: (context, index){
                          //     return
                          //     }),
                          for ( DemoQuestionModel i in quesList )
                          QuestionPreview(height: height, width: width,question: i,),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: height * 0.52,
                      left: width * 0.8,
                      child: FloatingActionButton(onPressed: (){
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const TeacherPrepareQnBank(),
                          ),
                        );
                  },
                    child: Icon(Icons.add),
                      backgroundColor: Color.fromRGBO(28, 78, 80, 1),
                  )
                  )
                ],
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
                  showAlertDialog(context,height);
                },
                child: Text(
                  'Submit',
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
    List<String> temp=[];
    for(int i=0;i<question.correctChoice!.length;i++){
      answer='${question.choices![i]}';
      int ch= 0;
      ch=question.correctChoice![i]!;
      temp.add(question.choices![ch-1]!);
      //question.choices[question.correctChoice[i]];
    }
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${question.questionType}',
                style: TextStyle(
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    color: Color.fromRGBO(82, 165, 160, 1),
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: TeacherQuesDelete(question: question,),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: height * 0.0185,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(28, 78, 80, 1),
                              fontWeight: FontWeight.w400),
                        ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Icon(Icons.mode_edit_outline_outlined,color:  Color.fromRGBO(28, 78, 80, 1),),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: height * 0.01,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${question.question}',
              style: TextStyle(
                  fontSize: height * 0.0175,
                  fontFamily: "Inter",
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: height * 0.01,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              temp.toString().substring(1,temp.toString().length-1),
              style: TextStyle(
                  fontSize: height * 0.02,
                  fontFamily: "Inter",
                  color: Color.fromRGBO(82, 165, 160, 1),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: height * 0.01,),
          Divider()

        ],
      ),
    );
  }
}

