import 'package:flutter/material.dart';
import 'package:qna_test/Components/today_date.dart';
import '../EntityModel/get_result_details_model.dart';

class ResultTotalCard extends StatelessWidget {
  ResultTotalCard({
    Key? key,
    required this.height,
    required this.width,
    this.results,
    required this.index,
  }) : super(key: key);

  final double height;
  final double width;
  GetResultDetailsModel? results;
  final int index;

  @override
  Widget build(BuildContext context) {

    bool condition = results!.assessmentResults!.isEmpty == false;
    String? name = condition ? results!.assessmentResults![index].firstName : " ";
    String? assessmentCode = results!.assessmentCode ?? " ";
    int? timeTaken = condition ? results!.assessmentResults![index].attemptDuration : 0;
    int? percent = condition ? results!.assessmentResults![index].attemptPercent : 0;
    int? securedMark = condition ? results!.assessmentResults![index].attemptScore : 0;
    int? totalMark = results!.totalScore ?? 0;
    String? rollNumber = condition ?  results!.assessmentResults![index].rollNumber : " ";
    if (width > 960) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: height * 0.01),
                  width: width * 0.15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        name ?? " ",
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        rollNumber ?? " ",
                        style: TextStyle(
                            fontSize: height * 0.015,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        timeTaken != null ? convertAttemptDuration(timeTaken) : "0",
                        style: TextStyle(
                            fontSize: height * 0.013,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.only(right:width * 0.01),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.023,
                          ),
                          Text(
                            results!.assessmentResults![index].attemptStartDate != null ? convertDate(results!.assessmentResults![index].attemptStartDate) : " ",
                            style: TextStyle(
                                fontSize: height * 0.013,
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            results!.assessmentResults![index].attemptEndDate != null ? "${convertTime(results!.assessmentResults![index].attemptEndDate)} IST" : "",
                            style: TextStyle(
                                fontSize: height * 0.013,
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.1,
                    decoration: BoxDecoration(
                        color: percent! > 50
                            ? const Color.fromRGBO(82, 165, 160, 1)
                            : const Color.fromRGBO(255, 166, 0, 1),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Text(
                            '$percent%',
                            style: TextStyle(
                                fontSize: height * 0.03,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 30, left: 20),
                          child: Divider(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '$securedMark/$totalMark',
                            style: TextStyle(
                                fontSize: height * 0.02,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  )
                ],),
              ],
            )),
      );}else{
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
                Container(
                  padding: EdgeInsets.only(left: height * 0.01),
                  width: width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        name ?? " ",
                        style: TextStyle(
                            fontSize: height * 0.02,
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        assessmentCode,
                        style: TextStyle(
                            fontSize: height * 0.015,
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        timeTaken != null ? convertAttemptDuration(timeTaken) : "0",
                        style: TextStyle(
                            fontSize: height * 0.013,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
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
                        results!.assessmentResults![index].attemptStartDate != null ? convertDate(results!.assessmentResults![index].attemptStartDate) : " ",
                        style: TextStyle(
                            fontSize: height * 0.013,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        results!.assessmentResults![index].attemptEndDate != null ? "${convertTime(results!.assessmentResults![index].attemptEndDate)} IST" : "",
                        style: TextStyle(
                            fontSize: height * 0.013,
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.233,
                  decoration: BoxDecoration(
                      color: percent! > 50
                          ? const Color.fromRGBO(82, 165, 160, 1)
                          : const Color.fromRGBO(255, 166, 0, 1),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Text(
                          '$percent%',
                          style: TextStyle(
                              fontSize: height * 0.03,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 30, left: 20),
                        child: Divider(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          '$securedMark/$totalMark',
                          style: TextStyle(
                              fontSize: height * 0.02,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      );
    }
  }
}
