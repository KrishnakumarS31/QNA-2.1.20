import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';

class StudentMemAnswerSheet extends StatefulWidget {
  const StudentMemAnswerSheet({Key? key, required this.questions, required this.assessmentId})
      : super(key: key);
  final QuestionPaperModel questions;
  final String assessmentId;
  @override
  StudentMemAnswerSheetState createState() => StudentMemAnswerSheetState();
}

class StudentMemAnswerSheetState extends State<StudentMemAnswerSheet> {
  late QuestionPaperModel values;
  List<List<String>> options=[];

  @override
  void initState() {
    super.initState();
    values = widget.questions;
    for(int j=1;j<=Provider.of<Questions>(context, listen: false).totalQuestion.length;j++){
      List<dynamic> selectedAns=Provider.of<Questions>(context, listen: false).totalQuestion['$j'][0];
      List<String> selectedAnswers =[];
      for(int t=0;t<selectedAns.length;t++){
        if(widget.questions.data!.questions[j-1].questionType=='mcq'){
          selectedAnswers.add(widget.questions.data!.questions[j-1].choices[selectedAns[t]-1].choiceText);
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
        appBar: AppBar(
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
          toolbarHeight: localHeight * 0.100,
          centerTitle: true,
          title: Column(children: [
            Text(
              AppLocalizations.of(context)!.answers,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.024,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.assessmentId,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: localHeight * 0.016,
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: localWidth * 0.35, top: localWidth * 0.056),
                      child: Text(
                        AppLocalizations.of(context)!.answer_sheet,
                        style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: localHeight * 0.02),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: localWidth * 0.2, top: localWidth * 0.056),
                      child: IconButton(
                        icon: Icon(
                          Icons.file_download_outlined,
                          size: localHeight * 0.02,
                          color: const Color.fromRGBO(48, 145, 139, 1),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                SizedBox(height: localHeight * 0.020),
                Column(children: [
                  for (int index = 1; index <= context.watch<Questions>().totalQuestion.length; index++)
                    Container(
                        //decoration: BoxDecoration(border: Border.all()),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        //color: const Color.fromRGBO(255, 255, 255, 1),
                        child: ListTile(
                            title: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text(
                                        "Q${values.data!.questions[index-1].questionId}",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: localHeight * 0.012)),
                                    SizedBox(width: localHeight * 0.020),
                                    Text(
                                      "(${values.data!.questions[index-1].questionMarks}${AppLocalizations.of(context)!.marks})",
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              179, 179, 179, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: localHeight * 0.012),
                                    )
                                  ]),
                                  SizedBox(height: localHeight * 0.010),
                                  Text(
                                    values.data!.questions[index-1].question,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color:
                                            const Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.013),
                                  ),
                                  SizedBox(height: localHeight * 0.015),
                                ]),
                            subtitle: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    Provider.of<Questions>(context, listen: false).totalQuestion['$index'][1] == const Color(0xffdb2323)
                                        ? "Not Answered"
                                        : options[index-1].toString().substring(1,options[index-1].toString().length-1),
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
                              SizedBox(height: localHeight * 0.015),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "${AppLocalizations.of(context)!.study_chapter} ${values.data!.questions[index-1].questionId} \t",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  51, 51, 51, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.015)),
                                      TextSpan(
                                          text: values.data!
                                              .questions[index-1].advisorText,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  51, 51, 51, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: localHeight * 0.015)),
                                    ])),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                  ]),
                            ])))
                ]),
                SizedBox(height: localHeight * 0.030),
              ])
            ])));
  }
}
