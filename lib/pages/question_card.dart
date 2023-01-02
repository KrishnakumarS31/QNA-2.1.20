// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../Entity/question_model.dart';
// import '../Providers/question_num_provider.dart';
// class Questioncard extends StatefulWidget {
//   const Questioncard({Key? key,required this.quesAns}) : super(key: key);
//   final Map quesAns;
//
//   @override
//   State<Questioncard> createState() => _QuestioncardState();
// }
//
// class _QuestioncardState extends State<Questioncard> {
//   Color notSureColor1=const Color.fromRGBO(255, 255, 255, 1);
//   Color notSureColor2=const Color.fromRGBO(255, 153, 0, 1);
//   IconData notSureIcon=Icons.mode_comment_outlined;
//   List<Question> question=getData();
//   static List<Question> getData() {
//     const data=[{
//       "id":1,
//       "mark":25,
//       "question":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
//       "options":[
//         "a. Option 1","b. Option 2","c. Option 3"
//       ]
//     },
//       {
//         "id":2,
//         "mark":5,
//         "question":"What type of music are you into?",
//         "options":[
//           "Option 1","Option 2","Option 3"
//         ]
//       },
//       {
//         "id":3,
//         "mark":25,
//         "question":"If you could only eat one food for the rest of your life, what would it be?",
//         "options":[
//           "a. Option 1", "b. Option 2", "c. Option 3","a. Option 1", "b. Option 2", "c. Option 3"
//         ]
//       },
//       {
//         "id":4,
//         "mark":25,
//         "question":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
//         "options":[
//           "a. Option 1","b. Option 2","c. Option 3"
//         ]
//       },
//       {
//         "id":5,
//         "mark":5,
//         "question":"What type of music are you into?",
//         "options":[
//           "a. Option 1","b. Option 2","c. Option 3"
//         ]
//       },
//       {
//         "id": 6,
//         "mark": 25,
//         "question": "If you could only eat one food for the rest of your life, what would it be?",
//         "options": [
//           "a. Option 1", "b. Option 2", "c. Option 3","a. Option 1", "b. Option 2", "c. Option 3"
//         ]
//       }];
//     return data.map<Question>(Question.fromJson).toList();
//   }
//   dynamic select;
//
//
//   Widget customRadio(String text , dynamic index,int quesNum,double height,double width){
//     return GestureDetector(
//       onTap: (){
//         select=index;
//         context.read<Questions>().selectOption(quesNum,select,true);
//       },
//       child: Padding(
//         padding: EdgeInsets.only(bottom: height * 0.013,left: height * 0.02),
//         child: Container(
//             width: width * 0.744,
//             height: height * 0.0412,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               border: Border.all(
//                   color: const Color.fromRGBO(209, 209, 209, 1)
//               ),
//               color: (select == index) ? const Color.fromRGBO(82, 165, 160, 1) :const Color.fromRGBO(255, 255, 255, 1),
//             ),
//             child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(width: width * 0.02,),
//                   Text(text,
//                     style: TextStyle(
//                       color: (select == index) ? const Color.fromRGBO(255, 255, 255, 1) :const Color.fromRGBO(102, 102, 102, 1),
//                       fontSize: height * 0.0162,
//                       fontFamily: "Inter",
//                       fontWeight: FontWeight.w700,
//                     ),),
//                 ])
//         ),
//       ),
//     );
//   }
//
// @override
//   void initState() {
//     //
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Container(
//       height: height * 0.6675,
//       width:  width * 0.855,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 2.0,
//           ),
//         ],
//       ),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height: height * 0.0625,
//                   width: width * 0.2277,
//                   child: Center(
//                     child: Text("${question[context.watch<QuestionNumProvider>().questionNum-1].id}",
//                       style: Theme.of(context)
//                           .primaryTextTheme
//                           .bodyText1
//                           ?.merge( TextStyle(
//                           color: const Color.fromRGBO(82, 165, 160, 1),
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w700,
//                           fontSize: height * 0.025)),),
//                   ),
//                 ),
//                 Container(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
//                     color: Color.fromRGBO(28, 78, 80, 1),),
//                   height: height * 0.0625,
//                   width: width * 0.2277,
//
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("${question[context.watch<QuestionNumProvider>().questionNum-1].mark}",
//                         style: Theme.of(context)
//                             .primaryTextTheme
//                             .bodyText1
//                             ?.merge( TextStyle(
//                             color: const Color.fromRGBO(255, 255, 255, 1),
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w600,
//                             fontSize: height * 0.0237)),),
//                       Text(" Marks",
//                         style: Theme.of(context)
//                             .primaryTextTheme
//                             .bodyText1
//                             ?.merge( TextStyle(
//                             color: const Color.fromRGBO(255, 255, 255, 1),
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w600,
//                             fontSize: height * 0.0137)),),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: height * 0.02,),
//             Padding(
//               padding: EdgeInsets.only(left: height * 0.02,right: height * 0.02,bottom: height * 0.025),
//               child: Container(
//                 height: height * 0.16,
//                 width: width * 0.744,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Text(question[context.watch<QuestionNumProvider>().questionNum-1].question,
//                     style: Theme.of(context)
//                         .primaryTextTheme
//                         .bodyText1
//                         ?.merge( TextStyle(
//                         color: const Color.fromRGBO(51, 51, 51, 1),
//                         fontFamily: 'Inter',
//                         height: height * 0.0020,
//                         fontWeight: FontWeight.w400,
//                         fontSize: height * 0.016)),),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 for (int j=0; j<question[context.watch<QuestionNumProvider>().questionNum-1].options.length; j++)
//
//                     customRadio(question[context
//                         .watch<QuestionNumProvider>()
//                         .questionNum - 1].options[j], j, context
//                         .watch<QuestionNumProvider>()
//                         .questionNum, height, width),
//
//                 ],
//             ),
//
//             GestureDetector(
//               onTap: (){
//                 if(notSureColor1==const Color.fromRGBO(255, 255, 255, 1)){
//                   setState(() {
//                     select=null;
//                     notSureIcon=Icons.mode_comment_sharp;
//                     notSureColor1=const Color.fromRGBO(255, 153, 0, 1);
//                     notSureColor2=const Color.fromRGBO(255, 255, 255, 1);
//                   });
//
//                 } else{
//                   setState(() {
//                     notSureIcon=Icons.mode_comment_outlined;
//                     notSureColor1=const Color.fromRGBO(255, 255, 255, 1);
//                     notSureColor2=const Color.fromRGBO(255, 153, 0, 1);
//                   });
//
//                 }
//               },
//               child: Padding(padding: EdgeInsets.only(left: height * 0.02),
//                   child: Stack(
//                     children:  [
//                       Icon(notSureIcon,color: const Color.fromRGBO(255, 153, 0, 1),),
//                       Positioned(
//                           left: width * 0.008,
//                           top: height * 0.005,
//                           child: Icon(Icons.question_mark,
//                             color: notSureColor2,
//                             size: height*0.014,))
//                     ],
//                   )
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
