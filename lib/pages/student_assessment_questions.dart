import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Entity/question_paper_model.dart';
import 'package:qna_test/Providers/question_num_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../DataSource/http_url.dart';
import '../Entity/Teacher/get_assessment_header.dart';
import '../Entity/user_details.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/post_assessment_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Services/qna_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class StudQuestion extends StatefulWidget {
  StudQuestion(
      {Key? key,
        required this.assessmentId,
        required this.ques,
        required this.userName,
        this.userId,
        required this.isMember,
        required this.assessmentHeaders,
        required this.organisationName
      })
      : super(key: key);
  final String assessmentId;
  final QuestionPaperModel ques;
  final String userName;
  int? userId;
  final bool isMember;
  final String organisationName;
  final GetAssessmentHeaderModel assessmentHeaders;


  @override
  StudQuestionState createState() => StudQuestionState();
}

class StudQuestionState extends State<StudQuestion> {
  late QuestionPaperModel values;
  UserDetails userDetails=UserDetails();
  Timer? countdownTimer;
  Duration myDuration = const Duration();
  List<dynamic> selected = [];
  TextEditingController ansController = TextEditingController();
  Color notSureColor1 = const Color.fromRGBO(255, 255, 255, 1);
  Color notSureColor2 = const Color.fromRGBO(255, 153, 0, 1);
  IconData notSureIcon = Icons.mode_comment_outlined;
  final DateFormat formatter = DateFormat('HH:mm');
  final DateTime now = DateTime.now();
  bool onlineValue = false;
  dynamic select;
  late Map tempQuesAns = {};
  List<int> tilecount = [1];
  StreamSubscription? connection;
  bool isOffline = false;
  Color colorCode = const Color.fromRGBO(179, 179, 179, 1);

  setTime(){
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(widget.ques.data!.assessmentEndDate!);
    final String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    print("formatted time");
    print(dateTime);
    DateTime now = DateTime.now();
    Duration difference = dateTime.difference(now);
    int hours = difference.inHours;
    int minutes = (difference.inMinutes % 60);
    int seconds = (difference.inSeconds % 60);
    int totalMinutes = (hours * 60) + minutes + (seconds ~/ 60);
    myDuration = Duration(minutes: totalMinutes>widget.ques.data!.assessmentDuration! ?  widget.ques.data!.assessmentDuration! : totalMinutes);
  }
  @override
  void didChangeDependencies() {
    selected = Provider.of<Questions>(context, listen: false).totalQuestion[
    '${context.watch<QuestionNumProvider>().questionNum}'][0];
    ansController.text = Provider.of<Questions>(context, listen: false)
        .totalQuestion['${context.watch<QuestionNumProvider>().questionNum}'][0]
        .toString()
        .substring(
        1,
        Provider.of<Questions>(context, listen: false)
            .totalQuestion[
        '${context.watch<QuestionNumProvider>().questionNum}']
        [0]
            .toString()
            .length -
            1);
    super.didChangeDependencies();
  }
  @override
  void initState() {
    // ansController.selection = TextSelection.fromPosition(TextPosition(offset: ansController.text.length,));
    setTime();
    values = widget.ques;
    print("INSIDE INIT STATE");
    print(widget.ques.data?.assessmentEndDate);


    context.read<Questions>().createQuesAns(values.data!.questions!.length);
    context.read<QuestionNumProvider>().reset();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
          isOffline = true;
        });
      }
      else {
        setState(() {
          isOffline = false;
        });
      }
    });

    if(widget.ques.data!.assessmentType=='test') {
      countdownTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    }
    else{
      countdownTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => countDownSetState());
    }
    super.initState();
  }

  void countDownSetState(){
    // setState(() {
    myDuration = const Duration(seconds: 0);
    //});
  }

  Future<void> setCountDown() async {
    const reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      int a = now.microsecondsSinceEpoch + myDuration.inMicroseconds;
      int d2 = DateTime
          .now()
          .microsecondsSinceEpoch;
      if (a <= d2) {
        countdownTimer!.cancel();
        bool submitted = Provider
            .of<Questions>(context, listen: false)
            .assessmentSubmitted;
        if (submitted) {

        }
        else {
          // var result = await Connectivity().checkConnectivity();
          Provider.of<Questions>(context, listen: false)
              .updateAssessmentSubmit(true);
          String message = '';
          int ansCorrect = 0;
          int totalMark = 0;
          int? givenMark = 0;
          PostAssessmentModel assessment = PostAssessmentModel(
              assessmentResults: []);
          assessment.assessmentId = values.data!.assessmentId!;
          assessment.assessmentCode = widget.assessmentId;
          assessment.userId = widget.userId;
          assessment.statusId = 2;
          assessment.attemptStartdate = DateTime
              .now()
              .microsecondsSinceEpoch;
          assessment.attemptEnddate = DateTime
              .now()
              .microsecondsSinceEpoch;
          var d1 = DateTime.fromMicrosecondsSinceEpoch(
              DateTime
                  .now()
                  .microsecondsSinceEpoch);
          var d2 = DateTime.fromMicrosecondsSinceEpoch(DateTime
              .now()
              .microsecondsSinceEpoch);
          int difference = d2
              .difference(d1)
              .inMinutes;
          assessment.attemptDuration = difference;
          var endTimeTaken = (d2.difference(d1).toString());
          for (int j = 1; j <= Provider
              .of<Questions>(context, listen: false)
              .totalQuestion
              .length; j++) {
            List<int> selectedAnsId = [];
            AssessmentResult quesResult = AssessmentResult();
            quesResult.questionId =
                values.data!.questions![j - 1].questionId;
            quesResult.questionTypeId =
                values.data!.questions![j - 1].questionTypeId;
            quesResult.marks = 0;
            List<dynamic> correctAns = [];
            if (values.data!.questions![j - 1].questionType ==
                "Descriptive") {
              RegExp regExp = RegExp(r'\[|\]');
              quesResult.marks = 0;
              quesResult.descriptiveText = Provider
                  .of<Questions>(context, listen: false)
                  .totalQuestion['$j'][0].toString().replaceAll(regExp, '');

              quesResult.statusId = (quesResult.descriptiveText == null || quesResult.descriptiveText!.isEmpty ) ? 5 : 8;
            }
            else if (values.data!.questions![j - 1].questionType ==
                "Survey") {
              quesResult.statusId = 8;
              List<dynamic> selectedAns = Provider
                  .of<Questions>(context, listen: false)
                  .totalQuestion['$j'][0];
              selectedAns.sort();
              List<int> key = [];
              List<String> value = [];
              for (int s = 0; s <
                  values.data!.questions![j - 1].choices!.length; s++) {
                key.add(values.data!.questions![j - 1].choices![s]
                    .choiceId!);
                value.add(values.data!.questions![j - 1].choices![s]
                    .choiceText!);
              }
              for (int f = 0; f < selectedAns.length; f++) {
                selectedAnsId.add(key[value.indexOf(selectedAns[f])]);
              }
              quesResult.selectedQuestionChoice = selectedAnsId;
              quesResult.marks = 0;
              quesResult.statusId = selectedAns.isEmpty? 5 :  8;
            }
            else {
              for (int i = 0; i <
                  values.data!.questions![j - 1].choices!.length; i++) {
                if (values.data!.questions![j - 1].choices![i]
                    .rightChoice!) {
                  correctAns.add(values.data!.questions![j - 1]
                      .choices![i].choiceText);
                }
              }
              correctAns.sort();
              List<dynamic> selectedAns = Provider
                  .of<Questions>(context, listen: false)
                  .totalQuestion['$j'][0];
              selectedAns.sort();
              if (selectedAns.isEmpty) {
                quesResult.statusId = 5;
              }
              else {
                List<int> key = [];
                List<String> value = [];
                for (int s = 0; s <
                    values.data!.questions![j - 1].choices!.length; s++) {
                  key.add(values.data!.questions![j - 1].choices![s]
                      .choiceId!);
                  value.add(values.data!.questions![j - 1].choices![s]
                      .choiceText!);
                }
                for (int f = 0; f < selectedAns.length; f++) {
                  selectedAnsId.add(key[value.indexOf(selectedAns[f])]);
                }
                quesResult.selectedQuestionChoice = selectedAnsId;

                if (listEquals(correctAns, selectedAns)) {
                  quesResult.statusId = 6;
                  quesResult.marks =
                      values.data!.questions![j - 1].questionMarks;
                  totalMark = totalMark +
                      values.data!.questions![j - 1].questionMarks!;
                  ansCorrect++;
                  givenMark = values.data!.totalScore ?? 0;
                }
                else {
                  quesResult.statusId = 7;
                }
              }
            }
            assessment.assessmentResults.add(quesResult);
          }
          totalMark == 0
              ? totalMark = assessment.attemptScore ?? 0
              : totalMark = totalMark;
          givenMark = values.data!.totalScore ?? 0;
          double f = 0;
          givenMark == 0 ? f = 0 :
          f = 100 / givenMark;
          double g = totalMark * f;
          int percent = g.round();
          assessment.attemptPercentage = percent;
          assessment.attemptScore = totalMark;

          if (percent == 100) {
            assessment.assessmentScoreId =
                values.data!.assessmentScoreMessage![0]
                    .assessmentScoreId;
            message = values.data!.assessmentScoreMessage![0]
                .assessmentScoreStatus;
          }

          else {
            assessment.assessmentScoreId =
                values.data!.assessmentScoreMessage![1]
                    .assessmentScoreId;
            message = values.data!.assessmentScoreMessage![1]
                .assessmentScoreStatus;
          }
          final DateTime now = DateTime.now();
          final DateFormat formatter = DateFormat('dd-MM-yyyy');
          final DateFormat timeFormatter = DateFormat('hh:mm a');
          final String formatted = formatter.format(now);
          final String time = timeFormatter.format(now);
          // if(result == ConnectivityResult.none){
          //   showDialogBox();
          // }
          // else {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(
                          48, 145, 139, 1),
                    ));
              });
          if(widget.ques.data?.assessmentType !='test' && isOffline) {
            Navigator.pushNamed(
                context,
                '/studentResultPage',
                arguments: [
                  totalMark,
                  formatted,
                  time,
                  values,
                  widget.assessmentId,
                  widget.userName,
                  message,
                  endTimeTaken,
                  givenMark,
                  widget.isMember,
                  widget.assessmentHeaders,
                  widget.organisationName,
                ]);
          }
          else
          {
            LoginModel loginResponse = await QnaService
                .postAssessmentService(assessment, values, userDetails);
            Navigator.of(context).pop();
            countdownTimer!.cancel();
            if (loginResponse.code == 200) {
              Navigator.pushNamed(
                  context,
                  '/studentResultPage',
                  arguments: [
                    totalMark,
                    formatted,
                    time,
                    values,
                    widget.assessmentId,
                    widget.userName,
                    message,
                    endTimeTaken,
                    givenMark,
                    widget.isMember,
                    widget.assessmentHeaders,
                    widget.organisationName,
                  ]);
            }
          }

          // Navigator.pushNamed(
          //     context,
          //     '/studentReviseQuest',
          //     arguments: [
          //       values,
          //       widget.userName,
          //       widget.assessmentId,
          //       now.microsecondsSinceEpoch,
          //       values.data!.assessmentId!,
          //       true,
          //       widget.userId,
          //       widget.isMember,
          //       widget.assessmentHeaders,
          //       myDuration
          //     ]);
          // }

        }
      }
    }
    else {
      if (widget.ques.data!.assessmentEndDate! <
          DateTime
              .now()
              .microsecondsSinceEpoch) {
        countdownTimer!.cancel();
        Navigator.pushNamed(
            context,
            '/studentReviseQuest',
            arguments: [
              values,
              widget.userName,
              widget.assessmentId,
              now.microsecondsSinceEpoch,
              values.data!.assessmentId!,
              true,
              widget.userId,
              widget.isMember,
              widget.assessmentHeaders,
              myDuration,
              isOffline
            ]);
      }
      myDuration = Duration(seconds: seconds);
    }
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String strDigits(int n) => n.toString().padLeft(2, '0');
    // Get the current time
    DateTime now = DateTime.now();

    // Extract hours, minutes, and seconds
    int hourss = now.hour;
    int minutess = now.minute;
    int secondss = now.second;
    print(myDuration);
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));



    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
          return Center(
            child: SizedBox(
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.white,
                      body: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.04,
                            left: height * 0.023,
                            right: height * 0.023
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.assessmentId,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(
                                              0, 106, 100, 1),
                                          fontSize: 25,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: height * 0.025),
                                        child: Row(
                                          children: [
                                            values.data!.assessmentType == "test" ?const Icon(Icons.timer_outlined,color: Color.fromRGBO(82, 165, 160, 1),):Container(),
                                            Text(values.data!.assessmentType == "test" ? "$hours:$minutes:$seconds" : "" ,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.02)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(values.data!.assessmentType=="practice"?
                                      values.data!.assessmentType![0].toUpperCase()+values.data!.assessmentType!.substring(1):"",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(
                                              255, 157, 77, 1),
                                          fontSize: 25,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: height * 0.6675,
                                width: width * 0.7,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width * 0.18,
                                            child: Center(
                                              child: Text(
                                                "${context.watch<QuestionNumProvider>().questionNum} of ${values.data!.questions!.length}",
                                                style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: height * 0.025),
                                              ),
                                            ),
                                          ),
                                          values.data!.questions![context.watch<QuestionNumProvider>().questionNum - 1].choices!.where((element) => element.rightChoice ?? false).map((e) => e.choiceText).length > 1
                                              ?
                                          Text(
                                            "Multiple Choice",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                // height: height * 0.0020,
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          )
                                              :const Text(""),
                                          values
                                              .data!
                                              .questions![context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum -
                                              1]
                                              .questionType == "Survey" || values
                                              .data!
                                              .questions![context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum -
                                              1]
                                              .questionType == "Descriptive"?
                                          Container()
                                              :Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15)),
                                              color: Color.fromRGBO(28, 78, 80, 1),
                                            ),
                                            height: height * 0.0625,
                                            width:  width * 0.18,
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  values
                                                      .data!
                                                      .questions![context
                                                      .watch<
                                                      QuestionNumProvider>()
                                                      .questionNum -
                                                      1]
                                                      .questionType ==
                                                      "MCQ"
                                                      ? "${values.data!.questions![context.watch<QuestionNumProvider>().questionNum - 1].questionMarks}"
                                                      : "0",
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize:
                                                      height * 0.0237)),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .marks_qn,
                                                  // " Marks",
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize:
                                                      height * 0.0137)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: height * 0.02,
                                            right: height * 0.02,
                                            bottom: height * 0.025),
                                        child: SizedBox(
                                          height: height * 0.16,
                                          width: webWidth * 0.744,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              values
                                                  .data!
                                                  .questions![context
                                                  .watch<
                                                  QuestionNumProvider>()
                                                  .questionNum -
                                                  1]
                                                  .question!,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontFamily: 'Inter',
                                                  // height: height * 0.0020,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.32,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: values
                                              .data!
                                              .questions![context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum -
                                              1]
                                              .questionType ==
                                              "Descriptive"
                                              ? Card(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  onChanged: (ans) {
                                                    if (ansController
                                                        .text.isEmpty) {
                                                      selected = [];
                                                      context
                                                          .read<Questions>()
                                                          .selectOption(
                                                          Provider.of<QuestionNumProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .questionNum,
                                                          selected,
                                                          const Color
                                                              .fromRGBO(
                                                              219,
                                                              35,
                                                              35,
                                                              1),
                                                          false);
                                                    } else {
                                                      selected = [];
                                                      ans = ansController.text;
                                                      selected.add(ans);
                                                      context
                                                          .read<Questions>()
                                                          .selectOption(
                                                          Provider.of<QuestionNumProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .questionNum,
                                                          selected,
                                                          const Color
                                                              .fromRGBO(
                                                              82,
                                                              165,
                                                              160,
                                                              1),
                                                          false);
                                                    }
                                                  },
                                                  controller: ansController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                    AppLocalizations.of(
                                                        context)!
                                                        .enter_text_here,
                                                    //   "Enter your text here",
                                                    border:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .black54)),
                                                  ),
                                                  maxLines: (height * 0.013).round(), //or null
                                                ),
                                              ))
                                              : ChooseWidget(
                                              question: values,
                                              selected: selected,
                                              height: height,
                                              width: webWidth),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: height * 0.035,
                                  left: height * 0.023,
                                  bottom: height * 0.055,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    context
                                        .watch<QuestionNumProvider>()
                                        .questionNum <=
                                        1
                                        ?
                                    ElevatedButton(
                                      style:ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            209, 209, 209, 1),
                                        shape: const CircleBorder(),
                                      ),

                                      onPressed: () {

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: height * 0.04,
                                        ),
                                      ),
                                    )
                                        : ElevatedButton(
                                      style:ElevatedButton.styleFrom(
                                        backgroundColor: context
                                            .watch<
                                            QuestionNumProvider>()
                                            .questionNum ==
                                            1
                                            ? const Color.fromRGBO(
                                            209, 209, 209, 1)
                                            : const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        shape: const CircleBorder(),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: height * 0.04,
                                        ),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<QuestionNumProvider>()
                                            .decrement();
                                        if (Provider.of<Questions>(context,
                                            listen: false)
                                            .totalQuestion[
                                        '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum + 1}']
                                        [2] ==
                                            true) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum +
                                                  1,
                                              selected,
                                              const Color.fromRGBO(
                                                  239, 218, 30, 1),
                                              true);
                                        } else if (selected.isNotEmpty) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum +
                                                  1,
                                              selected,
                                              const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              false);
                                        } else {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum +
                                                  1,
                                              selected,
                                              const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              false);
                                        }
                                      },
                                    ),
                                    tilecount.length ==
                                        Provider.of<Questions>(context,
                                            listen: false)
                                            .totalQuestion
                                            .length
                                        ? tilecount.length ==
                                        context
                                            .watch<QuestionNumProvider>()
                                            .questionNum
                                        ? const SizedBox()
                                        : MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (Provider.of<Questions>(context,
                                                listen: false)
                                                .totalQuestion[
                                            '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                            [2] ==
                                                true) {
                                              context.read<Questions>().selectOption(
                                                  Provider.of<QuestionNumProvider>(
                                                      context,
                                                      listen: false)
                                                      .questionNum,
                                                  selected,
                                                  const Color.fromRGBO(
                                                      239, 218, 30, 1),
                                                  true);
                                            }
                                            else if (selected.isNotEmpty) {
                                              context.read<Questions>().selectOption(
                                                  Provider.of<QuestionNumProvider>(
                                                      context,
                                                      listen: false)
                                                      .questionNum,
                                                  selected,
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  false);
                                            } else {
                                              context.read<Questions>().selectOption(
                                                  Provider.of<QuestionNumProvider>(
                                                      context,
                                                      listen: false)
                                                      .questionNum,
                                                  selected,
                                                  const Color.fromRGBO(
                                                      219, 35, 35, 1),
                                                  false);
                                            }
                                            // if(widget.ques.data!.assessmentType=='test') {
                                            //   countdownTimer!.cancel();
                                            // }

                                            if(widget.ques.data?.assessmentType !='test' && isOffline)
                                            {
                                              Navigator.pushNamed(
                                                  context,
                                                  '/studentReviseQuest',
                                                  arguments: [
                                                    values,
                                                    widget.userName,
                                                    widget.assessmentId,
                                                    now.microsecondsSinceEpoch,
                                                    values.data!.assessmentId!,
                                                    false,
                                                    widget.userId,
                                                    widget.isMember,
                                                    widget.assessmentHeaders,
                                                    myDuration,
                                                    widget.organisationName,
                                                    isOffline
                                                  ]);
                                            }
                                            else
                                              {
                                                Navigator.pushNamed(
                                                    context,
                                                    '/studentReviseQuest',
                                                    arguments: [
                                                      values,
                                                      widget.userName,
                                                      widget.assessmentId,
                                                      now.microsecondsSinceEpoch,
                                                      values.data!.assessmentId!,
                                                      false,
                                                      widget.userId,
                                                      widget.isMember,
                                                      widget.assessmentHeaders,
                                                      myDuration,
                                                      widget.organisationName,
                                                      isOffline
                                                    ]);
                                              }

                                          },
                                          child: Container(
                                            height: height * 0.0475,
                                            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(36)),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                      context)!
                                                      .go_to_revise_sheet,
                                                  //"Skip to end",
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color: const Color
                                                          .fromRGBO(
                                                          82,
                                                          165,
                                                          160,
                                                          1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: height *
                                                          0.018)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                        : const SizedBox(),
                                    context
                                        .watch<QuestionNumProvider>()
                                        .questionNum >=
                                        values.data!.questions!.length
                                        ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height)),
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(
                                              context)!.review,
                                          style: TextStyle(fontSize: height * 0.03),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (Provider.of<Questions>(context,
                                            listen: false)
                                            .totalQuestion[
                                        '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                        [2] ==
                                            true) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  239, 218, 30, 1),
                                              true);
                                        }
                                        else if (selected.isNotEmpty) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              false);
                                        } else {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              false);
                                        }
                                        // if(widget.ques.data!.assessmentType=='test') {
                                        //   countdownTimer!.cancel();
                                        // }
                                        if(widget.ques.data?.assessmentType !='test' && isOffline) {

                                          Navigator.pushNamed(
                                              context,
                                              '/studentReviseQuest',
                                              arguments: [
                                                values,
                                                widget.userName,
                                                widget.assessmentId,
                                                now.microsecondsSinceEpoch,
                                                values.data!.assessmentId!,
                                                false,
                                                widget.userId,
                                                widget.isMember,
                                                widget.assessmentHeaders,
                                                myDuration,
                                                widget.organisationName,
                                                isOffline
                                              ]);
                                        }
                                        else
                                        {
                                          Navigator.pushNamed(
                                              context,
                                              '/studentReviseQuest',
                                              arguments: [
                                                values,
                                                widget.userName,
                                                widget.assessmentId,
                                                now.microsecondsSinceEpoch,
                                                values.data!.assessmentId!,
                                                false,
                                                widget.userId,
                                                widget.isMember,
                                                widget.assessmentHeaders,
                                                myDuration,
                                                widget.organisationName,
                                                isOffline
                                              ]);
                                        }
                                      },
                                    )
                                        : ElevatedButton(
                                        onPressed: () {

                                          context.read<QuestionNumProvider>().increment();

                                          if (Provider.of<Questions>(context,
                                              listen: false)
                                              .totalQuestion[
                                          '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum - 1}']
                                          [2] ==
                                              true) {
                                            context.read<Questions>().selectOption(
                                                Provider.of<QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                    .questionNum -
                                                    1,
                                                selected,
                                                const Color.fromRGBO(
                                                    239, 218, 30, 1),
                                                true);
                                          }
                                          else if (selected.isNotEmpty) {
                                            context.read<Questions>().selectOption(
                                                Provider.of<QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                    .questionNum -
                                                    1,
                                                selected,
                                                const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                false);
                                          }
                                          else {
                                            context.read<Questions>().selectOption(
                                                Provider.of<QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                    .questionNum -
                                                    1,
                                                selected,
                                                const Color.fromRGBO(
                                                    219, 35, 35, 1),
                                                false);
                                          }
                                          if (tilecount.contains(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum)) {
                                          }
                                          else {
                                            tilecount.add(Provider.of<
                                                QuestionNumProvider>(
                                                context,
                                                listen: false)
                                                .questionNum);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum ==
                                              values.data!.questions!.length
                                              ? const Color.fromRGBO(
                                              209, 209, 209, 1)
                                              : const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          shape: const CircleBorder(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: height * 0.04,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ]),
                      ))),
            ),
          );
        }
        else if(constraints.maxWidth > 960)
        {
          return Center(
            child: SizedBox(
              child: WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.white,
                      body: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.023,
                            left: height * 0.023,
                            right: height * 0.023),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right:width * 0.27, left:width * 0.27),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(widget.assessmentId,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                0, 106, 100, 1),
                                            fontSize: height * 0.0455,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: height * 0.025),
                                          child: Row(
                                            children: [
                                              values.data!.assessmentType == "test" ?const Icon(Icons.timer_outlined,color: Color.fromRGBO(82, 165, 160, 1),):Container(),
                                              Text(values.data!.assessmentType == "test" ? "$hours:$minutes:$seconds" : "" ,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: height * 0.032)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          values.data!.assessmentType=="practice"?
                                          values.data!.assessmentType![0].toUpperCase()+values.data!.assessmentType!.substring(1):"",
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                                255, 157, 77, 1),
                                            fontSize: 25,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.6675,
                                width: width * 0.4,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0625,
                                            width: webWidth * 0.2277,
                                            child: Center(
                                              child: Text(
                                                "${context.watch<QuestionNumProvider>().questionNum} of ${values.data!.questions!.length}",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: height * 0.025)),
                                              ),
                                            ),
                                          ),
                                          values.data!.questions![context.watch<QuestionNumProvider>().questionNum - 1].choices!.where((element) => element.rightChoice ?? false).map((e) => e.choiceText).length > 1
                                              ?
                                          Text(
                                            "Multiple Choice",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                fontFamily: 'Inter',
                                                // height: height * 0.0020,
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02),
                                          )
                                              :const Text(""),
                                          values
                                              .data!
                                              .questions![context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum -
                                              1]
                                              .questionType ==
                                              "Survey" || values
                                              .data!
                                              .questions![context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum -
                                              1]
                                              .questionType == "Descriptive"?Container():
                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15)),
                                              color: Color.fromRGBO(28, 78, 80, 1),
                                            ),
                                            height: height * 0.0625,
                                            width: webWidth * 0.2277,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  values
                                                      .data!
                                                      .questions![context
                                                      .watch<
                                                      QuestionNumProvider>()
                                                      .questionNum -
                                                      1]
                                                      .questionType ==
                                                      "MCQ"
                                                      ? "${values.data!.questions![context.watch<QuestionNumProvider>().questionNum - 1].questionMarks}"
                                                      : "0",
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize:
                                                      height * 0.0237)),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .marks_qn,
                                                  // " Marks",
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color:
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize:
                                                      height * 0.0137)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: height * 0.02,
                                            right: height * 0.02,
                                            bottom: height * 0.025),
                                        child: SizedBox(
                                          height: height * 0.16,
                                          width: webWidth * 0.744,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              values
                                                  .data!
                                                  .questions![context
                                                  .watch<
                                                  QuestionNumProvider>()
                                                  .questionNum -
                                                  1]
                                                  .question!,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyLarge
                                                  ?.merge(TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontFamily: 'Inter',
                                                  // height: height * 0.0020,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.02)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.32,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: values
                                              .data!
                                              .questions![context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum -
                                              1]
                                              .questionType ==
                                              "Descriptive"
                                              ? Card(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  onChanged: (ans) {
                                                    if (ansController
                                                        .text.isEmpty) {
                                                      selected = [];
                                                      context
                                                          .read<Questions>()
                                                          .selectOption(
                                                          Provider.of<QuestionNumProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .questionNum,
                                                          selected,
                                                          const Color
                                                              .fromRGBO(
                                                              219,
                                                              35,
                                                              35,
                                                              1),
                                                          false);
                                                    } else {
                                                      selected = [];
                                                      ans = ansController.text;
                                                      selected.add(ans);
                                                      context
                                                          .read<Questions>()
                                                          .selectOption(
                                                          Provider.of<QuestionNumProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .questionNum,
                                                          selected,
                                                          const Color
                                                              .fromRGBO(
                                                              82,
                                                              165,
                                                              160,
                                                              1),
                                                          false);
                                                    }
                                                  },
                                                  controller: ansController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                    AppLocalizations.of(
                                                        context)!
                                                        .enter_text_here,
                                                    //   "Enter your text here",
                                                    border:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .black54)),
                                                  ),
                                                  maxLines: (height * 0.013).round(), //or null
                                                ),
                                              ))
                                              : ChooseWidget(
                                              question: values,
                                              selected: selected,
                                              height: height,
                                              width: webWidth),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: width * 0.27,
                                  left: width * 0.27,
                                  bottom: height * 0.055,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    context
                                        .watch<QuestionNumProvider>()
                                        .questionNum <=
                                        1
                                        ? ElevatedButton(
                                      style:ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            209, 209, 209, 1),
                                        shape: const CircleBorder(),
                                      ),

                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: height * 0.04,
                                        ),
                                      ),
                                    )
                                        : ElevatedButton(
                                      style:ElevatedButton.styleFrom(
                                        backgroundColor: context
                                            .watch<
                                            QuestionNumProvider>()
                                            .questionNum ==
                                            1
                                            ? const Color.fromRGBO(
                                            209, 209, 209, 1)
                                            : const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        shape: const CircleBorder(),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: height * 0.04,
                                        ),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<QuestionNumProvider>()
                                            .decrement();
                                        if (Provider.of<Questions>(context,
                                            listen: false)
                                            .totalQuestion[
                                        '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum + 1}']
                                        [2] ==
                                            true) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum +
                                                  1,
                                              selected,
                                              const Color.fromRGBO(
                                                  239, 218, 30, 1),
                                              true);
                                        } else if (selected.isNotEmpty) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum +
                                                  1,
                                              selected,
                                              const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              false);
                                        } else {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum +
                                                  1,
                                              selected,
                                              const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              false);
                                        }
                                      },
                                    ),
                                    tilecount.length ==
                                        Provider.of<Questions>(context,
                                            listen: false)
                                            .totalQuestion
                                            .length
                                        ? tilecount.length ==
                                        context
                                            .watch<QuestionNumProvider>()
                                            .questionNum
                                        ? const SizedBox()
                                        : MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (Provider.of<Questions>(context,
                                                listen: false)
                                                .totalQuestion[
                                            '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                            [2] ==
                                                true) {
                                              context.read<Questions>().selectOption(
                                                  Provider.of<QuestionNumProvider>(
                                                      context,
                                                      listen: false)
                                                      .questionNum,
                                                  selected,
                                                  const Color.fromRGBO(
                                                      239, 218, 30, 1),
                                                  true);
                                            }
                                            else if (selected.isNotEmpty) {
                                              context.read<Questions>().selectOption(
                                                  Provider.of<QuestionNumProvider>(
                                                      context,
                                                      listen: false)
                                                      .questionNum,
                                                  selected,
                                                  const Color.fromRGBO(
                                                      82, 165, 160, 1),
                                                  false);
                                            } else {
                                              context.read<Questions>().selectOption(
                                                  Provider.of<QuestionNumProvider>(
                                                      context,
                                                      listen: false)
                                                      .questionNum,
                                                  selected,
                                                  const Color.fromRGBO(
                                                      219, 35, 35, 1),
                                                  false);
                                            }
                                            // if(widget.ques.data!.assessmentType=='test') {
                                            //   countdownTimer!.cancel();
                                            // }
                                            if(widget.ques.data?.assessmentType !='test' && isOffline) {

                                              Navigator.pushNamed(
                                                  context,
                                                  '/studentReviseQuest',
                                                  arguments: [
                                                    values,
                                                    widget.userName,
                                                    widget.assessmentId,
                                                    now.microsecondsSinceEpoch,
                                                    values.data!.assessmentId!,
                                                    false,
                                                    widget.userId,
                                                    widget.isMember,
                                                    widget.assessmentHeaders,
                                                    myDuration,
                                                    widget.organisationName,
                                                    isOffline
                                                  ]);
                                            }
                                            else
                                            {
                                              Navigator.pushNamed(
                                                  context,
                                                  '/studentReviseQuest',
                                                  arguments: [
                                                    values,
                                                    widget.userName,
                                                    widget.assessmentId,
                                                    now.microsecondsSinceEpoch,
                                                    values.data!.assessmentId!,
                                                    false,
                                                    widget.userId,
                                                    widget.isMember,
                                                    widget.assessmentHeaders,
                                                    myDuration,
                                                    widget.organisationName,
                                                    isOffline
                                                  ]);
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: height * 0.005),
                                            height: height * 0.0475,
                                            width: webWidth * 0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(36)),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      82, 165, 160, 1)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                      context)!
                                                      .go_to_revise_sheet,
                                                  //"Skip to end",
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .bodyLarge
                                                      ?.merge(TextStyle(
                                                      color: const Color
                                                          .fromRGBO(
                                                          82,
                                                          165,
                                                          160,
                                                          1),
                                                      fontFamily: 'Inter',
                                                      height:
                                                      height * 0.0020,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: height *
                                                          0.018)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                        : const SizedBox(),
                                    context
                                        .watch<QuestionNumProvider>()
                                        .questionNum >=
                                        values.data!.questions!.length
                                        ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height)),
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(
                                              context)!.review,
                                          style: TextStyle(fontSize: height * 0.03),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (Provider.of<Questions>(context,
                                            listen: false)
                                            .totalQuestion[
                                        '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                        [2] ==
                                            true) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  239, 218, 30, 1),
                                              true);
                                        }
                                        else if (selected.isNotEmpty) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              false);
                                        } else {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              false);
                                        }
                                        // if(widget.ques.data!.assessmentType=='test') {
                                        //   countdownTimer!.cancel();
                                        // }
                                        if(widget.ques.data?.assessmentType !='test' && isOffline) {

                                          Navigator.pushNamed(
                                              context,
                                              '/studentReviseQuest',
                                              arguments: [
                                                values,
                                                widget.userName,
                                                widget.assessmentId,
                                                now.microsecondsSinceEpoch,
                                                values.data!.assessmentId!,
                                                false,
                                                widget.userId,
                                                widget.isMember,
                                                widget.assessmentHeaders,
                                                myDuration,
                                                widget.organisationName,
                                                isOffline
                                              ]);
                                        }
                                        else
                                        {
                                          Navigator.pushNamed(
                                              context,
                                              '/studentReviseQuest',
                                              arguments: [
                                                values,
                                                widget.userName,
                                                widget.assessmentId,
                                                now.microsecondsSinceEpoch,
                                                values.data!.assessmentId!,
                                                false,
                                                widget.userId,
                                                widget.isMember,
                                                widget.assessmentHeaders,
                                                myDuration,
                                                widget.organisationName,
                                                isOffline
                                              ]);
                                        }
                                      },
                                    )
                                        : ElevatedButton(
                                        onPressed: () {

                                          context.read<QuestionNumProvider>().increment();

                                          if (Provider.of<Questions>(context,
                                              listen: false)
                                              .totalQuestion[
                                          '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum - 1}']
                                          [2] ==
                                              true) {
                                            context.read<Questions>().selectOption(
                                                Provider.of<QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                    .questionNum -
                                                    1,
                                                selected,
                                                const Color.fromRGBO(
                                                    239, 218, 30, 1),
                                                true);
                                          }
                                          else if (selected.isNotEmpty) {
                                            context.read<Questions>().selectOption(
                                                Provider.of<QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                    .questionNum -
                                                    1,
                                                selected,
                                                const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                false);
                                          }
                                          else {
                                            context.read<Questions>().selectOption(
                                                Provider.of<QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                    .questionNum -
                                                    1,
                                                selected,
                                                const Color.fromRGBO(
                                                    219, 35, 35, 1),
                                                false);
                                          }
                                          if (tilecount.contains(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum)) {
                                          }
                                          else {
                                            tilecount.add(Provider.of<
                                                QuestionNumProvider>(
                                                context,
                                                listen: false)
                                                .questionNum);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum ==
                                              values.data!.questions!.length
                                              ? const Color.fromRGBO(
                                              209, 209, 209, 1)
                                              : const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          shape: const CircleBorder(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: height * 0.04,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ]),
                      ))),
            ),
          );
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.04,
                        left: height * 0.023,
                        right: height * 0.023),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.assessmentId,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(
                                          0, 106, 100, 1),
                                      fontSize: 25,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: height * 0.025),
                                    child: Row(
                                      children: [
                                        values.data!.assessmentType == "test" ?const Icon(Icons.timer_outlined,color: Color.fromRGBO(82, 165, 160, 1),):Container(),
                                        Text(values.data!.assessmentType == "test" ? "$hours:$minutes:$seconds" : "" ,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.02)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    values.data!.assessmentType=="practice"?
                                    values.data!.assessmentType![0].toUpperCase()+values.data!.assessmentType!.substring(1):"",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(
                                          255, 157, 77, 1),
                                      fontSize: 25,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: height * 0.6675,
                            width: webWidth * 0.855,
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: height * 0.0625,
                                        width: webWidth * 0.2277,
                                        child: Center(
                                          child: Text(
                                            "${context.watch<QuestionNumProvider>().questionNum} of ${values.data!.questions!.length}",
                                            style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: height * 0.025),
                                          ),
                                        ),
                                      ),
                                      values.data!.questions![context.watch<QuestionNumProvider>().questionNum - 1].choices!.where((element) => element.rightChoice ?? false).map((e) => e.choiceText).length > 1
                                          ?
                                      Text(
                                        "Multiple Choice",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            // height: height * 0.0020,
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.02),
                                      )
                                          :const Text(""),
                                      values
                                          .data!
                                          .questions![context
                                          .watch<
                                          QuestionNumProvider>()
                                          .questionNum -
                                          1]
                                          .questionType ==
                                          "Survey" || values
                                          .data!
                                          .questions![context
                                          .watch<
                                          QuestionNumProvider>()
                                          .questionNum -
                                          1]
                                          .questionType == "Descriptive"
                                          ?
                                      Container()
                                          : Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          color: Color.fromRGBO(28, 78, 80, 1),
                                        ),
                                        height: height * 0.0625,
                                        width: webWidth * 0.2277,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              values
                                                  .data!
                                                  .questions![context
                                                  .watch<
                                                  QuestionNumProvider>()
                                                  .questionNum -
                                                  1]
                                                  .questionType ==
                                                  "MCQ"
                                                  ? "${values.data!.questions![context.watch<QuestionNumProvider>().questionNum - 1].questionMarks}"
                                                  : "0",
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyLarge
                                                  ?.merge(TextStyle(
                                                  color:
                                                  const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize:
                                                  height * 0.0237)),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .marks_qn,
                                              // " Marks",
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyLarge
                                                  ?.merge(TextStyle(
                                                  color:
                                                  const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize:
                                                  height * 0.0137)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: height * 0.02,
                                        right: height * 0.02,
                                        bottom: height * 0.025),
                                    child: SizedBox(
                                      height: height * 0.16,
                                      width: webWidth * 0.744,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Text(
                                          values
                                              .data!
                                              .questions![context
                                              .watch<
                                              QuestionNumProvider>()
                                              .questionNum -
                                              1]
                                              .question!,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyLarge
                                              ?.merge(TextStyle(
                                              color: const Color.fromRGBO(
                                                  51, 51, 51, 1),
                                              fontFamily: 'Inter',
                                              // height: height * 0.0020,
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.02)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.32,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: values
                                          .data!
                                          .questions![context
                                          .watch<
                                          QuestionNumProvider>()
                                          .questionNum -
                                          1]
                                          .questionType ==
                                          "Descriptive"
                                          ? Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: TextField(
                                              onChanged: (ans) {
                                                if (ansController
                                                    .text.isEmpty) {
                                                  selected = [];
                                                  context
                                                      .read<Questions>()
                                                      .selectOption(
                                                      Provider.of<QuestionNumProvider>(
                                                          context,
                                                          listen:
                                                          false)
                                                          .questionNum,
                                                      selected,
                                                      const Color
                                                          .fromRGBO(
                                                          219,
                                                          35,
                                                          35,
                                                          1),
                                                      false);
                                                } else {
                                                  selected = [];
                                                  ans = ansController.text;
                                                  selected.add(ans);
                                                  context
                                                      .read<Questions>()
                                                      .selectOption(
                                                      Provider.of<QuestionNumProvider>(
                                                          context,
                                                          listen:
                                                          false)
                                                          .questionNum,
                                                      selected,
                                                      const Color
                                                          .fromRGBO(
                                                          82,
                                                          165,
                                                          160,
                                                          1),
                                                      false);
                                                }
                                              },
                                              controller: ansController,
                                              decoration: InputDecoration(
                                                hintText:
                                                AppLocalizations.of(
                                                    context)!
                                                    .enter_text_here,
                                                //   "Enter your text here",
                                                border:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .black54)),
                                              ),
                                              maxLines: (height * 0.013).round(), //or null
                                            ),
                                          ))
                                          : ChooseWidget(
                                          question: values,
                                          selected: selected,
                                          height: height,
                                          width: width),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: height * 0.023,
                              left: height * 0.023,
                              bottom: height * 0.055,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                context
                                    .watch<QuestionNumProvider>()
                                    .questionNum <=
                                    1
                                    ? ElevatedButton(
                                  style:ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(
                                        209, 209, 209, 1),
                                    shape: const CircleBorder(),
                                  ),

                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: height * 0.04,
                                    ),
                                  ),
                                )
                                    :
                                ElevatedButton(
                                  style:ElevatedButton.styleFrom(
                                    backgroundColor: context
                                        .watch<
                                        QuestionNumProvider>()
                                        .questionNum ==
                                        1
                                        ? const Color.fromRGBO(
                                        209, 209, 209, 1)
                                        : const Color.fromRGBO(
                                        82, 165, 160, 1),
                                    shape: const CircleBorder(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: height * 0.04,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<QuestionNumProvider>()
                                        .decrement();
                                    if (Provider.of<Questions>(context,
                                        listen: false)
                                        .totalQuestion[
                                    '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum + 1}']
                                    [2] ==
                                        true) {
                                      context.read<Questions>().selectOption(
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum +
                                              1,
                                          selected,
                                          const Color.fromRGBO(
                                              239, 218, 30, 1),
                                          true);
                                    } else if (selected.isNotEmpty) {
                                      context.read<Questions>().selectOption(
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum +
                                              1,
                                          selected,
                                          const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          false);
                                    } else {
                                      context.read<Questions>().selectOption(
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum +
                                              1,
                                          selected,
                                          const Color.fromRGBO(
                                              219, 35, 35, 1),
                                          false);
                                    }
                                  },
                                ),
                                tilecount.length ==
                                    Provider.of<Questions>(context,
                                        listen: false)
                                        .totalQuestion
                                        .length
                                    ? tilecount.length ==
                                    context
                                        .watch<QuestionNumProvider>()
                                        .questionNum
                                    ? const SizedBox()
                                    : MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (Provider.of<Questions>(context,
                                            listen: false)
                                            .totalQuestion[
                                        '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                        [2] ==
                                            true) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  239, 218, 30, 1),
                                              true);
                                        }
                                        else if (selected.isNotEmpty) {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                              false);
                                        }
                                        else {
                                          context.read<Questions>().selectOption(
                                              Provider.of<QuestionNumProvider>(
                                                  context,
                                                  listen: false)
                                                  .questionNum,
                                              selected,
                                              const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              false);
                                        }
                                        // if(widget.ques.data!.assessmentType=='test') {
                                        //   countdownTimer!.cancel();
                                        // }
                                        if(widget.ques.data?.assessmentType !='test' && isOffline) {

                                          Navigator.pushNamed(
                                              context,
                                              '/studentReviseQuest',
                                              arguments: [
                                                values,
                                                widget.userName,
                                                widget.assessmentId,
                                                now.microsecondsSinceEpoch,
                                                values.data!.assessmentId!,
                                                false,
                                                widget.userId,
                                                widget.isMember,
                                                widget.assessmentHeaders,
                                                myDuration,
                                                widget.organisationName,
                                                isOffline
                                              ]);
                                        }
                                        else
                                        {
                                          Navigator.pushNamed(
                                              context,
                                              '/studentReviseQuest',
                                              arguments: [
                                                values,
                                                widget.userName,
                                                widget.assessmentId,
                                                now.microsecondsSinceEpoch,
                                                values.data!.assessmentId!,
                                                false,
                                                widget.userId,
                                                widget.isMember,
                                                widget.assessmentHeaders,
                                                myDuration,
                                                widget.organisationName,
                                                isOffline
                                              ]);
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: height * 0.004),
                                        height: height * 0.0475,
                                        width: webWidth * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(36)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  82, 165, 160, 1)),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(
                                                    context)!
                                                    .go_to_revise_sheet,
                                                //"Skip to end",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                    ?.merge(TextStyle(
                                                    color: const Color
                                                        .fromRGBO(
                                                        82,
                                                        165,
                                                        160,
                                                        1),
                                                    fontFamily: 'Inter',
                                                    height:
                                                    height * 0.0020,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: height *
                                                        0.014)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                    : const SizedBox(),
                                context
                                    .watch<QuestionNumProvider>()
                                    .questionNum >=
                                    values.data!.questions!.length
                                    ?
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height)),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(
                                          context)!.review,
                                      style: TextStyle(fontSize: height * 0.03),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (Provider.of<Questions>(context,
                                        listen: false)
                                        .totalQuestion[
                                    '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                    [2] ==
                                        true) {
                                      context.read<Questions>().selectOption(
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum,
                                          selected,
                                          const Color.fromRGBO(
                                              239, 218, 30, 1),
                                          true);
                                    }
                                    else if (selected.isNotEmpty) {
                                      context.read<Questions>().selectOption(
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum,
                                          selected,
                                          const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          false);
                                    } else {
                                      context.read<Questions>().selectOption(
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum,
                                          selected,
                                          const Color.fromRGBO(
                                              219, 35, 35, 1),
                                          false);
                                    }
                                    // if(widget.ques.data!.assessmentType=='test') {
                                    //   countdownTimer!.cancel();
                                    // }
                                    if(widget.ques.data?.assessmentType !='test' && isOffline) {


                                      Navigator.pushNamed(
                                          context,
                                          '/studentReviseQuest',
                                          arguments: [
                                            values,
                                            widget.userName,
                                            widget.assessmentId,
                                            now.microsecondsSinceEpoch,
                                            values.data!.assessmentId!,
                                            false,
                                            widget.userId,
                                            widget.isMember,
                                            widget.assessmentHeaders,
                                            myDuration,
                                            widget.organisationName,
                                            isOffline
                                          ]);
                                    }
                                    else
                                    {
                                      Navigator.pushNamed(
                                          context,
                                          '/studentReviseQuest',
                                          arguments: [
                                            values,
                                            widget.userName,
                                            widget.assessmentId,
                                            now.microsecondsSinceEpoch,
                                            values.data!.assessmentId!,
                                            false,
                                            widget.userId,
                                            widget.isMember,
                                            widget.assessmentHeaders,
                                            myDuration,
                                            widget.organisationName,
                                            isOffline
                                          ]);
                                    }
                                  },
                                )
                                    :
                                ElevatedButton(
                                    onPressed: () {

                                      context.read<QuestionNumProvider>().increment();

                                      if (Provider.of<Questions>(context,
                                          listen: false)
                                          .totalQuestion[
                                      '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum - 1}']
                                      [2] ==
                                          true) {
                                        context.read<Questions>().selectOption(
                                            Provider.of<QuestionNumProvider>(
                                                context,
                                                listen: false)
                                                .questionNum -
                                                1,
                                            selected,
                                            const Color.fromRGBO(
                                                239, 218, 30, 1),
                                            true);
                                      }
                                      else if (selected.isNotEmpty) {
                                        context.read<Questions>().selectOption(
                                            Provider.of<QuestionNumProvider>(
                                                context,
                                                listen: false)
                                                .questionNum -
                                                1,
                                            selected,
                                            const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            false);
                                      }
                                      else {
                                        context.read<Questions>().selectOption(
                                            Provider.of<QuestionNumProvider>(
                                                context,
                                                listen: false)
                                                .questionNum -
                                                1,
                                            selected,
                                            const Color.fromRGBO(
                                                219, 35, 35, 1),
                                            false);
                                      }
                                      if (tilecount.contains(
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum)) {
                                      }
                                      else {
                                        tilecount.add(Provider.of<
                                            QuestionNumProvider>(
                                            context,
                                            listen: false)
                                            .questionNum);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: context
                                          .watch<
                                          QuestionNumProvider>()
                                          .questionNum ==
                                          values.data!.questions!.length
                                          ? const Color.fromRGBO(
                                          209, 209, 209, 1)
                                          : const Color.fromRGBO(
                                          82, 165, 160, 1),
                                      shape: const CircleBorder(),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: height * 0.04,
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ]),
                  )));
        }
      },
    );
  }
}

class ChooseWidget extends StatefulWidget {
  const ChooseWidget({
    Key? key,
    required this.question,
    required this.selected,
    required this.height,
    required this.width,
  }) : super(key: key);

  final QuestionPaperModel question;
  final List selected;
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
        for (int j = 1;
        j <=
            widget.question
                .data!
                .questions![
            context.watch<QuestionNumProvider>().questionNum - 1]
                .choices!
                .length;
        j++)
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if (widget.selected.contains(widget.question.data!.questions![
                  Provider.of<QuestionNumProvider>(context, listen: false).questionNum - 1]
                      .choices![j - 1]
                      .choiceText)) {
                    widget.selected.remove(widget.question
                        .data!
                        .questions![
                    Provider.of<QuestionNumProvider>(context, listen: false)
                        .questionNum -
                        1]
                        .choices![j - 1]
                        .choiceText);
                    if (widget.selected.isEmpty) {
                      context.read<Questions>().selectOption(
                          Provider.of<QuestionNumProvider>(context, listen: false)
                              .questionNum,
                          widget.selected,
                          const Color.fromRGBO(219, 35, 35, 1),
                          false);
                    }
                    else {
                      context.read<Questions>().selectOption(
                          Provider.of<QuestionNumProvider>(context, listen: false)
                              .questionNum,
                          widget.selected,
                          const Color.fromRGBO(82, 165, 160, 1),
                          false);
                    }
                  }
                  else {
                    widget.selected.add(widget.question
                        .data!
                        .questions![
                    Provider.of<QuestionNumProvider>(context, listen: false)
                        .questionNum -
                        1]
                        .choices![j - 1]
                        .choiceText);
                    context.read<Questions>().selectOption(
                        Provider.of<QuestionNumProvider>(context, listen: false)
                            .questionNum,
                        widget.selected,
                        const Color.fromRGBO(82, 165, 160, 1),
                        false);
                  }
                  setState(() {

                  });

                },
                //poke
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: widget.height * 0.013,
                          left: widget.width * 0.05,
                          right: widget.width * 0.04),
                      child: Row(
                        children: [
                          SizedBox(
                            width:widget.width * 0.05,
                            child: Text(
                              "${String.fromCharCode(96+j)}. ",
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize:  widget.height * 0.018,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                              width: widget.width * 0.6,
                              //height: widget.height * 0.0512,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: const Color.fromRGBO(209, 209, 209, 1)),
                                color: (widget.selected.contains(widget.question
                                    .data!
                                    .questions![Provider.of<QuestionNumProvider>(
                                    context,
                                    listen: false)
                                    .questionNum -
                                    1]
                                    .choices![j - 1]
                                    .choiceText))
                                    ? const Color.fromRGBO(82, 165, 160, 1)
                                    : const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: widget.width * 0.02,
                                    ),
                                    Flexible(
                                      child: Text(
                                        widget.question
                                            .data!
                                            .questions![context
                                            .watch<QuestionNumProvider>()
                                            .questionNum -
                                            1]
                                            .choices![j - 1]
                                            .choiceText!,
                                        style: TextStyle(
                                          color: (widget.selected.contains(widget.question
                                              .data!
                                              .questions![
                                          Provider.of<QuestionNumProvider>(
                                              context,
                                              listen: false)
                                              .questionNum -
                                              1]
                                              .choices![j - 1]
                                              .choiceText))
                                              ? const Color.fromRGBO(255, 255, 255, 1)
                                              : const Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: widget.height * 0.02,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ])),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
      ],
    );
  }
}


