import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/stud_guest_assessment.dart';

import '../Components/custom_incorrect_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class StudentGuestLogin extends StatefulWidget {
  const StudentGuestLogin({super.key});

  @override
  StudentGuestLoginState createState() => StudentGuestLoginState();
}

enum SingingCharacter { guest, member }

class StudentGuestLoginState extends State<StudentGuestLogin> {
  final formKey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController reNameController=TextEditingController();
  TextEditingController rollNumController=TextEditingController();
  bool agree = false;
  String name='';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      GestureDetector(
                        onTap:(){
                          Navigator.of(context).pop();
                          },
                        child: SizedBox(
                          width: width * 0.05,

                          child: Column(
                            children: [
                              SizedBox(height: height * 0.03,),
                              IconButton(
                                icon:const Icon(
                                  Icons.chevron_left,
                                  size: 40.0,
                                  color: Colors.white,
                                ), onPressed: () {
                                Navigator.of(context).pop();
                              },
                              ),

                            ],
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
                Text(
                  '${AppLocalizations.of(context)!.guestCaps} ${AppLocalizations.of(context)!.studentCaps}',
                  style: TextStyle(
                    fontSize: height* 0.03,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height:height * 0.07),
                SizedBox(
                  width: width * 0.8,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child:
                              Text(AppLocalizations.of(context)!.name,
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
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!.your_name,
                                    hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),
                                    prefixIcon: Icon(
                                      Icons.account_box_outlined,color: const Color.fromRGBO(82, 165, 160, 1),size: height * 0.03,),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                                      return AppLocalizations.of(context)!.enter_your_name;
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                )
                            ),
                          ],
                        ),
                        SizedBox(height:height * 0.06),
                        //SizedBox(height:height * 0.04),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child:
                              Text(AppLocalizations.of(context)!.registrationIdRollNum,
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
                                  controller: rollNumController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!.enter_id,
                                    hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: height * 0.02),

                                    prefixIcon: Icon(
                                        Icons.assignment_ind_outlined,color: const Color.fromRGBO(82, 165, 160, 1),size: height * 0.03),
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return AppLocalizations.of(context)!.enter_registrationId;
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                )
                            ),
                          ],
                        ),
                        SizedBox(height:height * 0.07),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(AppLocalizations.of(context)!.privacy_terms,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                ?.merge( TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: height * 0.015)),),
                        ),
                        SizedBox(height:height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: const Color.fromRGBO(82, 165, 160, 1),
                              fillColor: MaterialStateProperty
                                  .resolveWith<Color>((states) {
                                if (states.contains(
                                    MaterialState.selected)) {
                                  return const Color.fromRGBO(82, 165, 160, 1); // Disabled color
                                }
                                return const Color.fromRGBO(82, 165, 160, 1); // Regular color
                              }),
                              value: agree,
                              onChanged: (val) {
                                setState(() {
                                  agree = val!;
                                  if (agree) {
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 5,),
                             Expanded(
                               child: Text(AppLocalizations.of(context)!.privacy_policy, textAlign: TextAlign.left,style: TextStyle(
                                 fontSize: height *0.013
                               ),),
                             )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height * 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                    minimumSize: const Size(280, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(39),
                    ),
                  ),
                  //shape: StadiumBorder(),
                  onPressed: () {
                    if(agree){
                      if(formKey.currentState!.validate()) {
                        name = nameController.text;
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: StudGuestAssessment(name: name),
                          ),
                        );
                      }
                    }
                    else{
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CustomDialog(title: AppLocalizations.of(context)!.agree_privacy_terms, content: AppLocalizations.of(context)!.error, button: AppLocalizations.of(context)!.retry),
                        ),
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                        fontSize: height * 0.032,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800),
                  ),
                ),



              ]),
        ));
  }
}


