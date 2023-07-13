import 'package:flutter/material.dart';
import 'package:qna_test/Components/today_date.dart';
import '../EntityModel/get_result_details_model.dart';


class ResultCardNew extends StatelessWidget {
   ResultCardNew({
    Key? key,
    required this.height,
    required this.width,
    required this.index,
    required this.results,
    this.assessmentResults
  }) : super(key: key);

  final double height;
  final double width;
  final int index;
  final GetResultDetailsModel results;
  List<AssessmentResultsDetails>? assessmentResults;

  @override
  Widget build(BuildContext context) {
    bool condition = assessmentResults!.isEmpty == false;
    int? timeTaken = condition ? assessmentResults![index].attemptDuration : 0;
    int? percent = condition ? assessmentResults![index].attemptPercent : 0;
    int? securedMark = condition ? assessmentResults![index].attemptScore : 0;
    int? totalMark = results.totalScore ?? 0;

    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.015),
      child: Container(
          height: height * 0.1087,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(233, 233, 233, 1),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                      results.assessmentCode ?? " ",
                      style: TextStyle(
                          fontSize: height * 0.0187,
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      convertAttemptDuration(timeTaken),
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
                    Text(
                      assessmentResults![index].attemptStartDate != null ? convertDate(assessmentResults![index].attemptStartDate) : " ",
                      style: TextStyle(
                          fontSize: height * 0.013,
                          color: const Color.fromRGBO(102, 102, 102, 1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      assessmentResults![index].attemptEndDate != null ? "${convertTime(assessmentResults![index].attemptEndDate)} IST" : "",
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
                    color: percent! > 50
                        ? const Color.fromRGBO(82, 165, 160, 1)
                        : const Color.fromRGBO(255, 166, 0, 1),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
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
