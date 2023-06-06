import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/pages/student_looq_landing_page.dart';
import '../DataSource/http_url.dart';
class StudentSearchLibrary extends StatefulWidget {
  const StudentSearchLibrary({
    Key? key,
  }) : super(key: key);

  @override
  StudentSearchLibraryState createState() => StudentSearchLibraryState();
}

class StudentSearchLibraryState extends State<StudentSearchLibrary> {
  bool agree = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > webWidth) {
        return Center(
            child: SizedBox(
            width: webWidth,
            child:  WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                toolbarHeight: height * 0.100,
                centerTitle: true,
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "SEARCH LIBRARY",
                        style: TextStyle(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontSize: height * 0.0225,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                          colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1),
                      ])),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.023,
                        left: height * 0.023,
                        right: height * 0.023),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Search Library  (LOOQ)",
                          style: TextStyle(
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.02),
                        ),
                        Text(
                          "Library Of Practice Assessments",
                          style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: height * 0.015),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: height * 0.016),
                            hintText: "Maths, 10th, CBSE, Assessment ID",
                            suffixIcon: Column(children: [
                              Container(
                                  height: height * 0.073,
                                  width: width * 0.13,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  ),
                                  child: IconButton(
                                    iconSize: height * 0.04,
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const StudentLooqLanding(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.search),
                                  )),
                            ]),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(82, 165, 160, 1)),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          enabled: true,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: height * 0.040),
                          child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "DISCLAIMER:",
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontFamily: "Inter"),
                                ),
                                TextSpan(
                                  text:
                                      "\t ITNEducation is not responsible for\nthe content and accuracy of the Questions & Answer available in the Library.",
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(
                                          153, 153, 153, 1),
                                      fontFamily: "Inter"),
                                ),
                              ])),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const Color.fromRGBO(82, 165, 160, 1);
                                }
                                return const Color.fromRGBO(82, 165, 160, 1);
                              }),
                              value: agree,
                              onChanged: (val) {
                                setState(() {
                                  agree = val!;
                                  if (agree) {}
                                });
                              },
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Expanded(
                              child: Text(
                                "Show Assessments from my Institution/Organization",
                                style: TextStyle(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.015),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ))));
      } else {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                toolbarHeight: height * 0.100,
                centerTitle: true,
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "SEARCH LIBRARY",
                        style: TextStyle(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontSize: height * 0.0225,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                          colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1),
                      ])),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.023,
                        left: height * 0.023,
                        right: height * 0.023),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Search Library  (LOOQ)",
                          style: TextStyle(
                              color: const Color.fromRGBO(82, 165, 160, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.02),
                        ),
                        Text(
                          "Library Of Practice Assessments",
                          style: TextStyle(
                              color: const Color.fromRGBO(153, 153, 153, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: height * 0.015),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: height * 0.016),
                            hintText: "Maths, 10th, CBSE, Assessment ID",
                            suffixIcon: Column(children: [
                              Container(
                                  height: height * 0.073,
                                  width: width * 0.13,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                  ),
                                  child: IconButton(
                                    iconSize: height * 0.04,
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const StudentLooqLanding(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.search),
                                  )),
                            ]),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(82, 165, 160, 1)),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          enabled: true,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: height * 0.040),
                          child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "DISCLAIMER:",
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromRGBO(82, 165, 160, 1),
                                      fontFamily: "Inter"),
                                ),
                                TextSpan(
                                  text:
                                      "\t ITNEducation is not responsible for\nthe content and accuracy of the Questions & Answer available in the Library.",
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(
                                          153, 153, 153, 1),
                                      fontFamily: "Inter"),
                                ),
                              ])),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor:
                                  const Color.fromRGBO(82, 165, 160, 1),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return const Color.fromRGBO(82, 165, 160, 1);
                                }
                                return const Color.fromRGBO(82, 165, 160, 1);
                              }),
                              value: agree,
                              onChanged: (val) {
                                setState(() {
                                  agree = val!;
                                  if (agree) {}
                                });
                              },
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Expanded(
                              child: Text(
                                "Show Assessments from my Institution/Organization",
                                style: TextStyle(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.015),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ));
      }
    });
  }
}
