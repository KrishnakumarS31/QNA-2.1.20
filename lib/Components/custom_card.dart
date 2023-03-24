import 'package:flutter/material.dart';
import '../EntityModel/get_result_model.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    Key? key,
    required this.height,
    required this.width,
    this.subject,
    this.title,
    required this.result,
    this.d1,
    this.subTopic,
    this.std,
    this.date,
    this.status,
    this.index,
  }) : super(key: key);

  final double height;
  final double width;
  final GetResultModel result;
  final String? subject;
  final String? title;
  final String? subTopic;
  final String? std;
  final int? date;
  final Color? status;
  final String? d1;
  final int? index;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  void initState() {
    super.initState();
    print("dfhtrh");
  }

  @override
  Widget build(BuildContext context) {
    var d = DateTime.fromMicrosecondsSinceEpoch(
        widget.result!.assessmentStartDate!);
    print("fdvdfbb ");
    var startDate = "${d.day}/${d.month}/${d.year}";
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
              'Subject - ${widget.result.assessmentCode}',
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
                  color: widget.status,
                  size: widget.width * 0.05,
                ),
                Text(
                  startDate,
                  style: TextStyle(
                      color: const Color.fromRGBO(102, 102, 102, 0.7),
                      fontSize: widget.height * 0.0125,
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
                'Title - ${widget.title}',
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
                'Subtopic ${widget.subTopic}',
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
                'Class ${widget.std}',
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
