import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/verify_otp_page.dart';
import '../Components/custom_incorrect_popup.dart';

class StudGuestAssessment extends StatefulWidget {
  const StudGuestAssessment({
    Key? key,
    required this.name
  }) : super(key: key);

  final String name;
  @override
  StudGuestAssessmentState createState() => StudGuestAssessmentState();
}

class StudGuestAssessmentState extends State<StudGuestAssessment> {
  final formKey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
            children: [
              Container(
                height: height * 0.26,
                width: width,
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 106, 100, 1),
                      Color.fromRGBO(82, 165, 160, 1)
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          width ,
                          height * 0.30)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [

                    Container(
                      width: width * 0.03,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: IconButton(
                            icon:const Icon(
                              Icons.chevron_left,
                              size: 40.0,
                              color: Colors.white,
                            ), onPressed: () {
                            Navigator.of(context).pop();
                          },
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        height: height * 0.22,
                        width: width * 0.22,
                        // decoration: BoxDecoration(
                        //     //color: Colors.yellow[100],
                        //     border: Border.all(
                        //       color: Colors.red,
                        //       width: 1,
                        //     )),
                        child: Image.asset("assets/images/question_mark_logo.png"),
                      ),
                    ),
                    Container(
                      width: width * 0.03,
                    )

                  ],
                ),
              ),
              SizedBox(height:height * 0.03),
              Form(
                key: formKey,
                child: Container(
                  height: height*0.45,
                  child: Column(
                    children:  [
                      Text(
                        "WELCOME",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.036,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height:height * 0.03),
                      Text(
                        widget.name,
                        style:  TextStyle(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          fontSize: height * 0.033,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height:height * 0.08),
                      Container(
                        width: width * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child:
                              Text("ASSESSMENT ID",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    ?.merge( TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.017)),),

                            ),
                            SizedBox(
                              height: height * 0.0001,
                            ),
                            Align(alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    helperStyle: const TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                                    hintText: "Enter Test Paper ID",
                                    prefixIcon: Icon(
                                      Icons.account_box_outlined,color: const Color.fromRGBO(82, 165, 160, 1),size: height * 0.04,),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                                      return "Assessment ID not found";
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                )
                            ),
                            Container(height: height * 0.04,

                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.016,
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                          minimumSize:  Size(width * 0.77, height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        onPressed: () {
                          bool valid=formKey.currentState!.validate();
                          if(valid){
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: VerifyOtpPage(),
                              ),
                            );
                          }
                          else {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const CustomDialog(title: 'Assessment ID not found', content: '', button: 'Retry',),
                              ),
                            );
                          }

                        },
                        child: Text(
                          'Start',
                          style: TextStyle(
                              fontSize: height * 0.024,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color.fromRGBO(141, 167, 167, 1),
                        ),
                        onPressed: () {},
                      ),
                      const Text("Search Library",
                          style: TextStyle(
                              color: Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ],
                  )),
            ]));
  }
}