import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Components/custom_incorrect_popup.dart';
import 'package:qna_test/pages/student_assessment_questions.dart';
import 'package:qna_test/pages/student_search_library.dart';
import '../Components/end_drawer_menu_student.dart';
import '../Entity/question_paper_model.dart';
import '../EntityModel/user_data_model.dart';
import '../Services/qna_service.dart';

class StudentAssessment extends StatefulWidget {
  StudentAssessment({
    Key? key,required this.regNumber, required this.setLocale,required this.usedData
  }) : super(key: key);
  final void Function(Locale locale) setLocale;
  final String? regNumber;
  UserDataModel? usedData;

  @override
  StudentAssessmentState createState() => StudentAssessmentState();
}
class StudentAssessmentState extends State<StudentAssessment> {
  TextEditingController assessmentID = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  late QuestionPaperModel values;
  UserDataModel userDataModel=UserDataModel(code: 0, message: '');
  String name = "Student";
  String email = "Student@gmail.com";
  String assessmentId = "";


  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
      setState((){
        name=widget.usedData!.data!.firstName;
        email = widget.usedData!.data!.email;
      });
  }
  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 700)
        {
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                backgroundColor: Colors.transparent,
              ),
              endDrawer: EndDrawerMenuStudent(setLocale: widget.setLocale,userName: name,email: email,userId: widget.usedData!.data!.id),
              body:
              SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child:
                  Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    localWidth,
                                    localHeight * 0.35)
                            ),
                          ),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children : [
                              const SizedBox(height:50.0),
                              Align(
                                alignment: Alignment.topCenter,
                                child:
                                Container(
                                  padding: const EdgeInsets.all(0.0),
                                  height: localHeight * 0.20,
                                  width: localWidth * 0.30,
                                  child: Image.asset("assets/images/question_mark_logo.png"),
                                ),
                              ),
                              const SizedBox(height: 25.0),

                            ],
                          ),
                        ),
                        Container(
                          width: 149,
                          margin: const EdgeInsets.all(15),
                          child: Column(
                              children: [
                                Align(alignment: Alignment.center,
                                  child:
                                  Text(AppLocalizations.of(context)!.welcome,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.02,
                                        fontSize: 24),),
                                ),
                                SizedBox(
                                  height: localHeight * 0.02,
                                ),
                                Text(name,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(const TextStyle(
                                      color: Color.fromRGBO(28, 78, 80, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.02,
                                      fontSize: 24)),),
                                SizedBox(
                                  height: localHeight * 0.03,
                                ),
                              ]),

                        ),
                        SizedBox(
                          width: localWidth * 0.4,

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                          AppLocalizations.of(context)!.enter_assId,
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.017),
                                        ),
                                        TextSpan(
                                            text: "\t*",
                                            style: TextStyle(
                                                color:
                                                const Color.fromRGBO(219, 35, 35, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.017)),
                                      ])),
                                ),
                                SizedBox(
                                  height: localHeight * 0.02,
                                ),
                                Column(
                                  children:  [
                                    Align(alignment: Alignment.center,
                                      child: Form(
                                          key: formKey,
                                          autovalidateMode: AutovalidateMode.disabled,
                                          child: TextFormField(
                                              validator: (value){
                                                return value!.length < 8 ? AppLocalizations.of(context)!.valid_assId : null;
                                              },
                                              controller: assessmentID,
                                              onChanged: (val)
                                              {
                                                formKey.currentState!.validate();
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                                              ],
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                helperStyle: const TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                                                hintText: AppLocalizations.of(context)!.assessment_id,
                                                prefixIcon: const Icon(
                                                    Icons.event_note_outlined,color: Color.fromRGBO(82, 165, 160, 1)),
                                              )
                                          )
                                      ),
                                    )],
                                ),
                              ]),

                        ),
                        SizedBox(
                          height: localHeight * 0.08,
                        ),
                        Column(
                          children: [
                            Align(alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: const Size(280, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                //shape: StadiumBorder(),
                                child: Text(AppLocalizations.of(context)!.start,
                                    style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    assessmentId = assessmentID.text;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                color: Color.fromRGBO(
                                                    48, 145, 139, 1),
                                              ));
                                        });
                                    values = await QnaService.getQuestion(assessmentId: assessmentID.text);
                                    Navigator.of(context).pop();
                                    if (values.code == 200) {
                                      if (assessmentID.text.length >= 8) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: StudQuestion(
                                                assessmentId: assessmentID.text,
                                                setLocale: widget.setLocale,
                                                ques: values,
                                                userName: userDataModel.data!.firstName),
                                          ),
                                        );
                                      }
                                    }
                                    else {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: AppLocalizations.of(context)!.invalid_assessment_iD,
                                            content: '',
                                            button: AppLocalizations.of(context)!.retry,),
                                        ),
                                      );
                                    }
                                  }
                                },
                                // onPressed: () async {
                                //   if (formKey.currentState!.validate()) {
                                //     Navigator.push(
                                //       context,
                                //       PageTransition(
                                //         type: PageTransitionType.rightToLeft,
                                //         child: const StudReviseQuest(),
                                //       ),
                                //     );
                                //   }
                                //   else {
                                //     setState(() {
                                //       autoValidate = true;
                                //     });
                                //   }
                                // }
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: localHeight * 0.02,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: StudentSearchLibrary(setLocale: widget.setLocale),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Icon(
                                  Icons.search,
                                  color: Color.fromRGBO(141, 167, 167, 1),
                                ),
                              Text(AppLocalizations.of(context)!.search_library,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(48, 145, 139, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                      ])));
        }
        else {
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                backgroundColor: Colors.transparent,
              ),
              endDrawer: EndDrawerMenuStudent(setLocale: widget.setLocale,userName: name,email: email,userId: widget.usedData!.data!.id),
              body:
              SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child:
                  Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(0, 106, 100, 1),
                                Color.fromRGBO(82, 165, 160, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    localWidth,
                                    localHeight * 0.35)
                            ),
                          ),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children : [
                              const SizedBox(height:50.0),
                              Align(
                                alignment: Alignment.topCenter,
                                child:
                                Container(
                                  padding: const EdgeInsets.all(0.0),
                                  height: localHeight * 0.20,
                                  width: localWidth * 0.30,
                                  child: Image.asset("assets/images/question_mark_logo.png"),
                                ),
                              ),
                              const SizedBox(height: 25.0),

                            ],
                          ),
                        ),
                        Container(
                          width: 149,
                          margin: const EdgeInsets.all(15),
                          child: Column(
                              children: [
                                Align(alignment: Alignment.center,
                                  child:
                                  Text(AppLocalizations.of(context)!.welcome,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(28, 78, 80, 1),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.02,
                                        fontSize: 24),),
                                ),
                                SizedBox(
                                  height: localHeight * 0.02,
                                ),
                                Text(name,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge
                                      ?.merge(const TextStyle(
                                      color: Color.fromRGBO(28, 78, 80, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.02,
                                      fontSize: 24)),),
                                SizedBox(
                                  height: localHeight * 0.03,
                                ),
                              ]),

                        ),
                        Container(
                          //margin: const EdgeInsets.only(left: 10,right: 50),
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                          AppLocalizations.of(context)!.enter_assId,
                                          style: TextStyle(
                                              color:
                                              const Color.fromRGBO(102, 102, 102, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.017),
                                        ),
                                        TextSpan(
                                            text: "\t*",
                                            style: TextStyle(
                                                color:
                                                const Color.fromRGBO(219, 35, 35, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                                fontSize: localHeight * 0.017)),
                                      ])),
                                ),
                                SizedBox(
                                  height: localHeight * 0.02,
                                ),
                                Column(
                                  children:  [
                                    Align(alignment: Alignment.center,
                                      child: Form(
                                          key: formKey,
                                          autovalidateMode: AutovalidateMode.disabled,
                                          child: TextFormField(
                                              validator: (value){
                                                return value!.length < 8 ? AppLocalizations.of(context)!.valid_assId : null;
                                              },
                                              controller: assessmentID,
                                              onChanged: (val)
                                              {
                                                formKey.currentState!.validate();
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                                              ],
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                helperStyle: const TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                                                hintText: AppLocalizations.of(context)!.assessment_id,
                                                prefixIcon: const Icon(
                                                    Icons.event_note_outlined,color: Color.fromRGBO(82, 165, 160, 1)),
                                              )
                                          )
                                      ),
                                    )],
                                ),
                              ]),

                        ),
                        SizedBox(
                          height: localHeight * 0.08,
                        ),
                        Column(
                          children: [
                            Align(alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                  minimumSize: const Size(280, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39),
                                  ),
                                ),
                                //shape: StadiumBorder(),
                                child: Text(AppLocalizations.of(context)!.start,
                                    style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    assessmentId = assessmentID.text;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                color: Color.fromRGBO(
                                                    48, 145, 139, 1),
                                              ));
                                        });
                                    values = await QnaService.getQuestion(assessmentId: assessmentID.text);
                                    Navigator.of(context).pop();
                                    if (values.code == 200) {
                                      if (assessmentID.text.length >= 8) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child: StudQuestion(
                                                assessmentId: assessmentID.text,
                                                ques: values,
                                                setLocale: widget.setLocale,
                                                userName: name),
                                          ),
                                        );
                                      }
                                    }
                                    else {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: CustomDialog(
                                            title: AppLocalizations.of(context)!.invalid_assessment_iD,
                                            content: '',
                                            button: AppLocalizations.of(context)!.retry,),
                                        ),
                                      );
                                    }
                                  }
                                },
                                // onPressed: () async {
                                //   if (formKey.currentState!.validate()) {
                                //     Navigator.push(
                                //       context,
                                //       PageTransition(
                                //         type: PageTransitionType.rightToLeft,
                                //         child: const StudReviseQuest(),
                                //       ),
                                //     );
                                //   }
                                //   else {
                                //     setState(() {
                                //       autoValidate = true;
                                //     });
                                //   }
                                // }
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: localHeight * 0.02,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: StudentSearchLibrary(setLocale: widget.setLocale),
                              ),
                            );
                          },
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
                              Text(AppLocalizations.of(context)!.search_library,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(48, 145, 139, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                      ])));
        }
      },
    );

  }
}


// ElevatedButton(onPressed: (){print("Button");}, child: Text("Button")),