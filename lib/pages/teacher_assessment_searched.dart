import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/pages/teacher_active_assessment.dart';
import 'package:qna_test/pages/teacher_inactive_assessment.dart';
import 'package:qna_test/pages/teacher_recent_assessment.dart';
import '../Components/end_drawer_menu_teacher.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/response_entity.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../Providers/create_assessment_provider.dart';
import '../Providers/edit_assessment_provider.dart';
import '../Providers/question_prepare_provider_final.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Entity/Teacher/question_entity.dart' as Questions;
import '../Services/qna_service.dart';
class TeacherAssessmentSearched extends StatefulWidget {
  const TeacherAssessmentSearched({
    Key? key,
    required this.setLocale,
  }) : super(key: key);
  final void Function(Locale locale) setLocale;

  @override
  TeacherAssessmentSearchedState createState() =>
      TeacherAssessmentSearchedState();
}

class TeacherAssessmentSearchedState extends State<TeacherAssessmentSearched> {
  bool agree = false;
  List<GetAssessmentModel> assessments=[];
  List<GetAssessmentModel> allAssessment =[];
  bool loading=true;
  ScrollController scrollController =ScrollController();
  int pageLimit =1;
  String searchValue='';

  @override
  void initState() {
    super.initState();
  }

  getData(String searchVal)async{
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color:
                Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    pageLimit=1;
    ResponseEntity response =await QnaService.getSearchAssessment(1,pageLimit,searchVal);
    print(response.code);
    print(response.data);
    allAssessment=List<GetAssessmentModel>.from(response.data.map((x) => GetAssessmentModel.fromJson(x)));
    Navigator.of(context).pop();
    setState(() {
      searchValue=searchVal;
      assessments.addAll(allAssessment);
      loading = false;
      pageLimit++;
    });
  }

  loadMore(String searchValue)async{
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
                color:
                Color.fromRGBO(48, 145, 139, 1),
              ));
        });
    ResponseEntity response =await QnaService.getSearchAssessment(1,pageLimit,searchValue);
    allAssessment=List<GetAssessmentModel>.from(response.data.map((x) => GetAssessmentModel.fromJson(x)));
    Navigator.of(context).pop();
    setState(() {
      assessments.addAll(allAssessment);
      loading = false;
      pageLimit++;
    });
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController teacherQuestionBankSearchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      endDrawer: EndDrawerMenuTeacher(setLocale: widget.setLocale),
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
        title:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "ASSESSMENTS",
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontSize: height * 0.0225,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "SEARCH RESULTS",
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
                  "Search",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //SizedBox(height: height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Library of Assessments",
                      style: TextStyle(
                        color: const Color.fromRGBO(153, 153, 153, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          activeColor: const Color.fromRGBO(82, 165, 160, 1),
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Color.fromRGBO(
                                  82, 165, 160, 1); // Disabled color
                            }
                            return const Color.fromRGBO(
                                82, 165, 160, 1); // Regular color
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
                        Text(
                          'Only My Assessments',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: height * 0.015),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  controller: teacherQuestionBankSearchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 0.3),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.016),
                    hintText: "Maths, 10th, 2022, CBSE, Science",
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
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: TeacherAssessmentSearched(
                                      setLocale: widget.setLocale),
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
                  onSubmitted: (value) {

                    getData(value);

                  },
                ),
                SizedBox(height: height * 0.04),
                Text(
                  "Search Results",
                  style: TextStyle(
                    color: const Color.fromRGBO(82, 165, 160, 1),
                    fontSize: height * 0.02,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Tap to See Details/Clone",
                  style: TextStyle(
                    color: const Color.fromRGBO(153, 153, 153, 1),
                    fontSize: height * 0.015,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.5,
                  child: ListView.builder(
                    itemCount: assessments.length,
                    itemBuilder: (context,index) =>
                        Column(
                          children: [
                            CardInfo(
                              height: height,
                              width: width,
                              status: 'Active',
                              setLocale: widget.setLocale,
                              assessment: assessments[index],),
                            SizedBox(
                              height: height * 0.02,
                            ),
                          ],
                        ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: (){

                    loadMore(searchValue);

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Load More",
                        style: TextStyle(
                          color: const Color.fromRGBO(82, 165, 160, 1),
                          fontSize: height * 0.0175,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.expand_more_outlined,
                        color: Color.fromRGBO(82, 165, 160, 1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            )),
      ),
    );
  }
}



class CardInfo extends StatelessWidget {
  const CardInfo(
      {Key? key,
        required this.height,
        required this.width,
        required this.status,
        required this.setLocale,
        required this.assessment})
      : super(key: key);

  final double height;
  final double width;
  final String status;
  final void Function(Locale locale) setLocale;
  final GetAssessmentModel assessment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          Provider.of<EditAssessmentProvider>(context, listen: false).updateAssessment(assessment);
          print(assessment.toString());
          if (assessment.assessmentStatus == 'inprogress') {
            CreateAssessmentModel editAssessment =CreateAssessmentModel(questions: [],removeQuestions: []);
            editAssessment.assessmentId=assessment.assessmentId;
            editAssessment.assessmentType=assessment.assessmentType;
            editAssessment.assessmentStatus=assessment.assessmentStatus;
            editAssessment.subject=assessment.subject;
            editAssessment.createAssessmentModelClass=assessment.getAssessmentModelClass;
            assessment.topic==null?0:editAssessment.topic=assessment.topic;
            assessment.subTopic==null?0:editAssessment.subTopic=assessment.subTopic;
            assessment.totalScore==null?0:editAssessment.totalScore=assessment.totalScore;
            assessment.questions!.isEmpty?0:editAssessment.totalQuestions=assessment.questions!.length;
            assessment.assessmentDuration==null?'':editAssessment.totalScore=assessment.totalScore;
            if(assessment.questions!.isEmpty){

            }
            else{
              for(int i =0;i<assessment.questions!.length;i++){
                Question question=Question();
                question.questionMarks=assessment.questions![i].questionMark;
                question.questionId=assessment.questions![i].questionId;
                editAssessment.questions?.add(question);
                Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
              }
            }

            Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(editAssessment);
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherRecentAssessment(setLocale: setLocale,finalAssessment: editAssessment,),
              ),
            );
          }
          else if (assessment.assessmentStatus == 'active') {
            SharedPreferences loginData = await SharedPreferences.getInstance();
            CreateAssessmentModel editAssessment =CreateAssessmentModel(questions: [],removeQuestions: [],addQuestion: []);
            editAssessment.userId=loginData.getInt('userId');
            editAssessment.subject=assessment.subject;
            editAssessment.assessmentType=assessment.assessmentType??'Not Mentioned';
            editAssessment.createAssessmentModelClass=assessment.getAssessmentModelClass;
            assessment.topic==null?0:editAssessment.topic=assessment.topic;
            assessment.subTopic==null?0:editAssessment.subTopic=assessment.subTopic;
            assessment.totalScore==null?0:editAssessment.totalScore=assessment.totalScore;
            assessment.questions!.isEmpty?0:editAssessment.totalQuestions=assessment.questions!.length;
            assessment.assessmentDuration==null?'':editAssessment.totalScore=assessment.totalScore;
            if(assessment.questions!.isEmpty){

            }
            else{
              for(int i =0;i<assessment.questions!.length;i++){
                Questions.Question question=Questions.Question();
                question=assessment.questions![i];
                editAssessment.addQuestion?.add(question);
                Provider.of<QuestionPrepareProviderFinal>(context, listen: false).addQuestion(assessment.questions![i]);
              }
            }

            Provider.of<CreateAssessmentProvider>(context, listen: false).updateAssessment(editAssessment);
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherActiveAssessment(setLocale: setLocale,assessment: assessment,),
              ),
            );
          } else {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TeacherInactiveAssessment(setLocale: setLocale),
              ),
            );
          }
        },
        child: Container(
          height: height * 0.1087,
          width: width * 0.888,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: const Color.fromRGBO(82, 165, 160, 0.15),
            ),
            color: const Color.fromRGBO(82, 165, 160, 0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          assessment.subject!,
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " | ${assessment.getAssessmentModelClass}",
                          style: TextStyle(
                            color: const Color.fromRGBO(28, 78, 80, 1),
                            fontSize: height * 0.0175,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.circle_rounded,
                      color: assessment.assessmentStatus == 'inprogress'
                          ? const Color.fromRGBO(255, 166, 0, 1)
                          : assessment.assessmentStatus == 'active'
                          ? const Color.fromRGBO(60, 176, 0, 1)
                          : const Color.fromRGBO(136, 136, 136, 1),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.assessment_id_caps,
                      //"Assessment ID: ",
                      style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      " ${assessment.assessmentId}",
                      style: TextStyle(
                        color: const Color.fromRGBO(82, 165, 160, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: width * 0.02, right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.institute_test_id,
                          // "Institute Test ID: ",
                          style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          " ABC903857928",
                          style: TextStyle(
                            color: const Color.fromRGBO(82, 165, 160, 1),
                            fontSize: height * 0.015,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "10/1/2023",
                      style: TextStyle(
                        color: const Color.fromRGBO(28, 78, 80, 1),
                        fontSize: height * 0.015,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
