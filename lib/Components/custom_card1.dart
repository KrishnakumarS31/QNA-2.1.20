import 'package:flutter/material.dart';

class CustomCard1 extends StatelessWidget {
  const CustomCard1({
    Key? key,
    required this.height,
    required this.width,
    required this.subject,
    required this.title,
    required this.subTitle,
    required this.subTopic,
    required this.std,
    required this.date,
    required this.status,
  }) : super(key: key);

  final double height;
  final double width;
  final String subject;
  final String title;
  final String subTitle;
  final String subTopic;
  final String std;
  final String date;
  final Color status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1825,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(233, 233, 233, 1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subject - $subject',
                  style: TextStyle(
                      color: Color.fromRGBO(28, 78, 80, 1),
                      fontSize: height * 0.0187,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, 1),
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
                  color: status,
                  size: width * 0.05,
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, 0.7),
                      fontSize: height * 0.0125,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.02, left: width * 0.02),
            child: Divider(),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: width * 0.03, bottom: height * 0.005),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Title - $title',
                style: TextStyle(
                    color: Color.fromRGBO(82, 165, 160, 1),
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
                'Sub Topic $subTopic',
                style: TextStyle(
                    color: Color.fromRGBO(82, 165, 160, 1),
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
                'Class $std',
                style: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1),
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
