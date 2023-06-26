import 'package:flutter/material.dart';
import '../EntityModel/user_data_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../DataSource/http_url.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/custom_incorrect_popup.dart';

class TeacherUserProfile extends StatefulWidget {
  TeacherUserProfile({Key? key, required this.userDataModel}) : super(key: key);
  UserDataModel userDataModel = UserDataModel(code: 0, message: '');

  @override
  TeacherUserProfileState createState() => TeacherUserProfileState();
}

class TeacherUserProfileState extends State<TeacherUserProfile> {
  DateTime date = DateTime.now();
  // final DateFormat formatter = DateFormat('dd/MM/yyyy');
  late String formatted = '';


  @override
  void initState() {
    super.initState();
    // date = DateTime.fromMicrosecondsSinceEpoch(widget.userDataModel.data!.dob);
    // formatted = formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          size: 40,
                          color: const Color.fromRGBO(28, 78, 80, 1),
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
                              "User Profile",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                    ),
                    body: Column(
                      children: [
                        Container(
                          height: height * 0.15,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: width * 0.025),
                                  CircleAvatar(
                                    radius: MediaQuery.of(context).size.width * 0.1,
                                    backgroundColor:
                                    const Color.fromRGBO(0, 106, 100, 0),
                                    child: Image.asset(
                                      "assets/images/ProfilePic_Avatar.png",
                                    ),
                                  ),
                                  SizedBox(width: width * 0.04),
                                  Text(
                                    '${widget.userDataModel.data?.firstName}',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                      fontSize: height * 0.03,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: width * 0.25),
                                  Text(
                                    AppLocalizations.of(context)!.teacher,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.001, right: width * 0.3),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  widget.userDataModel.data?.gender == "male"
                                      ? "Male"
                                      : "Female",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Country Citizen',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.countryNationality}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Country Resident',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.countryResident}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Email ID',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.email}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Registration ID',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.rollNumber}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Institution Name',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.organisationName}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Enabled as Student',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Text(
                                  widget.userDataModel.data!.role
                                      .contains("student")
                                      ? "Yes"
                                      : "No",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                ),
                              ]),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                            minimumSize: const Size(172, 38),
                            side: const BorderSide(
                                width: 1, // the thickness
                                color: Color.fromRGBO(
                                    82, 165, 160, 1) // the color of the border
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          child: Text('Edit Profile',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: height * 0.03,
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w500)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CustomDialog(
                                  title: 'Alert',
                                  content: "Feature under development",
                                  button: AppLocalizations.of(context)!.ok_caps,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    )));
      }
          else if(constraints.maxWidth > 960){
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          size: height * 0.06,
                          color: const Color.fromRGBO(28, 78, 80, 1),
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
                              "User Profile",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                    ),
                    body: Container(
                        padding: EdgeInsets.only(
                            left: height * 0.5, right: height * 0.5),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.1,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: width * 0.015),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor:
                                        const Color.fromRGBO(0, 106, 100, 0),
                                        child: Image.asset(
                                          "assets/images/ProfilePic_Avatar.png",
                                        ),
                                      ),
                                      SizedBox(width: width * 0.04),
                                      Text(
                                        '${widget.userDataModel.data?.firstName}',
                                        style: TextStyle(
                                          color:
                                          const Color.fromRGBO(28, 78, 80, 1),
                                          fontSize: height * 0.03,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: width * 0.08),
                                      Text(
                                        AppLocalizations.of(context)!.teacher,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              153, 153, 153, 1),
                                          fontSize: height * 0.02,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.001, right: width * 0.3),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      widget.userDataModel.data?.gender == "male"
                                          ? "Male"
                                          : "Female",
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      'Country Citizen',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      '${widget.userDataModel.data?.countryNationality}',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      'Country Resident',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      '${widget.userDataModel.data?.countryResident}',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      'Email ID',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      '${widget.userDataModel.data?.email}',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      'Registration ID',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      '${widget.userDataModel.data?.rollNumber}',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      'Institution Name',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      '${widget.userDataModel.data?.organisationName}',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      'Enabled as Student',
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.015,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Text(
                                      widget.userDataModel.data!.role
                                          .contains("student")
                                          ? "Yes"
                                          : "No",
                                      style: TextStyle(
                                        color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                        fontSize: height * 0.02,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                  ]),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
                                minimumSize: const Size(172, 38),
                                side: const BorderSide(
                                    width: 1, // the thickness
                                    color: Color.fromRGBO(
                                        82, 165, 160, 1) // the color of the border
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(39),
                                ),
                              ),
                              child: Text('Edit Profile',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: height * 0.03,
                                      color: const Color.fromRGBO(82, 165, 160, 1),
                                      fontWeight: FontWeight.w500)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CustomDialog(
                                      title: 'Alert',
                                      content: "Feature under development",
                                      button: AppLocalizations.of(context)!.ok_caps,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ))));
          }
      else {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                          color: const Color.fromRGBO(28, 78, 80, 1),
                          size: height * 0.05),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          size: height * 0.06,
                          color: const Color.fromRGBO(28, 78, 80, 1),
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
                              "User Profile",
                              style: TextStyle(
                                color: const Color.fromRGBO(28, 78, 80, 1),
                                fontSize: height * 0.025,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                    ),
                    body: Column(
                      children: [
                        Container(
                          height: height * 0.14,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: width * 0.025),
                                  CircleAvatar(
                                    radius: MediaQuery.of(context).size.width * 0.1,
                                    backgroundColor:
                                    const Color.fromRGBO(0, 106, 100, 0),
                                    child: Image.asset(
                                      "assets/images/ProfilePic_Avatar.png",
                                    ),
                                  ),
                                  SizedBox(width: width * 0.04),
                                  Text(
                                    '${widget.userDataModel.data?.firstName}',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(28, 78, 80, 1),
                                      fontSize: height * 0.03,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: width * 0.25),
                                  Text(
                                    AppLocalizations.of(context)!.teacher,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: height * 0.02,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.001, right: width * 0.3),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  widget.userDataModel.data?.gender == "male"
                                      ? "Male"
                                      : "Female",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Country Citizen',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.countryNationality}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Country Resident',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.countryResident}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Email ID',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.email}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Registration ID',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.rollNumber}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Institution Name',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${widget.userDataModel.data?.organisationName}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  'Enabled as Student',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.015,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Text(
                                  widget.userDataModel.data!.role
                                      .contains("student")
                                      ? "Yes"
                                      : "No",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(102, 102, 102, 1),
                                    fontSize: height * 0.02,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                ),
                              ]),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                            minimumSize: const Size(172, 38),
                            side: const BorderSide(
                                width: 1, // the thickness
                                color: Color.fromRGBO(
                                    82, 165, 160, 1) // the color of the border
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          child: Text('Edit Profile',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: height * 0.03,
                                  color: const Color.fromRGBO(82, 165, 160, 1),
                                  fontWeight: FontWeight.w500)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CustomDialog(
                                  title: 'Alert',
                                  content: "Feature under development",
                                  button: AppLocalizations.of(context)!.ok_caps,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    )));
      }
        }
    );}}
