import 'package:flutter/material.dart';

class Result_card1 extends StatelessWidget {
  const Result_card1({
    Key? key,
    required this.height,
    required this.width,
    required this.name,
    required this.testCode,
    required this.percent,
    required this.securedMark,
    required this.totalMark,
  }) : super(key: key);

  final double height;
  final double width;

  final String name;
  final String testCode;
  final int percent;
  final String securedMark;
  final String totalMark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.015),
      child: Container(
          height: height * 0.1087,
          decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(233, 233, 233, 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: width * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: height * 0.0187,
                          color: Color.fromRGBO(28, 78, 80, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '00:35 Min',
                      style: TextStyle(
                          fontSize: height * 0.013,
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '29/12/2022',
                      style: TextStyle(
                          fontSize: height * 0.013,
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      '15:00 IST',
                      style: TextStyle(
                          fontSize: height * 0.013,
                          color: Color.fromRGBO(102, 102, 102, 1),
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
                        ? Color.fromRGBO(82, 165, 160, 1)
                        : Color.fromRGBO(255, 166, 0, 1),
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
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
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
                          color: Color.fromRGBO(255, 255, 255, 1),
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
