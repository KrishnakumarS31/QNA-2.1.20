import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Providers/question_num_provider.dart';
import 'package:provider/provider.dart';
import '../Entity/question_paper_model.dart';
import '../Services/qna_service.dart';
import 'package:intl/intl.dart';
import 'guest_result_page.dart';
class guestReviseQuest extends StatefulWidget {
  const guestReviseQuest({Key? key,
    required this.questions
  }) : super(key: key);
  final QuestionPaperModel questions;

  @override
  guestReviseQuestState createState() => guestReviseQuestState();
}

class guestReviseQuestState extends State<guestReviseQuest> {
  late Future<QuestionPaperModel> questionPaperModel;
  late QuestionPaperModel values;

  @override
  void initState() {
    super.initState();
    values = widget.questions;
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    questionPaperModel= QnaService.getQuestion(assessmentId: values.data.assessment.assessmentCode);
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
                                  values.data.assessment.assessmentCode,
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
                    SizedBox(height: localHeight * 0.020),
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
                                            Text("Q${values.data.assessment.questions[index-1].questionId}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: localHeight * 0.012)),
                                            SizedBox(width: localHeight * 0.010),
                                            Text(
                                              "(${values.data.assessment.questions[index-1].questionMarks} ${AppLocalizations.of(context)!.marks})",
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
                                          Text("(${values.data.assessment.questions[index-1].question})",
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
                                    subtitle:
                                    Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                Provider.of<Questions>(context, listen: false).totalQuestion['$index'][1] == const Color(0xffdb2323)
                                                    ? "Not Answered"
                                                    : "${Provider.of<Questions>(context, listen: false).totalQuestion['$index'][0]}",
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
                    color: Color.fromRGBO(66, 194, 0, 1),
                  ),
                  height: localHeight * 0.10,
                  width: localWidth * 0.10,
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
          // SingleChildScrollView(
          //   child:
          Text(AppLocalizations.of(context)!.sure_to_submit,),
          //),
          actions: <Widget>[
            SizedBox(width: localHeight * 0.020),
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
            SizedBox(width: localHeight * 0.005),
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
                onPressed: () {
                  int totalMark=0;
                  for(int j=1;j<=Provider.of<Questions>(context, listen: false).totalQuestion.length;j++){
                    List<dynamic> correctAns=values.data.assessment.questions[j-1].choices_answer;
                    correctAns.sort();
                    List<dynamic> selectedAns=Provider.of<Questions>(context, listen: false).totalQuestion['$j'][0];
                    selectedAns.sort();
                    if(listEquals(correctAns, selectedAns)){
                      totalMark=totalMark+values.data.assessment.questions[j-1].questionMarks;
                    }
                  }
                  final DateTime now = DateTime.now();
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  final DateFormat timeFormatter = DateFormat('hh:mm a');
                  final String formatted = formatter.format(now);
                  final String time=timeFormatter.format(now);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child:  GuestResultPage(totalMarks: totalMark,date: formatted,time: time, questions: values),
                    ),
                  );
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
