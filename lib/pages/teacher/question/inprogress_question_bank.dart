import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/DataSource/design.dart';
import 'package:qna_test/Entity/Teacher/response_entity.dart';
import '../../../Components/end_drawer_menu_teacher.dart';
import '../../../Entity/Teacher/question_entity.dart';
import '../../../Entity/user_details.dart';
import '../../../Providers/LanguageChangeProvider.dart';
import '../../../Providers/question_prepare_provider_final.dart';
import '../../../Services/qna_service.dart';
import '../../../EntityModel/create_question_model.dart' as create_question_model;
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class InprogressQuestionBank extends StatefulWidget {
  InprogressQuestionBank({
    Key? key,
  }) : super(key: key);

  bool assessment = false;




  @override
  InprogressQuestionBankState createState() =>
      InprogressQuestionBankState();
}

class InprogressQuestionBankState extends State<InprogressQuestionBank> {
  List<Question> finalQuesList = [];
  UserDetails userDetails=UserDetails();
  final formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  // showAlertDialog(BuildContext context, double height) {
  //   // set up the buttons
  //   Widget cancelButton = ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Colors.white,
  //       textStyle: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(48, 145, 139, 1),
  //           fontWeight: FontWeight.w500),
  //     ),
  //     child: Text(
  //       AppLocalizations.of(context)!.no,
  //       //'No',
  //       style: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(48, 145, 139, 1),
  //           fontWeight: FontWeight.w500),
  //     ),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );
  //   Widget continueButton = ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
  //       textStyle: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(48, 145, 139, 1),
  //           fontWeight: FontWeight.w500),
  //     ),
  //     child: Text(
  //       AppLocalizations.of(context)!.yes,
  //       //'Yes',
  //       style: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(250, 250, 250, 1),
  //           fontWeight: FontWeight.w500),
  //     ),
  //     onPressed: () async {
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return const Center(
  //                 child: CircularProgressIndicator(
  //                   color: Color.fromRGBO(48, 145, 139, 1),
  //                 ));
  //           });
  //
  //       create_question_model.CreateQuestionModel createQuestionModel = create_question_model.CreateQuestionModel();
  //       createQuestionModel.questions = finalQuesList;
  //       createQuestionModel.authorId = userDetails.userId;
  //       ResponseEntity statusCode =
  //       await QnaService.createQuestionTeacherService(createQuestionModel,userDetails);
  //       Navigator.of(context).pop();
  //       if (statusCode.code == 200) {
  //         Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
  //         // Navigator.pushNamed(
  //         //     context,
  //         //     '/teacherMyQuestionBank',
  //         //     arguments: widget.assessment
  //         // );
  //         //Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'),arguments: widget.assessment);
  //       }
  //     },
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(
  //       AppLocalizations.of(context)!.confirm,
  //       //'Confirm',
  //       style: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(0, 106, 100, 1),
  //           fontWeight: FontWeight.w700),
  //     ),
  //     content: Text(
  //       AppLocalizations.of(context)!.sure_to_submit_qn_bank,
  //       //'Are you sure you want to submit to My Question Bank?',
  //       style: TextStyle(
  //           fontSize: height * 0.02,
  //           fontFamily: "Inter",
  //           color: const Color.fromRGBO(51, 51, 51, 1),
  //           fontWeight: FontWeight.w400),
  //     ),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  showAlertDialog(BuildContext context, double height,double width) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: width>960 ? Size(width * 0.06, height * 0.05): (width <= 960 && width > 500) ? Size(width * 0.15, height * 0.03) : Size(width * 0.2, height * 0.05),
        shape: RoundedRectangleBorder(      borderRadius:
        BorderRadius
            .circular(
            39),),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.no,
        //'No',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
        minimumSize: width>960 ? Size(width * 0.06, height * 0.05): (width <= 960 && width > 500) ? Size(width * 0.15, height * 0.03) : Size(width * 0.2, height * 0.05),
        shape: RoundedRectangleBorder(      borderRadius:
        BorderRadius
            .circular(
            39),),
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.yes,
        //'Yes',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(250, 250, 250, 1),
            fontWeight: FontWeight.w500),
      ),
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(48, 145, 139, 1),
                  ));
            });

        create_question_model.CreateQuestionModel createQuestionModel = create_question_model.CreateQuestionModel();
        createQuestionModel.questions = finalQuesList;
        createQuestionModel.authorId = userDetails.userId;
        ResponseEntity statusCode =
        await QnaService.createQuestionTeacherService(createQuestionModel,userDetails);
        Navigator.of(context).pop();
        if (statusCode.code == 200) {
          Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'));
          // Navigator.pushNamed(
          //     context,
          //     '/teacherMyQuestionBank',
          //     arguments: widget.assessment
          // );
          //Navigator.of(context).pushNamedAndRemoveUntil('/teacherQuestionBank', ModalRoute.withName('/teacherSelectionPage'),arguments: widget.assessment);
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            AppLocalizations.of(context)!.confirm,
            //'Confirm',
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "Inter",
                color: const Color.fromRGBO(0, 106, 100, 1),
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!.sure_to_submit_qn_bank,
        //'Are you sure you want to submit to My Question Bank?',
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            continueButton,
            cancelButton,
          ],
        ),

      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  @override
  void initState() {
    super.initState();
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    finalQuesList.addAll(
        Provider.of<QuestionPrepareProviderFinal>(context, listen: false)
            .getAllQuestion);
    subjectController.text=finalQuesList[0].subject!;
    topicController.text=finalQuesList[0].topic!;
    degreeController.text=finalQuesList[0].degreeStudent!;
    semesterController.text=finalQuesList[0].semester!;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth<= 960 && constraints.maxWidth>=500) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: appBarChevronColor,size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      // leading: IconButton(
                      //   icon: Icon(
                      //     Icons.chevron_left,
                      //     size: height * 0.06,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              //AppLocalizations.of(context)!.my_qns,
                              "Add Questions",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            //top: height * 0.02,
                              left: height * 0.045,
                              right: height * 0.045,
                              bottom: height * 0.023
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height : height * 0.05,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(82, 165, 160, 0.08),
                                    border: Border.all(
                                      color: const Color.fromRGBO(28, 78, 80, 0.08),
                                    ),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(5))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.02, right: width * 0.02,top:height * 0.02),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${
                                                finalQuesList.isEmpty
                                                    ? ''
                                                    : finalQuesList[0].subject!
                                            } | ${
                                                finalQuesList.isEmpty
                                                    ? ''
                                                    : finalQuesList[0].topic!
                                            }",
                                            style: TextStyle(
                                                fontSize: height * 0.02,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(28, 78, 80, 1),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Dialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(17))),
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.vertical,
                                                        child: Container(
                                                          height: height * 0.6,
                                                          width: width * 0.88,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors.black38,
                                                                width: 1),
                                                            borderRadius:
                                                            BorderRadius.circular(17),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                left: width * 0.02,
                                                                right: width * 0.02,
                                                                top: height * 0.02,
                                                                bottom: height * 0.02),
                                                            child: Form(
                                                              key: formKey,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Text(
                                                                      // AppLocalizations.of(
                                                                      //     context)!
                                                                      //     .assessment_title,
                                                                      'Question Details',
                                                                      style: TextStyle(
                                                                          fontSize: height *
                                                                              0.02,
                                                                          fontFamily: "Inter",
                                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    thickness: 2,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                    child: Align(
                                                                      alignment:
                                                                      Alignment.centerLeft,
                                                                      child: Text(
                                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                                        "Subject",
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                                          fontSize: height * 0.02,
                                                                          fontFamily: "Inter",
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                                    child: TextField(
                                                                      controller: subjectController,
                                                                      keyboardType: TextInputType.text,
                                                                      decoration: InputDecoration(
                                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        hintStyle: TextStyle(
                                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.016),
                                                                        hintText: "Type here",
                                                                        enabledBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        focusedBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        // focusedBorder: OutlineInputBorder(
                                                                        //     borderSide: const BorderSide(
                                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                        // border: OutlineInputBorder(
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                    child: Align(
                                                                      alignment:
                                                                      Alignment.centerLeft,
                                                                      child: Text(
                                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                                        "Topic",
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                                          fontSize: height * 0.02,
                                                                          fontFamily: "Inter",
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                                    child: TextField(
                                                                      controller: topicController,
                                                                      keyboardType: TextInputType.text,
                                                                      decoration: InputDecoration(
                                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        hintStyle: TextStyle(
                                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.016),
                                                                        hintText: "Type here",
                                                                        enabledBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        focusedBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        // focusedBorder: OutlineInputBorder(
                                                                        //     borderSide: const BorderSide(
                                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                        // border: OutlineInputBorder(
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                    child: Align(
                                                                      alignment:
                                                                      Alignment.centerLeft,
                                                                      child: Text(
                                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                                        "Degree",
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                                          fontSize: height * 0.02,
                                                                          fontFamily: "Inter",
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                                    child: TextField(
                                                                      controller: degreeController,
                                                                      keyboardType: TextInputType.text,
                                                                      decoration: InputDecoration(
                                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        hintStyle: TextStyle(
                                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.016),
                                                                        hintText: "Type here",
                                                                        enabledBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        focusedBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        // focusedBorder: OutlineInputBorder(
                                                                        //     borderSide: const BorderSide(
                                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                        // border: OutlineInputBorder(
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                    child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        //AppLocalizations.of(context)!.my_qn_bank,
                                                                        "Semester (optional)",
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          color: const Color.fromRGBO(28, 78, 80, 1),
                                                                          fontSize: height * 0.02,
                                                                          fontFamily: "Inter",
                                                                          fontWeight: FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.02),
                                                                    child: TextField(
                                                                      controller: semesterController,
                                                                      keyboardType: TextInputType.text,
                                                                      decoration: InputDecoration(
                                                                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                        hintStyle: TextStyle(
                                                                            color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: height * 0.016),
                                                                        hintText: "Type here",
                                                                        enabledBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        focusedBorder: const UnderlineInputBorder(
                                                                          borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                        ),
                                                                        // focusedBorder: OutlineInputBorder(
                                                                        //     borderSide: const BorderSide(
                                                                        //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                        // border: OutlineInputBorder(
                                                                        //     borderRadius: BorderRadius.circular(15)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: height * 0.02,
                                                                  ),
                                                                  ElevatedButton(
                                                                    style:
                                                                    ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                      const Color
                                                                          .fromRGBO(
                                                                          82, 165, 160,
                                                                          1),
                                                                      minimumSize:
                                                                      const Size(280, 48),
                                                                      shape:
                                                                      RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            39),
                                                                      ),
                                                                    ),
                                                                    onPressed: () async {
                                                                      bool valid = formKey
                                                                          .currentState!
                                                                          .validate();
                                                                      if (valid) {
                                                                        for(int i =0;i<finalQuesList.length;i++){
                                                                          finalQuesList[i].subject=subjectController.text;
                                                                          finalQuesList[i].topic=topicController.text;
                                                                          finalQuesList[i].degreeStudent=degreeController.text;
                                                                          finalQuesList[i].semester=semesterController.text;
                                                                          Provider.of<QuestionPrepareProviderFinal>(context, listen: false).updateQuestionList(i,finalQuesList[i]);
                                                                          setState(() {

                                                                          });
                                                                        }
                                                                        Navigator.of(context).pop();
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      // AppLocalizations.of(
                                                                      //     context)!
                                                                      //     .save_continue,
                                                                      'Save',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          height * 0.025,
                                                                          fontFamily: "Inter",
                                                                          color: const Color
                                                                              .fromRGBO(
                                                                              255, 255,
                                                                              255, 1),
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(82, 165, 160, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.01,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Tap question to edit or delete',
                                  style: TextStyle(
                                      color: const Color.fromRGBO(102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: height * 0.016),
                                ),
                              ),
                              SizedBox(height: height * 0.01,),
                              Container(
                                height: height * 0.65,
                                width: width * 0.93,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int i = 0; i < finalQuesList.length; i++)
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap:(){
                                              Navigator.pushNamed(
                                                  context,
                                                  '/editQuestionNewFlow',arguments: i
                                              );
                                            },
                                            child: QuestionPreview(
                                              height: height,
                                              width: width,
                                              question: finalQuesList[i],
                                              quesNum: i,
                                            ),
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Showing 1 to ${finalQuesList.length} of ${finalQuesList.length}',
                                            style: TextStyle(
                                                color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.016),
                                          ),
                                          Wrap(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: height * 0.03,
                                                    width: width * 0.1,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Icon(
                                                      Icons.keyboard_double_arrow_left,
                                                      size: height * 0.015,
                                                      color: const Color.fromRGBO(28, 78, 80, 1),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                    child: Container(
                                                      height: height * 0.03,
                                                      width: width * 0.15,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(5)),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '1',
                                                          style: TextStyle(
                                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: height * 0.016),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: height * 0.03,
                                                    width: width * 0.1,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Icon(
                                                      Icons.keyboard_double_arrow_right,
                                                      size: height * 0.015,
                                                      color: const Color.fromRGBO(28, 78, 80, 1),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Padding(
                                padding: EdgeInsets.only(right:width * 0.02,left: width * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/addQuestion',
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors.white, // <-- Button color
                                          ),
                                          child: const Icon(Icons.add, color: Color.fromRGBO(82, 165, 160, 1),),
                                        ),
                                        Text(
                                          //AppLocalizations.of(context)!.subject_topic,
                                            "New Question",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.016)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showAlertDialog(context, height,width);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(82, 165, 160, 1),
                                            ),
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: const Color.fromRGBO(82, 165, 160, 1),// <-- Button color
                                          ),
                                          child: const Icon(Icons.check, color: Colors.white),
                                        ),
                                        Text(
                                          //AppLocalizations.of(context)!.subject_topic,
                                            "Submit",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                fontSize: height * 0.016)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              // ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                              //     minimumSize: const Size(280, 48),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(39),
                              //     ),
                              //   ),
                              //   //shape: StadiumBorder(),
                              //   onPressed: () {
                              //     showAlertDialog(context, height);
                              //   },
                              //   child: Text(
                              //     AppLocalizations.of(context)!.submit,
                              //     //'Submit',
                              //     style: TextStyle(
                              //         fontSize: height * 0.025,
                              //         fontFamily: "Inter",
                              //         color: const Color.fromRGBO(255, 255, 255, 1),
                              //         fontWeight: FontWeight.w600),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )));
          }
          else if(constraints.maxWidth > 960)
          {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: appBarChevronColor,size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      // leading: IconButton(
                      //   icon: Icon(
                      //     Icons.chevron_left,
                      //     size: height * 0.06,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              //AppLocalizations.of(context)!.my_qns,
                              "Add Questions",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        height: height,
                        color: Colors.white,
                        child: Align(
                          alignment:Alignment.center,
                          child: SizedBox(
                            width: width * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height : height * 0.08,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(82, 165, 160, 0.08),
                                      border: Border.all(
                                        color: const Color.fromRGBO(28, 78, 80, 0.08),
                                      ),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(5))
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.02, right: width * 0.02,top:height * 0.02),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${
                                                  finalQuesList.isEmpty
                                                      ? ''
                                                      : finalQuesList[0].subject!
                                              } | ${
                                                  finalQuesList.isEmpty
                                                      ? ''
                                                      : finalQuesList[0].topic!
                                              }",
                                              style: TextStyle(
                                                  fontSize: height * 0.02,
                                                  fontFamily: "Inter",
                                                  color:
                                                  const Color.fromRGBO(28, 78, 80, 1),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return Dialog(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(17))),
                                                        child: SingleChildScrollView(
                                                          scrollDirection: Axis.vertical,
                                                          child: Container(
                                                            height: height * 0.65,
                                                            width: width * 0.8,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors.black38,
                                                                  width: 1),
                                                              borderRadius:
                                                              BorderRadius.circular(17),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width * 0.02,
                                                                  right: width * 0.02,
                                                                  top: height * 0.02,
                                                                  bottom: height * 0.02),
                                                              child: Form(
                                                                key: formKey,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                      Alignment.centerLeft,
                                                                      child: Text(
                                                                        // AppLocalizations.of(
                                                                        //     context)!
                                                                        //     .assessment_title,
                                                                        'Question Details',
                                                                        style: TextStyle(
                                                                            fontSize: height *
                                                                                0.02,
                                                                            fontFamily: "Inter",
                                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w700),
                                                                      ),
                                                                    ),
                                                                    const Divider(
                                                                      thickness: 2,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                      child: Align(
                                                                        alignment:
                                                                        Alignment.centerLeft,
                                                                        child: Text(
                                                                          //AppLocalizations.of(context)!.my_qn_bank,
                                                                          "Subject",
                                                                          textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                                            fontSize: height * 0.02,
                                                                            fontFamily: "Inter",
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                                      child: TextField(
                                                                        controller: subjectController,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: InputDecoration(
                                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.016),
                                                                          hintText: "Type here",
                                                                          enabledBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          focusedBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          // focusedBorder: OutlineInputBorder(
                                                                          //     borderSide: const BorderSide(
                                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                          // border: OutlineInputBorder(
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                      child: Align(
                                                                        alignment:
                                                                        Alignment.centerLeft,
                                                                        child: Text(
                                                                          //AppLocalizations.of(context)!.my_qn_bank,
                                                                          "Topic",
                                                                          textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                                            fontSize: height * 0.02,
                                                                            fontFamily: "Inter",
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                                      child: TextField(
                                                                        controller: topicController,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: InputDecoration(
                                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.016),
                                                                          hintText: "Type here",
                                                                          enabledBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          focusedBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          // focusedBorder: OutlineInputBorder(
                                                                          //     borderSide: const BorderSide(
                                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                          // border: OutlineInputBorder(
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                      child: Align(
                                                                        alignment:
                                                                        Alignment.centerLeft,
                                                                        child: Text(
                                                                          //AppLocalizations.of(context)!.my_qn_bank,
                                                                          "Degree",
                                                                          textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                                            fontSize: height * 0.02,
                                                                            fontFamily: "Inter",
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                                      child: TextField(
                                                                        controller: degreeController,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: InputDecoration(
                                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.016),
                                                                          hintText: "Type here",
                                                                          enabledBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          focusedBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          // focusedBorder: OutlineInputBorder(
                                                                          //     borderSide: const BorderSide(
                                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                          // border: OutlineInputBorder(
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(
                                                                          //AppLocalizations.of(context)!.my_qn_bank,
                                                                          "Semester (optional)",
                                                                          textAlign: TextAlign.left,
                                                                          style: TextStyle(
                                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                                            fontSize: height * 0.02,
                                                                            fontFamily: "Inter",
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(left: width * 0.02),
                                                                      child: TextField(
                                                                        controller: semesterController,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: InputDecoration(
                                                                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          hintStyle: TextStyle(
                                                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: height * 0.016),
                                                                          hintText: "Type here",
                                                                          enabledBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          focusedBorder: const UnderlineInputBorder(
                                                                            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                          ),
                                                                          // focusedBorder: OutlineInputBorder(
                                                                          //     borderSide: const BorderSide(
                                                                          //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                          // border: OutlineInputBorder(
                                                                          //     borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height * 0.02,
                                                                    ),
                                                                    ElevatedButton(
                                                                      style:
                                                                      ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                        const Color
                                                                            .fromRGBO(
                                                                            82, 165, 160,
                                                                            1),
                                                                        minimumSize:
                                                                        const Size(280, 48),
                                                                        shape:
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              39),
                                                                        ),
                                                                      ),
                                                                      onPressed: () async {
                                                                        bool valid = formKey
                                                                            .currentState!
                                                                            .validate();
                                                                        if (valid) {
                                                                          for(int i =0;i<finalQuesList.length;i++){
                                                                            finalQuesList[i].subject=subjectController.text;
                                                                            finalQuesList[i].topic=topicController.text;
                                                                            finalQuesList[i].degreeStudent=degreeController.text;
                                                                            finalQuesList[i].semester=semesterController.text;
                                                                            Provider.of<QuestionPrepareProviderFinal>(context, listen: false).updateQuestionList(i,finalQuesList[i]);
                                                                            setState(() {

                                                                            });
                                                                          }
                                                                          Navigator.of(context).pop();
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        // AppLocalizations.of(
                                                                        //     context)!
                                                                        //     .save_continue,
                                                                        'Save',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            height * 0.025,
                                                                            fontFamily: "Inter",
                                                                            color: const Color
                                                                                .fromRGBO(
                                                                                255, 255,
                                                                                255, 1),
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w600),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    fontSize: height * 0.02,
                                                    fontFamily: "Inter",
                                                    color:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Tap question to edit or delete',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: height * 0.016),
                                  ),
                                ),
                                SizedBox(height: height * 0.01,),
                                Container(
                                  height: height * 0.65,
                                  width: width * 0.93,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (int i = 0; i < finalQuesList.length; i++)
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap:(){
                                                Navigator.pushNamed(
                                                    context,
                                                    '/editQuestionNewFlow',arguments: i
                                                );
                                              },
                                              child: QuestionPreview(
                                                height: height,
                                                width: width,
                                                question: finalQuesList[i],
                                                quesNum: i,
                                              ),
                                            ),
                                          ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Showing 1 to ${finalQuesList.length} of ${finalQuesList.length}',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.016),
                                            ),
                                            Wrap(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: height * 0.03,
                                                      width: width * 0.07,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(5)),
                                                      ),
                                                      child: Icon(
                                                        Icons.keyboard_double_arrow_left,
                                                        size: height * 0.015,
                                                        color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                      child: Container(
                                                        height: height * 0.03,
                                                        width: width * 0.07,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(5)),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '1',
                                                            style: TextStyle(
                                                                color: const Color.fromRGBO(28, 78, 80, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: height * 0.016),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: height * 0.03,
                                                      width: width * 0.07,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(5)),
                                                      ),
                                                      child: Icon(
                                                        Icons.keyboard_double_arrow_right,
                                                        size: height * 0.015,
                                                        color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Padding(
                                  padding: EdgeInsets.only(right:width * 0.02,left: width * 0.02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/addQuestion',
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                width: 2,
                                                color: Color.fromRGBO(82, 165, 160, 1),
                                              ),
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(20),
                                              backgroundColor: Colors.white, // <-- Button color
                                            ),
                                            child: const Icon(Icons.add, color: Color.fromRGBO(82, 165, 160, 1),),
                                          ),
                                          Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                              "New Question",
                                              //textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.016)),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              showAlertDialog(context, height,width);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                width: 2,
                                                color: Color.fromRGBO(82, 165, 160, 1),
                                              ),
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(20),
                                              backgroundColor: const Color.fromRGBO(82, 165, 160, 1),// <-- Button color
                                            ),
                                            child: const Icon(Icons.check, color: Colors.white),
                                          ),
                                          Text(
                                            //AppLocalizations.of(context)!.subject_topic,
                                              "Submit",
                                              //textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(28, 78, 80, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: height * 0.016)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                                // ElevatedButton(
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                //     minimumSize: const Size(280, 48),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(39),
                                //     ),
                                //   ),
                                //   //shape: StadiumBorder(),
                                //   onPressed: () {
                                //     showAlertDialog(context, height);
                                //   },
                                //   child: Text(
                                //     AppLocalizations.of(context)!.submit,
                                //     //'Submit',
                                //     style: TextStyle(
                                //         fontSize: height * 0.025,
                                //         fontFamily: "Inter",
                                //         color: const Color.fromRGBO(255, 255, 255, 1),
                                //         fontWeight: FontWeight.w600),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )));
          }
          else {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    endDrawer: const EndDrawerMenuTeacher(),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: appBarChevronColor,size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      // leading: IconButton(
                      //   icon: Icon(
                      //     Icons.chevron_left,
                      //     size: height * 0.06,
                      //     color: Colors.black,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      automaticallyImplyLeading: false,
                      toolbarHeight: height * 0.100,
                      centerTitle: true,
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              //AppLocalizations.of(context)!.my_qns,
                              "Add Questions",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(right:width * 0.04,left:width * 0.04,top:width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height : height * 0.05,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(82, 165, 160, 0.08),
                                  border: Border.all(
                                    color: const Color.fromRGBO(28, 78, 80, 0.08),
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.02, right: width * 0.02),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${
                                              finalQuesList.isEmpty
                                                  ? ''
                                                  : finalQuesList[0].subject!
                                          } | ${
                                              finalQuesList.isEmpty
                                                  ? ''
                                                  : finalQuesList[0].topic!
                                          }",
                                          style: TextStyle(
                                              fontSize: height * 0.02,
                                              fontFamily: "Inter",
                                              color:
                                              const Color.fromRGBO(28, 78, 80, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(17))),
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.vertical,
                                                      child: Container(
                                                        height: height * 0.6,
                                                        width: width * 0.88,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.black38,
                                                              width: 1),
                                                          borderRadius:
                                                          BorderRadius.circular(17),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: width * 0.02,
                                                              right: width * 0.02,
                                                              top: height * 0.02,
                                                              bottom: height * 0.02),
                                                          child: Form(
                                                            key: formKey,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                  Alignment.centerLeft,
                                                                  child: Text(
                                                                    // AppLocalizations.of(
                                                                    //     context)!
                                                                    //     .assessment_title,
                                                                    'Question Details',
                                                                    style: TextStyle(
                                                                        fontSize: height *
                                                                            0.02,
                                                                        fontFamily: "Inter",
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  thickness: 2,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Subject",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: subjectController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Topic",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: topicController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Degree",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: degreeController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02,top: height * 0.02),
                                                                  child: Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text(
                                                                      //AppLocalizations.of(context)!.my_qn_bank,
                                                                      "Semester (optional)",
                                                                      textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: const Color.fromRGBO(28, 78, 80, 1),
                                                                        fontSize: height * 0.02,
                                                                        fontFamily: "Inter",
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: width * 0.02),
                                                                  child: TextField(
                                                                    controller: semesterController,
                                                                    keyboardType: TextInputType.text,
                                                                    decoration: InputDecoration(
                                                                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                      hintStyle: TextStyle(
                                                                          color: const Color.fromRGBO(102, 102, 102, 0.3),
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: height * 0.016),
                                                                      hintText: "Type here",
                                                                      enabledBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      focusedBorder: const UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.3),),
                                                                      ),
                                                                      // focusedBorder: OutlineInputBorder(
                                                                      //     borderSide: const BorderSide(
                                                                      //         color: Color.fromRGBO(82, 165, 160, 1)),
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                      // border: OutlineInputBorder(
                                                                      //     borderRadius: BorderRadius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: height * 0.02,
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                                                    minimumSize: const Size(280, 48),
                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(39),),),
                                                                  onPressed: () async {
                                                                    bool valid = formKey.currentState!.validate();
                                                                    if (valid) {
                                                                      for(int i =0;i<finalQuesList.length;i++){
                                                                        finalQuesList[i].subject=subjectController.text;
                                                                        finalQuesList[i].topic=topicController.text;
                                                                        finalQuesList[i].degreeStudent=degreeController.text;
                                                                        finalQuesList[i].semester=semesterController.text;
                                                                        Provider.of<QuestionPrepareProviderFinal>(context, listen: false).updateQuestionList(i,finalQuesList[i]);
                                                                        setState(() {

                                                                        });
                                                                      }
                                                                      Navigator.of(context).pop();
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    // AppLocalizations.of(
                                                                    //     context)!
                                                                    //     .save_continue,
                                                                    'Save',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        height * 0.025,
                                                                        fontFamily: "Inter",
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            255, 255,
                                                                            255, 1),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: height * 0.025,
                                                fontFamily: "Inter",
                                                color:
                                                const Color.fromRGBO(82, 165, 160, 1),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tap question to edit or delete',
                                style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 0.3),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.016),
                              ),
                            ),
                            SizedBox(height: height * 0.01,),
                            Container(
                              height: height * 0.65,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i = 0; i < finalQuesList.length; i++)
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap:(){
                                            Navigator.pushNamed(
                                                context,
                                                '/editQuestionNewFlow',arguments: i
                                            );
                                          },
                                          child: QuestionPreview(
                                            height: height,
                                            width: width,
                                            question: finalQuesList[i],
                                            quesNum: i,
                                          ),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Showing 1 to ${finalQuesList.length} of ${finalQuesList.length}',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(102, 102, 102, 0.3),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016),
                                        ),
                                        Wrap(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: height * 0.03,
                                                  width: width * 0.1,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(5)),
                                                  ),
                                                  child: Icon(
                                                    Icons.keyboard_double_arrow_left,
                                                    size: height * 0.015,
                                                    color: const Color.fromRGBO(28, 78, 80, 1),),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: width * 0.005,left: width * 0.005),
                                                  child: Container(
                                                    height: height * 0.03,
                                                    width: width * 0.15,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(5)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '1',
                                                        style: TextStyle(
                                                            color: const Color.fromRGBO(28, 78, 80, 1),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: height * 0.016),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.03,
                                                  width: width * 0.1,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color.fromRGBO(28, 78, 80, 1),),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(5)),
                                                  ),
                                                  child: Icon(
                                                    Icons.keyboard_double_arrow_right,
                                                    size: height * 0.015,
                                                    color: const Color.fromRGBO(28, 78, 80, 1),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: EdgeInsets.only(right:width * 0.02,left: width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/addQuestion',
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(20),
                                          backgroundColor: Colors.white, // <-- Button color
                                        ),
                                        child: Icon(Icons.add,size:width * 0.04, color: const Color.fromRGBO(82, 165, 160, 1),),
                                      ),
                                      SizedBox(height: width * 0.005),
                                      Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                          "New Question",
                                          //textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          showAlertDialog(context, height,width);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(82, 165, 160, 1),
                                          ),
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(20),
                                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),// <-- Button color
                                        ),
                                        child: Icon(Icons.check,size:width * 0.04, color: Colors.white),
                                      ),
                                      SizedBox(height: width * 0.005),
                                      Text(
                                        //AppLocalizations.of(context)!.subject_topic,
                                          "Submit",
                                          //textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(28, 78, 80, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.016)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          }

        }
    );
  }
}

class QuestionPreview extends StatelessWidget {
  const QuestionPreview(
      {Key? key,
        required this.height,
        required this.width,
        required this.question,
        required this.quesNum,
      })
      : super(key: key);

  final double height;
  final int quesNum;
  final double width;
  final dynamic question;

  @override
  Widget build(BuildContext context) {
    List<String> temp = [];
    for (int i = 0; i < question.choices!.length; i++) {
      if (question.choices![i].rightChoice!) {
        temp.add(question.choices![i].choiceText!);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(153, 153, 153, 0.5),),
          borderRadius: const BorderRadius.all(
              Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${question.questionType}',
                    style: TextStyle(
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        color:
                        const Color.fromRGBO(28, 78, 80, 1),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${question.question}',
                  style: TextStyle(
                      fontSize: height * 0.0175,
                      fontFamily: "Inter",
                      color: const Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question.questionType == "MCQ" ? "Answer" : " ",
                  style: TextStyle(
                      fontSize: height * 0.02,
                      fontFamily: "Inter",
                      color:
                      const Color.fromRGBO(28, 78, 80, 1),
                      fontWeight: FontWeight.w700),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  temp.toString().substring(1, temp.toString().length - 1),
                  style: TextStyle(
                      fontSize: height * 0.0175,
                      fontFamily: "Inter",
                      color: const Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
