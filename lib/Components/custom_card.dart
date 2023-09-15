import 'package:flutter/material.dart';
import 'package:qna_test/Components/today_date.dart';
import '../EntityModel/get_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class CustomCard extends StatefulWidget {
  CustomCard({
    Key? key,
    required this.height,
    required this.width,
    required this.result,
    this.isShowTotal = false,
  }) : super(key: key);
  bool isShowTotal;
  final double height;
  final double width;
  final GetResultModel result;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var start = DateTime.fromMicrosecondsSinceEpoch(
        widget.result.assessmentStartDate!);
    var end = DateTime.fromMicrosecondsSinceEpoch(
        widget.result.assessmentEndDate!);
    List<String> status = [];
    List<String> s =[];
    DateTime now = DateTime.now();

    bool completed = now.isAfter(end);
    bool notStarted = now.isBefore(start);
    bool live = now.isBefore(end);
    Widget completedIcon = Icon(
      Icons.circle,
      color: const Color.fromRGBO(42, 36, 186, 1),
      size: widget.height * 0.03,
    );
    Widget notStartedIcon = Icon(
      Icons.circle,
      color: const Color.fromRGBO(153, 153, 153, 1),
      size: widget.height * 0.03,
    );
    Widget liveIcon = Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius:
        const BorderRadius.all(
            Radius.circular(5)),
        border: Border.all(
            color: const Color.fromRGBO(
                219, 35, 35, 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.circle,
            color: const Color.fromRGBO(219, 35, 35, 1),
            size: MediaQuery
                .of(context)
                .copyWith()
                .size
                .height *
                0.02,
          ),
          Text(
            //AppLocalizations.of(context)!.active,
            "  LIVE ",
            style: Theme
                .of(context)
                .primaryTextTheme
                .bodyLarge
                ?.merge(TextStyle(
                color: const Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery
                    .of(context)
                    .copyWith()
                    .size
                    .height *
                    0.016)),
          ),
        ],
      ),
    );




    return Container(
      // height: widget.height * 0.11,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(82, 165, 160, 0.07),
          border: Border.all(
            color: const Color.fromRGBO(82, 165, 160, 0.2),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: widget.width * 0.03, bottom: widget.height * 0.005),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.result.subject} | ${widget.result.topic}",
//'Subject - ${widget.result.subject}',
                        style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: widget.height * 0.0187,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600),
                      ),


                      notStarted ? notStartedIcon : live ? liveIcon : completed ? completedIcon : notStartedIcon
                    ]),
              )),
          Padding(
            padding: EdgeInsets.only(
                left: widget.width * 0.03, bottom: widget.height * 0.005),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.result.degree} | ${widget.result.subject}',
                //'Semester ${widget.result.subTopic}',
                style: TextStyle(
                    color: const Color.fromRGBO(102, 102, 102, 1),
                    fontSize: widget.height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: widget.width * 0.03),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.result.assessmentCode.toString(), //'Class ${widget.result.studentClass}',
                        style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: widget.height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    convertDate(widget.result.assessmentStartDate),
                    style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: widget.height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          widget.isShowTotal?
          Container(
            padding: EdgeInsets.only(left: widget.width * 0.03),
            child: Column(children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.total_marks} ${widget.result.totalScore}", //'Class ${widget.result.studentClass}',
                    style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: widget.height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.total_ques} ${widget.result.totalQuestions}", //'Class ${widget.result.studentClass}',
                    style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: widget.height * 0.0175,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                  ),
                ],)
            ]),):Container()
        ],
      ),
    );
  }
}
