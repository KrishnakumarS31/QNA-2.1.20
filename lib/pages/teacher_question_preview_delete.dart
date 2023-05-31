import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/Providers/question_prepare_provider_final.dart';
import '../Entity/Teacher/choice_entity.dart';
import '../Entity/Teacher/question_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TeacherQuestionPreviewDelete extends StatefulWidget {
  const TeacherQuestionPreviewDelete(
      {super.key,
        this.assessment,
        required this.question,
        required this.index,
      });

  final Question question;
  final int index;
  final bool? assessment;


  @override
  TeacherQuestionPreviewDeleteState createState() =>
      TeacherQuestionPreviewDeleteState();
}

class TeacherQuestionPreviewDeleteState
    extends State<TeacherQuestionPreviewDelete> {
  TextEditingController adviceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  IconData showIcon = Icons.expand_circle_down_outlined;

  List<Choice> selected = [];

  @override
  void initState() {
    super.initState();
    adviceController.text = widget.question.advisorText!;
    urlController.text = widget.question.advisorUrl!;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints)
    {
      if (constraints.maxWidth > 500) {
        return Center(
            child: SizedBox(
            width: 400,
            child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                body: Center(
                  child: SizedBox(
                    height: height * 0.85,
                    width: width * 0.888,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 12,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        margin: EdgeInsets.only(
                            left: width * 0.030,
                            right: width * 0.030,
                            bottom: height * 0.015,
                            top: height * 0.025),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, top: height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${widget.question.questionType}',
                                        style: TextStyle(
                                            color:
                                            const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.02)),
                                  ),
                                  IconButton(onPressed: () {
                                    Navigator.of(context).pop();
                                  }, icon: const Icon(Icons.close))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, top: height * 0.02),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${widget.question.question}',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            51, 51, 51, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.015)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            widget.question.questionType == 'Descriptive'
                                ? const SizedBox(height: 0,)
                                :
                            SizedBox(
                              height: height * 0.25,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: ChooseWidget(
                                    question: widget.question,
                                    selected: selected,
                                    height: height,
                                    width: width),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    AppLocalizations.of(context)!.advisor,
                                    //"Advisor",
                                    style: TextStyle(
                                        color:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.02)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, right: width * 0.03),
                              child: TextFormField(
                                controller: adviceController,
                                enabled: false,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText:
                                    AppLocalizations.of(context)!.suggest_study,
                                    //'Suggest what to study if answered incorrectly ',
                                    labelStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.25),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.015)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, right: width * 0.03),
                              child: TextFormField(
                                controller: urlController,
                                enabled: false,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText:
                                    AppLocalizations.of(context)!.url_reference,
                                    //'URL - Any reference (Optional)',
                                    labelStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.25),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.015)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    '/preparePreviewQnBank',
                                    arguments: [widget.question,]
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.edit_button,
                                //'Edit',
                                style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              onPressed: () {
                                Provider.of<QuestionPrepareProviderFinal>(
                                    context,
                                    listen: false)
                                    .deleteQuestionList(widget.index);
                                Navigator.pushNamed(
                                  context,
                                  '/teacherMyQuestionBank',
                                  arguments: widget.assessment,
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.delete,
                                // 'Delete',
                                style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )),
                  ),
                )))));
      }
      else {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                body: Center(
                  child: SizedBox(
                    height: height * 0.85,
                    width: width * 0.888,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 12,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        margin: EdgeInsets.only(
                            left: width * 0.030,
                            right: width * 0.030,
                            bottom: height * 0.015,
                            top: height * 0.025),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, top: height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${widget.question.questionType}',
                                        style: TextStyle(
                                            color:
                                            const Color.fromRGBO(
                                                82, 165, 160, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.02)),
                                  ),
                                  IconButton(onPressed: () {
                                    Navigator.of(context).pop();
                                  }, icon: const Icon(Icons.close))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, top: height * 0.02),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${widget.question.question}',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            51, 51, 51, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.015)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            widget.question.questionType == 'Descriptive'
                                ? const SizedBox(height: 0,)
                                :
                            SizedBox(
                              height: height * 0.25,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: ChooseWidget(
                                    question: widget.question,
                                    selected: selected,
                                    height: height,
                                    width: width),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    AppLocalizations.of(context)!.advisor,
                                    //"Advisor",
                                    style: TextStyle(
                                        color:
                                        const Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.02)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, right: width * 0.03),
                              child: TextFormField(
                                controller: adviceController,
                                enabled: false,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText:
                                    AppLocalizations.of(context)!.suggest_study,
                                    //'Suggest what to study if answered incorrectly ',
                                    labelStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.25),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.015)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, right: width * 0.03),
                              child: TextFormField(
                                controller: urlController,
                                enabled: false,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText:
                                    AppLocalizations.of(context)!.url_reference,
                                    //'URL - Any reference (Optional)',
                                    labelStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.25),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.015)),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context,
                                    '/preparePreviewQnBank',
                                    arguments: [widget.question,]
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.edit_button,
                                //'Edit',
                                style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(
                                        82, 165, 160, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(82, 165, 160, 1),
                                minimumSize: const Size(280, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              onPressed: () {
                                Provider.of<QuestionPrepareProviderFinal>(
                                    context,
                                    listen: false)
                                    .deleteQuestionList(widget.index);
                                Navigator.pushNamed(
                                  context,
                                  '/teacherMyQuestionBank',
                                  arguments: widget.assessment,
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.delete,
                                // 'Delete',
                                style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontFamily: "Inter",
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )),
                  ),
                )));
      }
    }
    );}

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
}

class ChooseWidget extends StatefulWidget {
  const ChooseWidget({
    Key? key,
    required this.question,
    required this.height,
    required this.width,
    required this.selected,
  }) : super(key: key);

  final Question question;
  final List<Choice> selected;
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
        for (int j = 0; j < widget.question.choices!.length; j++)
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.height * 0.013),
                  child: Container(
                      width: widget.width * 0.744,
                      height: widget.height * 0.0412,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: const Color.fromRGBO(209, 209, 209, 1)),
                        color: (widget.question.choices![j].rightChoice!)
                            ? const Color.fromRGBO(82, 165, 160, 1)
                            : const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: widget.width * 0.02,
                            ),
                            Text(
                              '${widget.question.choices![j].choiceText}',
                              style: TextStyle(
                                color: (widget.question.choices![j].rightChoice!)
                                    ? const Color.fromRGBO(255, 255, 255, 1)
                                    : const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: widget.height * 0.0162,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ])),
                ),
              ))
      ],
    );
  }
}
