import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/student_mem_Advisor.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../Entity/question_paper_model.dart';


class StudentResultPage extends StatefulWidget {
  const StudentResultPage({Key? key,
    required this.totalMarks,required this.date,required this.time,required this.questions
  }) : super(key: key);
  final int totalMarks;
  final QuestionPaperModel questions;
  final String date;
  final String time;

  @override
  StudentResultPageState createState() => StudentResultPageState();
}
class StudentResultPageState extends State<StudentResultPage> {
  TextEditingController assessmentID = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
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
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container(
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
                          localWidth,
                          localHeight * 0.35)
                  ),
                ),
                child: Column(
                  children : [
                    const SizedBox(height:80.0),
                    Align(
                      alignment: Alignment.topCenter,
                      child:
                      Container(
                          padding: const EdgeInsets.all(0.0),
                          height: localHeight * 0.20,
                          width: localWidth * 0.30,
                          child: Column(
                            children: [
                              Text(AppLocalizations.of(context)!.result_card,
                                style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: localHeight * 0.024),),
                              const SizedBox(height: 10.0),
                              Text("AssID23515A225",
                                  style: TextStyle(
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight* 0.016)),
                            ],
                          )
                      ),
                    ),
                                      ],
                ),
              ),
              ),
             const SizedBox(height: 15.0),
              Expanded(child: Column(
                children: [
                  const SizedBox(height: 240.0),
                  Text(AppLocalizations.of(context)!.for_incorrect,
                      style: TextStyle(
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: localHeight* 0.018)),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                        side: const BorderSide(
                          width: 1.5,
                          color: Color.fromRGBO(82, 165, 160, 1),
                        ),
                      ),
                      //shape: StadiumBorder(),
                      child: Text(AppLocalizations.of(context)!.advisor,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: localHeight  * 0.022,
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontWeight: FontWeight.w500
                          )
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: StudMemAdvisor(questions: values),
                          ),
                        );
                      }
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      //shape: StadiumBorder(),
                      child: Text(AppLocalizations.of(context)!.exit,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: localHeight  * 0.022,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          )
                      ),
                      onPressed: () {

                      }
                  ),
                ],)),
            ],
          ),
          Align(
            //alignment: Alignment.center,
            alignment: const Alignment(0, 0.005),
            child: SizedBox(
              height: localHeight * 0.60,
              width: localWidth * 0.8,
              child: Card(
                elevation: 12,
                child: Column(
                    children:[
                      const SizedBox(height: 20.0),
                      Text('Student Name',
                          style: TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: localHeight* 0.024)),
                      const SizedBox(height: 25.0),
                      Text('${widget.totalMarks}',
                          style: TextStyle(
                              color: const Color.fromRGBO(255, 153, 0, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: localHeight* 0.096)),
                      const SizedBox(height: 15.0),
                      Text(AppLocalizations.of(context)!.mark_scored,
                          style: TextStyle(
                              color: const Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: localHeight* 0.018)),
                      const SizedBox(height: 30.0),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          const SizedBox(width: 25.0),
                          Text(AppLocalizations.of(context)!.submission_date,
                              style: TextStyle(
                                  color: const Color.fromRGBO(161, 161, 161, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: localHeight* 0.020)),
                          const SizedBox(width: 25.0),
                          Text(AppLocalizations.of(context)!.submission_time,
                              style: TextStyle(
                                  color: const Color.fromRGBO(161, 161, 161, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: localHeight* 0.020)),
                          const SizedBox(width: 25.0),
                          Text(AppLocalizations.of(context)!.time_taken,
                              style: TextStyle(
                                  color: const Color.fromRGBO(161, 161, 161, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: localHeight* 0.020)),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          const SizedBox(width: 25.0),
                          Text(widget.date,
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: localHeight* 0.022)),
                          const SizedBox(width: 20.0),
                          Text(widget.time,
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: localHeight* 0.022)),
                          const SizedBox(width: 25.0),
                          Text('05:23',
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: localHeight* 0.022)),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Expanded(child: Container(
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
                              top: Radius.elliptical(
                                  localWidth / 1.0,
                                  localHeight * 0.3)
                          ),
                        ),
                        child:
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: localWidth * 0.33),
                              child: Text(AppLocalizations.of(context)!.good,
                                style: TextStyle(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: localHeight * 0.024),),
                            ),
                          ],
                        ),
                      ),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}