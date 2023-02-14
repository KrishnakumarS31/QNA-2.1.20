import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/custom_incorrect_popup.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/post_assessment_model.dart';
import '../Providers/question_num_provider.dart';
import 'package:provider/provider.dart';
import '../Entity/question_paper_model.dart';
import 'package:intl/intl.dart';
import '../Services/qna_service.dart';
import 'student_result_page.dart';
class StudentReviseQuest extends StatefulWidget {
  const StudentReviseQuest({Key? key,
    required this.questions, required this.userName, required this.assessmentID,required this.startTime
  }) : super(key: key);
  final QuestionPaperModel questions;
  final String userName;
  final int startTime;
  final String assessmentID;


  @override
  StudentReviseQuestState createState() => StudentReviseQuestState();
}

class StudentReviseQuestState extends State<StudentReviseQuest> {
  late QuestionPaperModel values;
  List<List<dynamic>> options=[];
  PostAssessmentModel assessment=PostAssessmentModel(assessmentResults: []);

  @override
  void initState() {

    super.initState();
    values = widget.questions;
    for(int j=1;j<=Provider.of<Questions>(context, listen: false).totalQuestion.length;j++){
      List<dynamic> selectedAns=Provider.of<Questions>(context, listen: false).totalQuestion['$j'][0];
      List<dynamic> selectedAnswers =[];
      for(int t=0;t<selectedAns.length;t++){
        if(widget.questions.data!.questions[j-1].questionType=='mcq'){
          selectedAnswers.add(widget.questions.data!.questions[j-1].choices[t].choiceText);
          print(widget.questions.data!.questions[j-1].choices[t].choiceText);
        }
        else{
          String temp='';
          temp=Provider.of<Questions>(context, listen: false).totalQuestion['$j'][0].toString().substring(1,Provider.of<Questions>(context, listen: false).totalQuestion['$j'][0].toString().length-1);
          selectedAnswers.add(temp);
        }
      }
      options.add(selectedAnswers);
    }

  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              Column(
                  children: [
                    Container(
                      height: localHeight * 0.25,
                      width: localWidth * 1 ,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(0, 106, 100, 1),
                            Color.fromRGBO(82, 165, 160, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                localWidth * 2.0,
                                localHeight * 0.6)
                        ),
                      ),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children : [
                          SizedBox(height: localHeight * 0.060),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                                children:[
                                  IconButton(
                                    tooltip: AppLocalizations.of(context)!.revise,
                                    icon: const Icon(
                                      Icons.chevron_left,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.revise,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: localHeight * 0.018,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child:
                            SizedBox(
                              child: Column(children: [
                                Text(
                                  AppLocalizations.of(context)!.review,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: localHeight * 0.020,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.answer_sheet,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: localHeight * 0.020,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: localHeight * 0.03,
                                ),
                                Text(
                                 widget.assessmentID,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: localHeight * 0.016,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(height: localHeight * 0.025),

                        ],
                      ),
                    ),
                    SizedBox(height: localHeight * 0.030),
                    Text(widget.userName,
                      style: const TextStyle(
                        color: Color.fromRGBO(82, 165, 160, 1),
                        fontSize: 18.0,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),),
                    SizedBox(height: localHeight * 0.030),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: localWidth * 0.056),
                        child: Text(
                            AppLocalizations.of(context)!.pls_tap_ques,
                            style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: localHeight * 0.011)),
                      )
                    ]),
                    Column(
                        children: [
                          for (int index = 1; index <= context.watch<Questions>().totalQuestion.length; index++)
                            GestureDetector(
                              onTap: (){
                              },
                              child: Container(
                                //decoration: BoxDecoration(border: Border.all()),
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  //color: const Color.fromRGBO(255, 255, 255, 1),
                                  child:
                                  ListTile(
                                    title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Text("Q${values.data!.questions[index-1].questionId}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: localHeight * 0.012)),
                                            SizedBox(width: localHeight * 0.010),
                                            Text(
                                              "(${values.data!.questions[index-1].questionMarks} ${AppLocalizations.of(context)!.marks})",
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      179, 179, 179, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: localHeight * 0.012),
                                            ),
                                            SizedBox(width: localHeight * 0.010),
                                            Provider.of<Questions>(context, listen: false).totalQuestion["$index"][2] == true
                                                ? Stack(
                                              children:  [
                                                Icon(
                                                    Icons.mode_comment_outlined,color: const Color.fromRGBO(255, 153, 0, 1),size: localHeight* 0.025),
                                                Positioned(
                                                    left: MediaQuery.of(context).copyWith().size.width * 0.008,
                                                    top: MediaQuery.of(context).copyWith().size.height * 0.004,
                                                    child: Icon(Icons.question_mark,
                                                      color: const Color.fromRGBO(255, 153, 0, 1),
                                                      size: MediaQuery.of(context).copyWith().size.height*0.016,))
                                              ],
                                            )
                                                : SizedBox(width: localHeight * 0.010),
                                          ]),
                                          SizedBox(height: localHeight * 0.010),
                                          Text(values.data!.questions[index-1].question,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    51, 51, 51, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: localHeight * 0.013),
                                          ),
                                          SizedBox(height: localHeight * 0.015),
                                        ]),
                                      //for(int j=1;j<=Provider.of<Questions>(context, listen: false).totalQuestion.length;j++)
                                    // {
                                    // List<dynamic> selectedAns=Provider.of<Questions>(context, listen: false).totalQuestion['$j'][0];
                                    // for(int t=0;t<selectedAns.length;t++)
                                    // {
                                    // print(widget.questions.data!.assessment!.questions[j].choices[selectedAns[t]-1].choiceText);  }
                                    // }
                                    subtitle:
                                    Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child:
                                            Text(
                                                Provider.of<Questions>(context, listen: false).totalQuestion['$index'][1] == const Color(0xffdb2323)
                                                    ? "Not Answered"
                                                    : Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().substring(1,Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0].toString().length-1),
                                                //"${Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0]}",
                                                style:
                                                Provider.of<Questions>(context, listen: false).totalQuestion['$index'][1] == const Color(0xffdb2323)
                                                    ?
                                                TextStyle(
                                                    color: const Color.fromRGBO(
                                                        238, 71, 0, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.014)
                                                    : TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: localHeight * 0.014)
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 2,
                                          ),
                                        ]),
                                  )
                              ),
                            )
                        ]),
                    Column(
                      children: [
                        Align(alignment: Alignment.center,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              //shape: StadiumBorder(),
                              child:Text(AppLocalizations.of(context)!.submit,
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              onPressed: () {
                                _showMyDialog();
                              }
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: localHeight * 0.030),
                  ])
            ])));
  }

  Future<void> _showMyDialog() async {
    double localHeight = MediaQuery.of(context).size.height;
    double localWidth = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
         insetPadding: EdgeInsets.only(left: localWidth * 0.13,right: localWidth * 0.13),
          title: Row(
              children:  [
                SizedBox(width: localHeight * 0.030),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(82, 165, 160, 1),
                  ),
                  height: localHeight * 0.1,
                  width: localWidth * 0.1,
                  child: const Icon(Icons.info_outline_rounded,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                SizedBox(width: localHeight * 0.015),
                Text(AppLocalizations.of(context)!.confirm,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: localHeight * 0.024,
                      color: const Color.fromRGBO(0, 106, 100, 1),
                      fontWeight: FontWeight.w700
                  ),),
              ]
          ),
          content:
          Text(AppLocalizations.of(context)!.sure_to_submit,),
          actions: <Widget>[
            SizedBox(width: localWidth * 0.020),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                minimumSize: const Size(90, 30),
                side: const BorderSide(
                  width: 1.5,
                  color: Color.fromRGBO(82, 165, 160, 1),
                ),
              ),
              child:  Text(AppLocalizations.of(context)!.no,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: localHeight * 0.018,
                      color: const Color.fromRGBO(82, 165, 160, 1),
                      fontWeight: FontWeight.w500
                  )
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
           SizedBox(width: localWidth * 0.005),
            ElevatedButton(
                style:
                ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                  minimumSize: const Size(90, 30),
                ),
                child:  Text(AppLocalizations.of(context)!.yes,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: localHeight * 0.018,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    )
                ),
                onPressed: () async {
                  int ansCorrect=0;
                  print(widget.startTime);
                  print(DateTime.now().microsecondsSinceEpoch);
                  int totalMark=0;
                  assessment.assessmentId=2;
                  assessment.assessmentCode="12345678";
                  assessment.statusId=2;
                  assessment.attemptStartdate=widget.startTime;
                  assessment.attemptEnddate=DateTime.now().microsecondsSinceEpoch;
                  var d1 = DateTime.fromMicrosecondsSinceEpoch(widget.startTime);
                  var d2 = DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch);
                  int difference = d2.difference(d1).inMinutes;
                  assessment.attemptDuration=difference;

                  for(int j=1;j<=Provider.of<Questions>(context, listen: false).totalQuestion.length;j++){
                    List<int> selectedAnsId=[];
                    AssessmentResult quesResult=AssessmentResult();
                    quesResult.questionId=values.data!.questions[j-1].questionId;
                    quesResult.statusId=6;
                    quesResult.questionTypeId=values.data!.questions[j-1].questionTypeId;
                    quesResult.marks=0;
                    List<dynamic> correctAns=[];
                    for(int i=0;i<values.data!.questions[j-1].choices_answer.length;i++){
                      correctAns.add(values.data!.questions[j-1].choices_answer[i].choiceText);
                    }
                    correctAns.sort();
                    List<dynamic> selectedAns=Provider.of<Questions>(context, listen: false).totalQuestion['$j'][0];
                    selectedAns.sort();

                    List<int> key=[];
                    List<String> value=[];
                    for(int s=0;s<values.data!.questions[j-1].choices.length;s++)
                    {
                      key.add(values.data!.questions[j-1].choices[s].choiceId);
                      value.add(values.data!.questions[j-1].choices[s].choiceText);
                    }
                    Map<int, String> map = Map.fromIterables(key, value);
                    for(int f=0;f<selectedAns.length;f++){
                      selectedAnsId.add(key[value.indexOf(selectedAns[f])]);
                    }
                    quesResult.selectedQuestionChoice=selectedAnsId;

                    if(listEquals(correctAns, selectedAns)){
                      quesResult.marks=values.data!.questions[j-1].questionMarks;
                      totalMark=totalMark+values.data!.questions[j-1].questionMarks;
                      ansCorrect++;
                    }
                    assessment.assessmentResults?.add(quesResult);
                  }
                  assessment.attemptScore=totalMark;
                  int percent=((ansCorrect/values.data!.questions.length) * 100).round();
                  if(percent<=values.data!.assessment_score_message[0].assessment_percent){
                    assessment.assessmentScoreId=values.data!.assessment_score_message[0].assessmentScoreId;
                  }
                  else if(percent<=values.data!.assessment_score_message[1].assessment_percent)
                    {
                      assessment.assessmentScoreId=values.data!.assessment_score_message[1].assessmentScoreId;
                    }
                  else{
                    assessment.assessmentScoreId=values.data!.assessment_score_message[2].assessmentScoreId;
                  }
                  print(assessment.assessmentScoreId);


                  final String assessmentCode = "12345678";
                  final DateTime now = DateTime.now();
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  final DateFormat timeFormatter = DateFormat('hh:mm a');
                  final String formatted = formatter.format(now);
                  final String time=timeFormatter.format(now);

                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(
                                  48, 145, 139, 1),
                            ));
                      });
                  LoginModel loginResponse = await QnaService.postAssessmentService(assessment);
                  // print(loginResponse.message);
                  // print(loginResponse.code);
                  Navigator.of(context).pop();
                  if (loginResponse.code == 200) {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:  StudentResultPage(totalMarks: totalMark,date: formatted,time: time, questions: values,assessmentCode: assessmentCode,userName: widget.userName),
                      ),
                    );
                  }
                  else {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: CustomDialog(
                          title: 'Answer not Submitted',
                          content: 'please enter the',
                          button: AppLocalizations.of(context)!
                              .retry,
                        ),
                      ),
                    );
                  }

                }
            ),
            SizedBox(width: localHeight * 0.030),
          ],
        );
      },
    );
  }
}

class QuestionModel {
  String qnNumber, question, answer, mark;
  QuestionModel(
      {required this.qnNumber,
        required this.question,
        required this.answer,
        required this.mark});
}

