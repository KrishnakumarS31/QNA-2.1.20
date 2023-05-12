import 'package:flutter/material.dart';
import '../EntityModel/get_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class CustomCard extends StatefulWidget {
  const CustomCard({
    Key? key,
    required this.height,
    required this.width,
    required this.result,
  }) : super(key: key);

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
    var d = DateTime.fromMicrosecondsSinceEpoch(
        widget.result.assessmentStartDate!);
    var startDate = "${d.day}/${d.month}/${d.year}";
    var end = DateTime.fromMicrosecondsSinceEpoch(
        widget.result.assessmentEndDate!);
    DateTime now = DateTime.now();
    return Container(
      height: widget.height * 0.1825,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(28, 78, 80, 0.08),
          border: Border.all(
            color: const Color.fromRGBO(233, 233, 233, 1),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)!.sub_small} - ${widget.result.subject}",
//'Subject - ${widget.result.subject}',
              style: TextStyle(
                  color: const Color.fromRGBO(28, 78, 80, 1),
                  fontSize: widget.height * 0.0187,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.circle,
                  color:
                  end.isBefore(now)
                      ? const Color.fromRGBO(66, 194, 0, 1)
                      : d.isAfter(now)
                      ? const Color.fromRGBO(179, 179, 179, 1)
                      : const Color.fromRGBO(255, 157, 77, 1),
                  size: widget.height * 0.03,
                ),
                Text(
                  startDate,
                  style: TextStyle(
                      color: const Color.fromRGBO(102, 102, 102, 0.7),
                      fontSize: widget.height * 0.02,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: widget.width * 0.02, left: widget.width * 0.02),
            child: const Divider(),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widget.width * 0.03, bottom: widget.height * 0.005),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${AppLocalizations.of(context)!.title} - ${widget.result.topic}",
                //'Title - ${widget.result.subject}',
                style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: widget.height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widget.width * 0.03, bottom: widget.height * 0.005),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${AppLocalizations.of(context)!.sub_topic_optional} ${widget.result.subTopic}',
                //'Semester ${widget.result.subTopic}',
                style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
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
              child: Text(
                 "${AppLocalizations.of(context)!.degree_small} - ${widget.result.studentClass}",
                                        //'Class ${widget.result.studentClass}',
                style: TextStyle(
                    color: const Color.fromRGBO(102, 102, 102, 1),
                    fontSize: widget.height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
