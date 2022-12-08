import 'package:flutter/material.dart';


class StudentSelectionPage extends StatefulWidget {
  const StudentSelectionPage({super.key});

  @override
  StudentSelectionPageState createState() => StudentSelectionPageState();
}
class StudentSelectionPageState extends State<StudentSelectionPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //double height = MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Colors.white,
      body :Column(
        children: [
        Container(
      height: 300.0,
      color: Colors.transparent,
      child: Container(
        height: height / 2.1,
        width: width / 1.07,
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A5E9D),
              Color(0xFF00CDAC),
            ],
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
              width / 15,
            ),
    ),
    ),
    ),
    ),
          SizedBox(height: 30,),
          Text("STUDENT",style: TextStyle(fontSize: height * 0.032,fontFamily: "Inter",fontWeight:FontWeight.w800,),)
        ]));

  }
}

