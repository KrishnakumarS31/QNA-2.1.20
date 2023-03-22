import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../Components/custom_radio_option.dart';
import '../Components/custom_result_card1.dart';
import '../EntityModel/get_result_model.dart';

class TeacherResultIndividualStudent extends StatefulWidget {
  const TeacherResultIndividualStudent({
    Key? key,
    required this.result,
    this.advisorName,
  }) : super(key: key);
  final GetResultModel result;
  final String? advisorName;

  @override
  TeacherResultIndividualStudentState createState() =>
      TeacherResultIndividualStudentState();
}

class TeacherResultIndividualStudentState
    extends State<TeacherResultIndividualStudent> {
  Uint8List? bytes;
  IconData showIcon = Icons.expand_circle_down_outlined;
  String? _groupValue;
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }



  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
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
          toolbarHeight: height * 0.100,
          centerTitle: true,
          title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'RESULTS REPORT',
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "STUDENT",
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: height * 0.0225,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
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
                left: height * 0.023,
                right: height * 0.023),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.result.assessmentCode!,
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: height * 0.025,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     const Icon(
                  //       Icons.drafts_outlined,
                  //       color: Color.fromRGBO(82, 165, 160, 1),
                  //     ),
                  //     SizedBox(
                  //       width: width * 0.03,
                  //     ),
                  //     IconButton(
                  //         onPressed: () async {},
                  //         icon: const Icon(
                  //           Icons.print_outlined,
                  //           color: Color.fromRGBO(82, 165, 160, 1),
                  //         ))
                  //   ],
                  // )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.005, top: height * 0.005),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " ${widget.result.assessmentId!}",
                    style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.018,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color.fromRGBO(82, 165, 160, 1),
                  ),
                  Text(
                    widget.result.assessmentResults![0].organizationName!,
                    style: TextStyle(
                        fontSize: height * 0.017,
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Result_card1(
                  height: height,
                  width: width,
                  name: widget.result.assessmentResults![0].firstName!,
                  testCode: widget.result.assessmentCode!,
                  percent: 95,
                  securedMark:
                      widget.result.assessmentResults![0].attemptScore!,
                  totalMark: widget.result.totalScore!,
                  timeTaken:
                      widget.result.assessmentResults![0].attemptDuration!,
                  startedTime:
                      widget.result.assessmentResults![0].attemptStartDate!),
              SizedBox(
                height: height * 0.02,
              ),
              // Container(
              //   height: height * 0.06,
              //   margin: const EdgeInsets.only(left: 15, right: 6),
              //   decoration: BoxDecoration(
              //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //     border: Border.all(
              //       color: const Color.fromRGBO(82, 165, 160, 1),
              //     ),
              //   ),
              //   child: Row(
              //     children:
              //       [
              //         MyRadioOption<String>(
              //           icon: Icons.check_box_outlined,
              //           value: 'Correct\nAnswers',
              //           groupValue: _groupValue,
              //           onChanged: _valueChangedHandler(),
              //           label: 'Correct Answers',
              //         ),
              //       MyRadioOption<String>(
              //         icon: Icons.account_tree_outlined,
              //         value: 'Incorrect\nAnswers',
              //         groupValue: _groupValue,
              //         onChanged: _valueChangedHandler(),
              //         label: 'Incorrect Answers',
              //       ),
              //       MyRadioOption<String>(
              //         icon: Icons.library_books_sharp,
              //         value: 'All Answers',
              //         groupValue: _groupValue,
              //         onChanged: _valueChangedHandler(),
              //         label: 'All Answers',
              //       ),
              //   ],
              //   ),
              // ),
              SizedBox(
                height: height * 0.03,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "MCQ",
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600),
                ),
              ),
                  widget.result.assessmentResults != ""
                      ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.result.assessmentResults!.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    widget.result.assessmentResults![0].questions![index]
                                .questionType! ==
                            "MCQ"
                        ? GestureDetector(
                            onTap: () {},
                            child: QuesAndAns(
                              height: height,
                              ques: widget.result.assessmentResults![0]
                                  .questions![index].question!,
                              ans: widget.result.assessmentResults![0]
                                  .questions![index].descriptiveAnswers!,
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              )
                      : const SizedBox(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Survey',
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600),
                ),
              ),
              widget.result.assessmentResults != ""
              ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.result.assessmentResults!.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    widget.result.assessmentResults![0].questions![index]
                                .questionType! ==
                            "SURVEY"
                        ? GestureDetector(
                            onTap: () {},
                            child: QuesAndAns(
                              height: height,
                              ques: widget.result.assessmentResults![0]
                                  .questions![index].question!,
                              ans: widget.result.assessmentResults![0]
                                  .questions![index].descriptiveAnswers!,
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              )
                  :const SizedBox(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DESCRIPTIVE',
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600),
                ),
              ),
            widget.result.assessmentResults != ""
                ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.result.assessmentResults!.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    widget.result.assessmentResults![0].questions![index]
                                .questionType! ==
                            "descriptive"
                        ? GestureDetector(
                            onTap: () {},
                            child: QuesAndAns(
                              height: height,
                              ques: widget.result.assessmentResults![0]
                                  .questions![index].question!,
                              ans: widget.result.assessmentResults![0]
                                  .questions![index].descriptiveAnswers!,
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              )
                : const SizedBox(),
            ]),
          ),
        ));
  }
}

class NumberList {
  String number;
  int index;
  NumberList({required this.number, required this.index});

}

class QuesAndAns extends StatefulWidget {
  QuesAndAns(
      {Key? key, required this.height, required this.ques, required this.ans})
      : super(key: key);

  final double height;
  final String ques;
  String ans;

  @override
  State<QuesAndAns> createState() => _QuesAndAnsState();
}

class _QuesAndAnsState extends State<QuesAndAns> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height * 0.015,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                'Q',
                style: TextStyle(
                    fontSize: widget.height * 0.014,
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Text(
                  widget.ques,
                  style: TextStyle(
                      fontSize: widget.height * 0.014,
                      color: const Color.fromRGBO(102, 102, 102, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.height * 0.01,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Answered:',
                style: TextStyle(
                    fontSize: widget.height * 0.014,
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Text(
                  widget.ans,
                  style: TextStyle(
                      fontSize: widget.height * 0.014,
                      color: const Color.fromRGBO(102, 102, 102, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
