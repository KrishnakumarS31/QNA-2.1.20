import 'package:flutter/material.dart';

import '../EntityModel/get_result_model.dart';

class CustomCard1 extends StatelessWidget {
  const CustomCard1({
    Key? key,
    required this.height,
    required this.width,
    required this.resultIndex,
  }) : super(key: key);

  final double height;
  final double width;
  final GetResultModel resultIndex;

  @override
  Widget build(BuildContext context) {
    // DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(date);
    // String datetime = "${tsdate.day}/${tsdate.month}/${tsdate.year}";
    // String time = "${tsdate.hour}:${tsdate.minute}";

    return Container(
      height: height * 0.1825,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(233, 233, 233, 1),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subject - ${resultIndex.subject}',
                  style: TextStyle(
                      color: const Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.0187,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '${resultIndex.assessmentCode}',
                  style: TextStyle(
                      color: const Color.fromRGBO(102, 102, 102, 1),
                      fontSize: height * 0.015,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.circle,
                  color:const Color.fromRGBO(255, 157, 77, 1),
                  size: width * 0.05,
                ),
                // Text(
                //   datetime,
                //   style: TextStyle(
                //       color: const Color.fromRGBO(102, 102, 102, 0.7),
                //       fontSize: height * 0.0125,
                //       fontFamily: "Inter",
                //       fontWeight: FontWeight.w400),
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.02, left: width * 0.02),
            child: const Divider(),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: width * 0.03, bottom: height * 0.005),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Title - ${resultIndex.topic}',
                style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: width * 0.03, bottom: height * 0.005),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sub Topic ${resultIndex.subTopic}',
                style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.0175,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Class ${resultIndex.studentClass}',
                style: TextStyle(
                    color: const Color.fromRGBO(102, 102, 102, 1),
                    fontSize: height * 0.0175,
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
