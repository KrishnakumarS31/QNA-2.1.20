import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void _copyToClipboard(
    context,
    String text,
  ) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromRGBO(28, 78, 80, 1),
        // width: 250,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.78,
          left: MediaQuery.of(context).size.width * 0.10,
          right: MediaQuery.of(context).size.width * 0.10,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Text(
          'Assessment ID copied to clipboard',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var start =
        DateTime.fromMicrosecondsSinceEpoch(widget.result.assessmentStartDate!);
    var end =
        DateTime.fromMicrosecondsSinceEpoch(widget.result.assessmentEndDate!);
    List<String> status = [];
    List<String> s = [];
    DateTime now = DateTime.now();

    bool completed = now.isAfter(end);
    bool notStarted = now.isBefore(start);
    bool live = now.isBefore(end);
    Widget completedIcon = Container(
      width: 67,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: const Color.fromRGBO(42, 36, 186, 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            //AppLocalizations.of(context)!.active,
            "  OVER ",
            style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
                TextStyle(
                    color: const Color.fromRGBO(42, 36, 186, 1),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize:
                        MediaQuery.of(context).copyWith().size.height * 0.016)),
          ),
        ],
      ),
    );
    Widget notStartedIcon = Container(
      width: 67,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color:const Color.fromARGB(255, 52, 52, 52),),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: Text(
              //AppLocalizations.of(context)!.active,
              "YET TO\nSTART",
              style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
                  TextStyle(
                      color:const Color.fromARGB(255, 52, 52, 52),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize:
                          MediaQuery.of(context).copyWith().size.height * 0.01)),
            ),
          ),
        ],
      ),
    );

    Widget liveIcon = Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: const Color.fromRGBO(219, 35, 35, 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.circle,
            color: const Color.fromRGBO(219, 35, 35, 1),
            size: MediaQuery.of(context).copyWith().size.height * 0.02,
          ),
          Text(
            //AppLocalizations.of(context)!.active,
            "  LIVE ",
            style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
                TextStyle(
                    color: const Color.fromRGBO(51, 51, 51, 1),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize:
                        MediaQuery.of(context).copyWith().size.height * 0.016)),
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
                      notStarted
                          ? notStartedIcon
                          : live
                              ? liveIcon
                              : completed
                                  ? completedIcon
                                  : notStartedIcon
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
                      // Text(
                      //   widget.result.assessmentCode.toString(), //'Class ${widget.result.studentClass}',
                      //   style: TextStyle(
                      //       color: const Color.fromRGBO(82, 165, 160, 1),
                      //       fontSize: widget.height * 0.0175,
                      //       fontFamily: "Inter",
                      //       fontWeight: FontWeight.w500),
                      // ),
                      widget.isShowTotal
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    width: 1, // the thickness
                                    color: Color.fromRGBO(82, 165, 160,
                                        1) // the color of the border
                                    ),
                                minimumSize: const Size(114, 23),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              child: Text(widget.result.assessmentCode!,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: widget.height * 0.023,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(
                                          82, 165, 160, 1))),
                              onPressed: () async {
                                _copyToClipboard(
                                    context, widget.result.assessmentCode!);
                                // Navigator.pushNamed(context,
                                //     '/studentMemberLoginPage');
                              },
                            )
                          : Text(
                              widget.result.assessmentCode
                                  .toString(), //'Class ${widget.result.studentClass}',
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
          widget.isShowTotal
              ? Container(
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
                      ],
                    )
                  ]),
                )
              : Container()
        ],
      ),
    );
  }
}
