import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_looq_question_edit.dart';
import '../Entity/demo_question_model.dart';
import '../Entity/question_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'about_us.dart';
import 'cookie_policy.dart';
import 'package:qna_test/Pages/help_page.dart';
import 'package:qna_test/Pages/privacy_policy_hamburger.dart';
import 'package:qna_test/Pages/settings_languages.dart';
import 'package:qna_test/Pages/terms_of_services.dart';
import 'package:qna_test/pages/reset_password_teacher.dart';
class TeacherLooqClonePreview extends StatefulWidget {
  const TeacherLooqClonePreview({
    Key? key, required this.question, required this.setLocale,
  }) : super(key: key);

  final DemoQuestionModel question;
  final void Function(Locale locale) setLocale;
  @override
  TeacherLooqClonePreviewState createState() => TeacherLooqClonePreviewState();
}

class TeacherLooqClonePreviewState extends State<TeacherLooqClonePreview> {
  String? _groupValue;
  TextEditingController adviceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  IconData showIcon=Icons.expand_circle_down_outlined;
  Color textColor = const Color.fromRGBO(48, 145, 139, 1);
  List<Ques> question=getData();
  static List<Ques> getData() {
    const data=[
      {
        "id":1,
        "questionType":"choose",
        "mark":25,
        "question":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        "options":[
          "a. Option 1","b. Option 2","c. Option 3"
        ]
      },
      {
        "id":2,
        "questionType":"choose",
        "mark":5,
        "question":"What type of music are you into?",
        "options":[
          "Option 1","Option 2","Option 3"
        ]
      },
      {
        "id":3,
        "questionType":"choose",
        "mark":25,
        "question":"If you could only eat one food for the rest of your life, what would it be?",
        "options":[
          "a. Option 1", "b. Option 2", "c. Option 3","a. Option 1", "b. Option 2", "c. Option 3"
        ]
      },
      {
        "id":4,
        "questionType":"choose",
        "mark":25,
        "question":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        "options":[
          "a. Option 1","b. Option 2","c. Option 3"
        ]
      },
      {
        "id":5,
        "questionType":"choose",
        "mark":5,
        "question":"What type of music are you into?",
        "options":[
          "a. Option 1","b. Option 2","c. Option 3"
        ]
      },
      {
        "id": 6,
        "questionType":"choose",
        "mark": 25,
        "question": "If you could only eat one food for the rest of your life, what would it be?",
        "options": [
          "a. Option 1", "b. Option 2", "c. Option 3","a. Option 1", "b. Option 2", "c. Option 3"
        ]
      },{
        "id":7,
        "questionType":"choose",
        "mark":25,
        "question":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        "options":[
          "a. Option 1","b. Option 2","c. Option 3"
        ]
      },
      {
        "id":8,
        "questionType":"choose",
        "mark":5,
        "question":"What type of music are you into?",
        "options":[
          "Option 1","Option 2","Option 3"
        ]
      },
      {
        "id":9,
        "questionType":"choose",
        "mark":25,
        "question":"If you could only eat one food for the rest of your life, what would it be?",
        "options":[
          "a. Option 1", "b. Option 2", "c. Option 3","a. Option 1", "b. Option 2", "c. Option 3"
        ]
      },
      {
        "id":10,
        "questionType":"choose",
        "mark":25,
        "question":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec dolor sollicitudin, ultricies ante in, suscipit orci. Nulla pretium faucibus libero tincidunt congue. Nam dignissim imperdiet mauris, in rhoncus lectus efficitur",
        "options":[
          "a. Option 1","b. Option 2","c. Option 3"
        ]
      },
      {
        "id":11,
        "questionType":"choose",
        "mark":5,
        "question":"What type of music are you into?",
        "options":[
          "a. Option 1","b. Option 2","c. Option 3"
        ]
      },
      {
        "id": 12,
        "questionType":"choose",
        "mark": 25,
        "question": "If you could only eat one food for the rest of your life, what would it be?",
        "options": [
          "a. Option 1", "b. Option 2", "c. Option 3","a. Option 1", "b. Option 2", "c. Option 3"
        ]
      }
    ];
    return data.map<Ques>(Ques.fromJson).toList();
  }
  List<dynamic> selected=[];
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  @override
  void initState() {
    super.initState();
    adviceController.text=widget.question.advice!;
    urlController.text=widget.question.url!;
  }

  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient:  LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 106, 100, 1),
                        Color.fromRGBO(82, 165, 160, 1),
                      ],
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.050),
                    Container(
                      alignment: Alignment.center,
                      height: height / 6,
                      child:
                      Row(
                          children:  [
                            CircleAvatar(
                              backgroundColor: const Color.fromRGBO(0,106,100,0),
                              radius: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.15,
                              child: Image.asset(
                                "assets/images/ProfilePic_Avatar.png",
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              "Teacher Name",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge
                                  ?.merge(const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.02,
                                  fontSize: 16)),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 0.022),
                    Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: width * 0.09),
                            child: Text(
                              AppLocalizations.of(context)!.teacher,
                              style: const TextStyle(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.02,
                                  fontSize: 12),
                            )
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: width * 0.09),
                            child: const Text(
                              "teacher@gmail.com",
                              style: TextStyle(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.02,
                                  fontSize: 12),
                            )
                        ),
                      ],
                    ),
                    //    )
                  ],
                ),
              ),
              Flexible(
                child:
                ListView(
                  children: [
                    ListTile(
                        leading:
                        const Icon(
                            Icons.people_alt,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.user_profile,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.rightToLeft,
                          //     child: TeacherUserProfile(userDataModel: userDataModel,),
                          //   ),
                          // );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.key_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)
                        ),
                        title: Text(AppLocalizations.of(context)!.change_password,
                          style: TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const ResetPassword(),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.mail_outline_sharp,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.change_emailId,
                          style: TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.rightToLeft,
                          //     child:  ChangeEmailTeacher(userId: userDataModel.data!.id),
                          //   ),
                          // );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.translate,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.language,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SettingsLanguages(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.privacy_and_terms,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: PrivacyPolicyHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.verified_user_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text('Terms of Services',style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: TermsOfServiceHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.note_alt_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.cookie_policy,style: TextStyle(
                            color: textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CookiePolicy(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.perm_contact_calendar_outlined,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.about_us,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: AboutUs(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.help_outline,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.help,style: TextStyle(
                            color: textColor,
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: HelpPageHamburger(setLocale: widget.setLocale),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                        leading:
                        const Icon(
                            Icons.power_settings_new,
                            color: Color.fromRGBO(141, 167, 167, 1)),
                        title: Text(AppLocalizations.of(context)!.logout,style: const TextStyle(
                            color: Color.fromRGBO(226, 68, 0, 1),
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),),
                        onTap: () async {
                        }),
                    SizedBox(height: height * 0.03),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Version : 1.0.0",
                        style: TextStyle(
                            color: Color.fromRGBO(180, 180, 180, 1),
                            //Color.fromRGBO(48, 145, 139, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                  "PREPARE QUESTION",
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
        body: Center(
          child: SizedBox(
            height: height * 0.81,
            width: width * 0.888,
            child:
            Card(
                elevation: 12,
                color: const Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.only(left: width * 0.030,right: width * 0.030,bottom: height* 0.015,top: height* 0.025),
                //padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: height * 0.06,
                      color: Color.fromRGBO(82, 165, 160, 0.1),
                      child: Padding(
                        padding:  EdgeInsets.only(right: width * 0.02,left: width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.question.subject,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(28, 78, 80, 1),
                                    fontSize: height * 0.0175,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '  |  ${widget.question.topic}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.question.studentClass,
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: width * 0.03,right: width *0.03),
                      child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Divider(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  thickness: 2,
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10,left: 10),
                              child: Text('${widget.question.questionType}',
                                  style: TextStyle(
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: height* 0.02)),
                            ),
                            Expanded(
                                child: Divider(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  thickness: 2,
                                )
                            ),
                          ]
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: width * 0.03,top: height * 0.02),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${widget.question.question}',
                            style: TextStyle(
                                color: const Color.fromRGBO(51, 51, 51, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: height* 0.015)),
                      ),
                    ),
                    SizedBox(height: height * 0.03,),
                    ChooseWidget(question: widget.question, selected: selected, height: height, width: width),
                    SizedBox(height: height * 0.03,),
                    Padding(
                      padding:  EdgeInsets.only(left: width * 0.03),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Advisor",
                            style: TextStyle(
                                color: const Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: height* 0.02)),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: width * 0.03,right: width * 0.03),
                      child: TextFormField(
                        controller: adviceController,
                        enabled: false,
                        decoration:  InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Suggest what to study if answered incorrectly ',
                            labelStyle: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 0.25),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: height* 0.015)
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03,),
                    Padding(
                      padding:  EdgeInsets.only(left: width * 0.03,right: width * 0.03),
                      child: TextFormField(
                        controller: urlController,
                        enabled: false,
                        decoration:  InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'URL - Any reference (Optional)',
                            labelStyle: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 0.25),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: height* 0.015)
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: const Size(280, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                      //shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: LooqQuestionEdit(question: widget.question,setLocale: widget.setLocale),
                          ),
                        );
                      },
                      child: Text(
                        'Clone',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(82, 165, 160, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: height * 0.03,),
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
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     child:  const TeacherAddMyQuestionBank(),
                        //   ),
                        // );
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontSize: height * 0.025,
                            fontFamily: "Inter",
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
            ),

          ),
        )

    );
  }

  changeIcon(IconData pramIcon){
    if(pramIcon==Icons.expand_circle_down_outlined){
      setState(() {
        showIcon=Icons.arrow_circle_up_outlined;
      });
    }
    else{
      setState(() {
        showIcon=Icons.expand_circle_down_outlined;
      });
    }
  }
}

class ChooseWidget extends StatefulWidget {
  const ChooseWidget({
    Key? key,
    required this.question,
    required this.height,
    required this.width,
    required this.selected,
  }) : super(key: key);

  final DemoQuestionModel question;
  final List<dynamic> selected;
  final double height;
  final double width;

  @override
  State<ChooseWidget> createState() => _ChooseWidgetState();
}

class _ChooseWidgetState extends State<ChooseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int j=1; j<=widget.question.choices!.length; j++)
          GestureDetector(
            onTap: (){
              // setState(() {
              // print("dsfsdf");
              // print(widget.selected);
              // if(widget.selected.contains(j)){
              //   widget.selected.remove(j);
              //   print("remove");
              //   print(widget.selected);
              // }
              // else{
              //   widget.selected.add(j);
              //   print("add");
              //   print(widget.selected);
              // }
              // });
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.height * 0.013),
              child: Container(
                  width: widget.width * 0.744,
                  height: widget.height * 0.0412,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: const Color.fromRGBO(209, 209, 209, 1)
                    ),
                    color: (widget.question.correctChoice!.contains(j)) ? const Color.fromRGBO(82, 165, 160, 1) :const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: widget.width * 0.02,),
                        Expanded(
                          child: Text('${widget.question.choices![j-1]}',
                            style: TextStyle(
                              color: (widget.question.correctChoice!.contains(j)) ? const Color.fromRGBO(255, 255, 255, 1) :const Color.fromRGBO(102, 102, 102, 1),
                              fontSize: widget.height * 0.0162,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ])
              ),
            ),
          )


      ],
    );
  }
}
