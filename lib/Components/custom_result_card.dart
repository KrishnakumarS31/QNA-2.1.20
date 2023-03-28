import 'package:flutter/material.dart';

class Result_card extends StatelessWidget {
   Result_card({
    Key? key,
    required this.height,
    required this.width,
    required this.name,
    required this.testCode,
    required this.percent,
    required this.securedMark,
    required this.totalMark,
    this.startedTime,
    this.timeTaken,
  }) : super(key: key);

  final double height;
  final double width;

  final String name;
  final String testCode;
  final int percent;
  final int securedMark;
  final int totalMark;
  final int? timeTaken;
  final int? startedTime;


  @override
  Widget build(BuildContext context) {

    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(startedTime!);
    String datetime = "${tsdate.day}/${tsdate.month}/${tsdate.year}";
    String time = "${tsdate.hour}:${tsdate.minute}";
    print(datetime);
    print(timeTaken);
    print ("${time} IST");
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.015),
      child: Container(
          height: height * 0.1087,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(233, 233, 233, 1),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: width * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: height * 0.02,
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      testCode,
                      style: TextStyle(
                          fontSize: height * 0.015,
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "$timeTaken",
                      style: TextStyle(
                          fontSize: height * 0.013,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.023,
                    ),
                    Text(
                      datetime,
                      style: TextStyle(
                          fontSize: height * 0.013,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "$time IST",
                      style: TextStyle(
                          fontSize: height * 0.013,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.233,
                decoration: BoxDecoration(
                    color: percent > 50
                        ? const Color.fromRGBO(82, 165, 160, 1)
                        : const Color.fromRGBO(255, 166, 0, 1),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$percent%',
                      style: TextStyle(
                          fontSize: height * 0.04,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 30, left: 20),
                      child: Divider(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        thickness: 2,
                      ),
                    ),
                    Text(
                      '$securedMark/$totalMark',
                      style: TextStyle(
                          fontSize: height * 0.02,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
