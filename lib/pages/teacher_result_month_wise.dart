// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:qna_test/Pages/teacher_result_assessment.dart';
// import '../EntityModel/get_result_model.dart';
// import '../Components/custom_card.dart';
//
// class TeacherResultMonth extends StatefulWidget {
//    TeacherResultMonth({
//     Key? key, required this.result
//   }) : super(key: key);
//   List <GetResultModel> result;
//
//
//   @override
//   TeacherResultMonthState createState() => TeacherResultMonthState();
// }
//
// class TeacherResultMonthState extends State<TeacherResultMonth> {
//   @override
//   void initState() {
//     super.initState();
//     print(widget.result[0].assessmentCode);
//     print(widget.result[0].assessmentType);
//     print(widget.result[0].assessmentEndDate);
//     print(widget.result[0].assessmentStartDate);
//     print(widget.result[0].assessmentDuration);
//     print(widget.result[0].toString());
//     print("dcdsc");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//
//     return WillPopScope( onWillPop: () async => false, child:Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(
//               Icons.chevron_left,
//               size: 40.0,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           toolbarHeight: height * 0.100,
//           centerTitle: true,
//           title: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   'RESULTS',
//                   style: TextStyle(
//                     color: const Color.fromRGBO(255, 255, 255, 1),
//                     fontSize: height * 0.0175,
//                     fontFamily: "Inter",
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Text(
//                   "Dec 2022",
//                   style: TextStyle(
//                     color: const Color.fromRGBO(255, 255, 255, 1),
//                     fontSize: height * 0.0225,
//                     fontFamily: "Inter",
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ]),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                     end: Alignment.bottomCenter,
//                     begin: Alignment.topCenter,
//                     colors: [
//                   Color.fromRGBO(0, 106, 100, 1),
//                   Color.fromRGBO(82, 165, 160, 1),
//                 ])),
//           ),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding: EdgeInsets.only(
//                 top: height * 0.023,
//                 left: height * 0.023,
//                 right: height * 0.023),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     '27 Dec, 2022',
//                     style: TextStyle(
//                         color: const Color.fromRGBO(179, 179, 179, 1),
//                         fontSize: height * 0.0187,
//                         fontFamily: "Inter",
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.01,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                       type: PageTransitionType.rightToLeft,
//                       child:  TeacherResultAssessment(result: widget.result[0]),
//                     ),
//                   );
//                 },
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: widget.result.toString().length,
//                   itemBuilder: (context,index) =>
//                       Column(
//                         children: [
//                           CustomCard(
//                             height: height,
//                             width: width,
//                             subject: widget.result[0].assessmentCode,
//                             title: widget.result[0].assessmentType,
//                             result: widget.result[0],
//                             subTopic: "${widget.result[0].assessmentStartDate}",
//                             std: "${widget.result[0].assessmentEndDate}",
//                             date: widget.result[0].assessmentEndDate,
//                             status: const Color.fromRGBO(255, 157, 77, 1),
//                           ),
//                           SizedBox(
//                             height: height * 0.02,
//                           ),
//                         ],
//                       ),
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.01,
//               ),
//               // CustomCard(
//               //   height: height,
//               //   width: width,
//               //   subject: widget.result.assessmentCode,
//               //   title: widget.result.assessmentType,
//               //   result: widget.result,
//               //   subTopic: "${widget.result.assessmentStartDate}",
//               //   std: "${widget.result.assessmentEndDate}",
//               //   date: widget.result.assessmentEndDate,
//               //   status: const Color.fromRGBO(255, 157, 77, 1),
//               // ),
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     '22 Dec, 2022',
//                     style: TextStyle(
//                         color: const Color.fromRGBO(179, 179, 179, 1),
//                         fontSize: height * 0.0187,
//                         fontFamily: "Inter",
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.01,
//               ),
//                   ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: 0,
//                     itemBuilder: (context,index) =>
//                         Column(
//                           children: [
//                             CustomCard(
//                               height: height,
//                               width: width,
//                               subject: widget.result[0].subject!,
//                               title: widget.result[0].topic!,
//                               date: widget.result[0].assessmentStartDate!,
//                               subTopic: widget.result[0].subTopic!,
//                               d1: widget.result[0].assessmentCode,
//                               result: widget.result[0],
//                               std: widget.result[0].studentClass!,
//                               status: const Color.fromRGBO(255, 157, 77, 1),),
//                             SizedBox(
//                               height: height * 0.02,
//                             ),
//                           ],
//                         ),
//                   ),
//               SizedBox(
//                 height: height * 0.01,
//               ),
//               // CustomCard(
//               //   height: height,
//               //   width: width,
//               //   subject: 'Maths',
//               //   title: 'Lesson 14 &15 / Calculus',
//               //   subTopic: 'Chapter 12',
//               //   std: 'XI',
//               //   date: 4,
//               //   //'28/12/2022',
//               //   status: const Color.fromRGBO(66, 194, 0, 1),
//               // ),
//               SizedBox(
//                 height: height * 0.02,
//               ),
//             ]),
//           ),
//         ));
//   }
// }
