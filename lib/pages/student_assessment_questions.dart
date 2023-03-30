import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Entity/question_paper_model.dart';
import '../Providers/question_num_provider.dart';
import 'student_revise_quest.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class StudQuestion extends StatefulWidget {
  const StudQuestion(
      {Key? key,
      required this.assessmentId,
      required this.ques,
      required this.userName,
      required this.setLocale})
      : super(key: key);
  final String assessmentId;
  final QuestionPaperModel ques;
  final String userName;
  final void Function(Locale locale) setLocale;

  @override
  StudQuestionState createState() => StudQuestionState();
}

class StudQuestionState extends State<StudQuestion> {
  late QuestionPaperModel values;
  Timer? countdownTimer;
  Duration myDuration = const Duration();
  List<dynamic> selected = [];
  TextEditingController ansController = TextEditingController();
  Color notSureColor1 = const Color.fromRGBO(255, 255, 255, 1);
  Color notSureColor2 = const Color.fromRGBO(255, 153, 0, 1);
  IconData notSureIcon = Icons.mode_comment_outlined;
  final DateFormat formatter = DateFormat('HH:mm');
  final DateTime now = DateTime.now();

  dynamic select;
  late Map tempQuesAns = {};
  List<int> tilecount = [1];
  Color colorCode = const Color.fromRGBO(179, 179, 179, 1);
  setTimr(){
    myDuration = Duration(minutes: widget.ques.data!.assessmentDuration!);
  }

  @override
  void initState() {
    setTimr();
    Future.delayed(const Duration(seconds: 0)).then((_) {
      if (MediaQuery.of(context).copyWith().size.width > 700) {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
            context: context,
            builder: (builder) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: MediaQuery.of(context).copyWith().size.height * 0.2025,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.026,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).copyWith().size.width *
                              0.055),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            size: MediaQuery.of(context).copyWith().size.width *
                                0.025,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                const Icon(
                                  Icons.mode_comment_outlined,
                                  color: Color.fromRGBO(255, 153, 0, 1),
                                ),
                                Positioned(
                                    left: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        0.006,
                                    top: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.005,
                                    child: Icon(
                                      Icons.question_mark,
                                      color:
                                          const Color.fromRGBO(255, 153, 0, 1),
                                      size: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          0.02,
                                    ))
                              ],
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.02,
                            ),
                            Text(
                              AppLocalizations.of(context)!.not_sure_flag,
                              // "Not Sure Flag: Press Flag to re-check later",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge
                                  ?.merge(TextStyle(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          0.026)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.skip_next_outlined,
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              size: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0.046,
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.02,
                            ),
                            Text(
                              AppLocalizations.of(context)!.skip_to_end,
                              //"Skip to End of question paper",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge
                                  ?.merge(TextStyle(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          0.026)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: Color.fromRGBO(224, 224, 224, 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.square,
                          color: const Color.fromRGBO(188, 191, 8, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.03,
                        ),
                        Text(
                          AppLocalizations.of(context)!.test_qn_page,
                          // "  Test",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.026)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.1,
                        ),
                        //Image.asset("assets/images/testIcon.png"),
                        // SvgPicture.asset('assets/icons/test.svg'),
                        Icon(
                          Icons.square,
                          color: const Color.fromRGBO(255, 157, 77, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.03,
                        ),
                        Text(
                          AppLocalizations.of(context)!.practice_qn_page,
                          //"  Practice",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.026)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });
      } else {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
            ),
            context: context,
            builder: (builder) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: MediaQuery.of(context).copyWith().size.height * 0.3025,
                child: Padding(
                  padding: EdgeInsets.only(
                      left:
                          MediaQuery.of(context).copyWith().size.width * 0.10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.026,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right:
                                MediaQuery.of(context).copyWith().size.width *
                                    0.055),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              size:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.055,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Stack(
                          children: [
                            const Icon(
                              Icons.mode_comment_outlined,
                              color: Color.fromRGBO(255, 153, 0, 1),
                            ),
                            Positioned(
                                left: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
                                    0.008,
                                top: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                    0.005,
                                child: Icon(
                                  Icons.question_mark,
                                  color: const Color.fromRGBO(255, 153, 0, 1),
                                  size: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.014,
                                ))
                          ],
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.not_sure_press,
                          //"Not Sure Flag:\nPress Flag to re-check later",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.016)),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.skip_next_outlined,
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          size: MediaQuery.of(context).copyWith().size.height *
                              0.036,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.skip_to_end,
                          //"Skip to End of question paper",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.016)),
                        ),
                      ),
                      const Divider(color: Color.fromRGBO(224, 224, 224, 1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.square,
                            color: const Color.fromRGBO(188, 191, 8, 1),
                            size:
                                MediaQuery.of(context).copyWith().size.height *
                                    0.02,
                          ),
                          Text(
                            AppLocalizations.of(context)!.test_qn_page,
                            // "  Test",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge
                                ?.merge(TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.016)),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    0.052,
                          ),
                          //Image.asset("assets/images/testIcon.png"),
                          // SvgPicture.asset('assets/icons/test.svg'),
                          Icon(
                            Icons.square,
                            color: const Color.fromRGBO(255, 157, 77, 1),
                            size:
                                MediaQuery.of(context).copyWith().size.height *
                                    0.02,
                          ),
                          Text(
                            AppLocalizations.of(context)!.practice_qn_page,
                            //"  Practice",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge
                                ?.merge(TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.016)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
    values = widget.ques;
    context.read<Questions>().createQuesAns(values.data!.questions!.length);
    context.read<QuestionNumProvider>().reset();

    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    super.initState();
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    int i;
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
    ansController.selection =
        TextSelection.collapsed(offset: ansController.text.length);
    // });
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 700) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Text(
                      widget.assessmentId,
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.025,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    flexibleSpace: Banner(
                      color: values.data!.assessmentType == 'test'
                          ? const Color.fromRGBO(188, 191, 8, 1)
                          : const Color.fromRGBO(255, 157, 77, 1),
                      message: values.data!.assessmentType!,
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                      location: BannerLocation.topEnd,
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [
                              Color.fromRGBO(82, 165, 160, 1),
                              Color.fromRGBO(0, 106, 100, 1),
                            ])),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.023,
                        left: width * 0.23,
                        right: width * 0.23),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.qn_qn_page}${context.watch<QuestionNumProvider>().questionNum}/${values.data!.questions!.length}",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge
                                    ?.merge(TextStyle(
                                        color: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.03)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: height * 0.025),
                                child: Text("$hours:$minutes:$seconds",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.025)),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (i = 0; i < tilecount.length; i++)
                                  Icon(Icons.remove,
                                      color: Provider.of<Questions>(context,
                                              listen: false)
                                          .totalQuestion['${i + 1}'][1])
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.6675,
                            width: width * 0.855,
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
                                        width: width * 0.1277,
                                        child: Center(
                                          child: Text(
                                            "${context.watch<QuestionNumProvider>().questionNum}",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge
                                                ?.merge(TextStyle(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: height * 0.035)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          color: Color.fromRGBO(28, 78, 80, 1),
                                        ),
                                        height: height * 0.0625,
                                        width: width * 0.1277,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${values.data!.questions![context.watch<QuestionNumProvider>().questionNum - 1].questionMarks}",
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
                                                          height * 0.0337)),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .marks_qn,
                                              //" Marks",
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
                                      width: width * 0.744,
                                      child: Scrollbar(
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
                                                    height: height * 0.0020,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.026)),
                                          ),
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
                                              "Descripitive"
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
                                                            .practice_qn_page,
                                                    //"Enter your text here",
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black54)),
                                                  ),
                                                  maxLines: (height * 0.013)
                                                      .round(), //or null
                                                ),
                                              ))
                                          : ChooseWidget(
                                              question: values,
                                              selected: selected,
                                              height: height,
                                              width: width),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: width * 0.05),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (Provider.of<Questions>(
                                                                  context,
                                                                  listen: false)
                                                              .totalQuestion[
                                                          '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                                      [2] ==
                                                  false) {
                                                context
                                                    .read<Questions>()
                                                    .selectOption(
                                                        Provider.of<QuestionNumProvider>(
                                                                context,
                                                                listen: false)
                                                            .questionNum,
                                                        selected,
                                                        const Color.fromRGBO(
                                                            239, 218, 30, 1),
                                                        true);
                                              } else if (Provider.of<Questions>(
                                                                  context,
                                                                  listen: false)
                                                              .totalQuestion[
                                                          '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                                      [0] !=
                                                  []) {
                                                context
                                                    .read<Questions>()
                                                    .selectOption(
                                                        Provider.of<QuestionNumProvider>(
                                                                context,
                                                                listen: false)
                                                            .questionNum,
                                                        selected,
                                                        const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        false);
                                              } else {
                                                context
                                                    .read<Questions>()
                                                    .selectOption(
                                                        Provider.of<QuestionNumProvider>(
                                                                context,
                                                                listen: false)
                                                            .questionNum,
                                                        selected,
                                                        const Color.fromRGBO(
                                                            219, 35, 35, 1),
                                                        false);
                                              }
                                            },
                                            child: Provider.of<Questions>(
                                                            context,
                                                            listen: false)
                                                        .totalQuestion[
                                                    '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}'][2]
                                                ? NotSureEnabled(
                                                    height: height,
                                                    width: width,
                                                  )
                                                : NotSureDisabled(
                                                    height: height,
                                                    width: width,
                                                  ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .not_sure,
                                            //"Not Sure",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge
                                                ?.merge(TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    height: height * 0.0020,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: height * 0.013)),
                                          ),
                                        ],
                                      ),
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                context
                                            .watch<QuestionNumProvider>()
                                            .questionNum <=
                                        1
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.arrow_left,
                                          color: const Color.fromRGBO(
                                              209, 209, 209, 1),
                                          size: height * 0.06,
                                        ),
                                        onPressed: () {},
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.arrow_left,
                                          color: context
                                                      .watch<
                                                          QuestionNumProvider>()
                                                      .questionNum ==
                                                  1
                                              ? const Color.fromRGBO(
                                                  209, 209, 209, 1)
                                              : const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                          size: height * 0.06,
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
                                        : GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<QuestionNumProvider>()
                                                  .skipToEnd(tilecount.length);
                                            },
                                            child: Container(
                                              height: height * 0.0475,
                                              width: width * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.skip_next_outlined,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    size: height * 0.05,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .skip_end,
                                                    // "Skip to end",
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
                                                                0.015)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                    : const SizedBox(),
                                context
                                            .watch<QuestionNumProvider>()
                                            .questionNum >=
                                        values.data!.questions!.length
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.arrow_right,
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          size: height * 0.06,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: StudentReviseQuest(
                                                questions: values,
                                                setLocale: widget.setLocale,
                                                userName: widget.userName,
                                                startTime:
                                                    now.microsecondsSinceEpoch,
                                                assessmentID:
                                                    widget.assessmentId,
                                                assessmentid:
                                                    values.data!.assessmentId!,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          context
                                              .read<QuestionNumProvider>()
                                              .increment();
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
                                          } else if (selected.isNotEmpty) {
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
                                          } else {
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
                                          } else {
                                            tilecount.add(Provider.of<
                                                        QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                .questionNum);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_right,
                                          color: context
                                                      .watch<
                                                          QuestionNumProvider>()
                                                      .questionNum ==
                                                  values.data!.questions!.length
                                              ? const Color.fromRGBO(
                                                  209, 209, 209, 1)
                                              : const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                          size: height * 0.06,
                                        )),
                              ],
                            ),
                          )
                        ]),
                  )));
        }
        else {
          return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Text(
                      widget.assessmentId,
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.025,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    flexibleSpace: Banner(
                      color: values.data!.assessmentType == 'test'
                          ? const Color.fromRGBO(188, 191, 8, 1)
                          : const Color.fromRGBO(255, 157, 77, 1),
                      message: values.data!.assessmentType!,
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                      location: BannerLocation.topEnd,
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft,
                                colors: [
                              Color.fromRGBO(82, 165, 160, 1),
                              Color.fromRGBO(0, 106, 100, 1),
                            ])),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.023,
                        left: height * 0.023,
                        right: height * 0.023),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.qn_qn_page} ${context.watch<QuestionNumProvider>().questionNum}/${values.data!.questions!.length}",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge
                                    ?.merge(TextStyle(
                                        color: const Color.fromRGBO(
                                            82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.02)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: height * 0.025),
                                child: Text("$hours:$minutes:$seconds",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.015)),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (i = 0; i < tilecount.length; i++)
                                  Icon(Icons.remove,
                                      color: Provider.of<Questions>(context,
                                              listen: false)
                                          .totalQuestion['${i + 1}'][1])
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.6675,
                            width: width * 0.855,
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
                                        width: width * 0.2277,
                                        child: Center(
                                          child: Text(
                                            "${context.watch<QuestionNumProvider>().questionNum}",
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
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          color: Color.fromRGBO(28, 78, 80, 1),
                                        ),
                                        height: height * 0.0625,
                                        width: width * 0.2277,
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
                                      width: width * 0.744,
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
                                                  height: height * 0.0020,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.016)),
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
                                              "Descripitive"
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
                                                  maxLines: (height * 0.013)
                                                      .round(), //or null
                                                ),
                                              ))
                                          : ChooseWidget(
                                              question: values,
                                              selected: selected,
                                              height: height,
                                              width: width),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: width * 0.05),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (Provider.of<Questions>(
                                                                  context,
                                                                  listen: false)
                                                              .totalQuestion[
                                                          '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                                      [2] ==
                                                  false) {
                                                context
                                                    .read<Questions>()
                                                    .selectOption(
                                                        Provider.of<QuestionNumProvider>(
                                                                context,
                                                                listen: false)
                                                            .questionNum,
                                                        selected,
                                                        const Color.fromRGBO(
                                                            239, 218, 30, 1),
                                                        true);
                                              } else if (Provider.of<Questions>(
                                                                  context,
                                                                  listen: false)
                                                              .totalQuestion[
                                                          '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}']
                                                      [0] !=
                                                  []) {
                                                context
                                                    .read<Questions>()
                                                    .selectOption(
                                                        Provider.of<QuestionNumProvider>(
                                                                context,
                                                                listen: false)
                                                            .questionNum,
                                                        selected,
                                                        const Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                        false);
                                              } else {
                                                context
                                                    .read<Questions>()
                                                    .selectOption(
                                                        Provider.of<QuestionNumProvider>(
                                                                context,
                                                                listen: false)
                                                            .questionNum,
                                                        selected,
                                                        const Color.fromRGBO(
                                                            219, 35, 35, 1),
                                                        false);
                                              }
                                            },
                                            child: Provider.of<Questions>(
                                                            context,
                                                            listen: false)
                                                        .totalQuestion[
                                                    '${Provider.of<QuestionNumProvider>(context, listen: false).questionNum}'][2]
                                                ? NotSureEnabled(
                                                    height: height,
                                                    width: width,
                                                  )
                                                : NotSureDisabled(
                                                    height: height,
                                                    width: width,
                                                  ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .not_sure,
                                            //   "Not Sure",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyLarge
                                                ?.merge(TextStyle(
                                                    color: const Color.fromRGBO(
                                                        102, 102, 102, 1),
                                                    fontFamily: 'Inter',
                                                    height: height * 0.0020,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: height * 0.013)),
                                          ),
                                        ],
                                      ),
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                context
                                            .watch<QuestionNumProvider>()
                                            .questionNum <=
                                        1
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.arrow_circle_left,
                                          color: const Color.fromRGBO(
                                              209, 209, 209, 1),
                                          size: height * 0.06,
                                        ),
                                        onPressed: () {},
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.arrow_circle_left,
                                          color: context
                                                      .watch<
                                                          QuestionNumProvider>()
                                                      .questionNum ==
                                                  1
                                              ? const Color.fromRGBO(
                                                  209, 209, 209, 1)
                                              : const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                          size: height * 0.06,
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
                                        : GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<QuestionNumProvider>()
                                                  .skipToEnd(tilecount.length);
                                            },
                                            child: Container(
                                              height: height * 0.0475,
                                              width: width * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.skip_next_outlined,
                                                    color: const Color.fromRGBO(
                                                        82, 165, 160, 1),
                                                    size: height * 0.05,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .skip_end,
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
                                                                0.015)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                    : const SizedBox(),
                                context
                                            .watch<QuestionNumProvider>()
                                            .questionNum >=
                                        values.data!.questions!.length
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.arrow_circle_right,
                                          color: const Color.fromRGBO(
                                              82, 165, 160, 1),
                                          size: height * 0.06,
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
                                          } else if (selected.isNotEmpty) {
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
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: StudentReviseQuest(
                                                  questions: values,
                                                  assessmentid: values
                                                      .data!.assessmentId!,
                                                  userName: widget.userName,
                                                  startTime: now
                                                      .microsecondsSinceEpoch,
                                                  setLocale: widget.setLocale,
                                                  assessmentID:
                                                      widget.assessmentId),
                                            ),
                                          );
                                        },
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          context
                                              .read<QuestionNumProvider>()
                                              .increment();
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
                                          } else if (selected.isNotEmpty) {
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
                                          } else {
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
                                          } else {
                                            tilecount.add(Provider.of<
                                                        QuestionNumProvider>(
                                                    context,
                                                    listen: false)
                                                .questionNum);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_circle_right,
                                          color: context
                                                      .watch<
                                                          QuestionNumProvider>()
                                                      .questionNum ==
                                                  values.data!.questions!.length
                                              ? const Color.fromRGBO(
                                                  209, 209, 209, 1)
                                              : const Color.fromRGBO(
                                                  82, 165, 160, 1),
                                          size: height * 0.06,
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

class ChooseWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int j = 1;
            j <=
                question
                    .data!
                    .questions![
                        context.watch<QuestionNumProvider>().questionNum - 1]
                    .choices!
                    .length;
            j++)
          GestureDetector(
            onTap: () {
              if (selected.contains(question
                  .data!
                  .questions![
                      Provider.of<QuestionNumProvider>(context, listen: false)
                              .questionNum -
                          1]
                  .choices![j - 1]
                  .choiceText)) {
                selected.remove(question
                    .data!
                    .questions![
                        Provider.of<QuestionNumProvider>(context, listen: false)
                                .questionNum -
                            1]
                    .choices![j - 1]
                    .choiceText);
                if (selected.isEmpty) {
                  context.read<Questions>().selectOption(
                      Provider.of<QuestionNumProvider>(context, listen: false)
                          .questionNum,
                      selected,
                      const Color.fromRGBO(219, 35, 35, 1),
                      false);
                } else {
                  context.read<Questions>().selectOption(
                      Provider.of<QuestionNumProvider>(context, listen: false)
                          .questionNum,
                      selected,
                      const Color.fromRGBO(82, 165, 160, 1),
                      false);
                }
              } else {
                selected.add(question
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
                    selected,
                    const Color.fromRGBO(82, 165, 160, 1),
                    false);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: height * 0.013,
                  left: width * 0.05,
                  right: width * 0.05),
              child: Container(
                  width: width * 0.744,
                  height: height * 0.0512,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: const Color.fromRGBO(209, 209, 209, 1)),
                    color: (selected.contains(question
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
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              question
                                  .data!
                                  .questions![context
                                          .watch<QuestionNumProvider>()
                                          .questionNum -
                                      1]
                                  .choices![j - 1]
                                  .choiceText!,
                              style: TextStyle(
                                color: (selected.contains(question
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
                                fontSize: width >= 700
                                    ? height * 0.0262
                                    : height * 0.0162,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ])),
            ),
          )
      ],
    );
  }
}

class NotSureDisabled extends StatelessWidget {
  const NotSureDisabled({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(Icons.mode_comment_outlined,
            color: const Color.fromRGBO(255, 153, 0, 1), size: height * 0.04),
        Positioned(
            left: width >= 700 ? width * 0.005 : width * 0.015,
            top: width >= 700 ? height * 0.002 : height * 0.005,
            child: Icon(
              Icons.question_mark,
              color: const Color.fromRGBO(255, 153, 0, 1),
              size: width >= 700 ? height * 0.02 : height * 0.016,
            ))
      ],
    );
  }
}

class NotSureEnabled extends StatelessWidget {
  const NotSureEnabled({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.mode_comment_sharp,
            color: const Color.fromRGBO(255, 153, 0, 1), size: height * 0.04),
        Positioned(
            left: width >= 700 ? width * 0.005 : width * 0.017,
            top: width >= 700 ? height * 0.002 : height * 0.006,
            child: Icon(
              Icons.question_mark,
              color: const Color.fromRGBO(255, 255, 255, 1),
              size: width >= 700 ? height * 0.02 : height * 0.016,
            ))
      ],
    );
  }
}
