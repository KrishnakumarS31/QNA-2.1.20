import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../Components/custom_radio_option.dart';
import '../Components/custom_result_card1.dart';

class TeacherResultIndividualStudent extends StatefulWidget {
  const TeacherResultIndividualStudent({
    Key? key,
  }) : super(key: key);

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
                      "UCE112233",
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: height * 0.025,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.drafts_outlined,
                        color: Color.fromRGBO(82, 165, 160, 1),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(
                            Icons.print_outlined,
                            color: Color.fromRGBO(82, 165, 160, 1),
                          ))
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.005, top: height * 0.005),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SSSUHE10112025',
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
                    '  SSSUHE, Gulbarga',
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
                name: "Ramesh Kumar",
                testCode: 'SSSUHE10112025',
                percent: 95,
                securedMark: '45',
                totalMark: '50',
              ),
              //if(bytes!=null) Image.memory(bytes!),
              SizedBox(
                height: height * 0.02,
              ),
                  Container(
                    height: height * 0.06,
                   margin: const EdgeInsets.only(left: 15,right:6),
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
                          value: 'Correct\nAnswers',
                          groupValue: _groupValue,
                          onChanged: _valueChangedHandler(),
                          label: 'Correct Answers',
                        ),
                        MyRadioOption<String>(
                          icon: Icons.account_tree_outlined,
                          value: 'Incorrect\nAnswers',
                          groupValue: _groupValue,
                          onChanged: _valueChangedHandler(),
                          label: 'Incorrect Answers',
                        ),
                        MyRadioOption<String>(
                          icon: Icons.library_books_sharp,
                          value: 'All Answers',
                          groupValue: _groupValue,
                          onChanged: _valueChangedHandler(),
                          label: 'All Answers',
                        ),
                      ],
                    ),
                  ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     ' *** Incorrect Answered ***',
              //     style: TextStyle(
              //         fontSize: height * 0.017,
              //         color: const Color.fromRGBO(238, 100, 0, 1),
              //         fontFamily: "Inter",
              //         fontWeight: FontWeight.w600),
              //   ),
              // ),
              SizedBox(
                height: height * 0.03,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'MCQ',
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600),
                ),
              ),
              QuesAndAns(
                height: height,
                ques: ' ..........how many years?',
                ans: ' They are conducted every 5years',
              ),
              QuesAndAns(
                height: height,
                ques: ' Where is Mt. Everest located?',
                ans: ' India',
              ),
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
              QuesAndAns(
                height: height,
                ques: ' Which sports you like the most ?',
                ans: ' Football',
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Descriptive',
                  style: TextStyle(
                      fontSize: height * 0.02,
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600),
                ),
              ),
              QuesAndAns(
                height: height,
                ques: ' Write a brief description about .....',
                ans:
                    ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et nulla cursus, dictum risus sit amet, semper massa. Sed sit. Phasellus viverra, odio dignissim imperdiet pharetra, odio erat euismod libero, sit amet ullamcorper nunc massa in eros.',
              ),
            ]),
          ),
        ));
  }
}

class QuesAndAns extends StatelessWidget {
  const QuesAndAns(
      {Key? key, required this.height, required this.ques, required this.ans})
      : super(key: key);

  final double height;
  final String ques;
  final String ans;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.015,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                'Q 03',
                style: TextStyle(
                    fontSize: height * 0.014,
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Text(
                  ques,
                  style: TextStyle(
                      fontSize: height * 0.014,
                      color: const Color.fromRGBO(102, 102, 102, 1),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Answered:',
                style: TextStyle(
                    fontSize: height * 0.014,
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Text(
                  ans,
                  style: TextStyle(
                      fontSize: height * 0.014,
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
