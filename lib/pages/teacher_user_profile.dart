import 'package:flutter/material.dart';
import '../EntityModel/user_data_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
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
      if (constraints.maxWidth > 500) {
        return Center(
            child: SizedBox(
            width: 400,
            child:  WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    constraints.maxWidth > 700
                        ?
                    Container(
                      height: height * 0.3,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(82, 165, 160, 1),
                                Color.fromRGBO(0, 106, 100, 1),
                              ])),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Container(
                                width: width * 0.4,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    AppLocalizations.of(context)!.user_profile,
                                    //'USER PROFILE',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            children: [
                              SizedBox(width: width * 0.025),
                              Icon(
                                Icons.account_circle_outlined,
                                size: width * 0.06,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              SizedBox(width: width * 0.010),
                              Column(
                                children: [
                                  SizedBox(width: width * 0.02),
                                  Text(
                                    '${widget.userDataModel.data?.firstName}',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.03,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Text(
                                    AppLocalizations.of(context)!.teacher,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.03,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.002,
                          ),
                        ],
                      ),
                    )

                        : Container(
                      height: height * 0.25,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(82, 165, 160, 1),
                                Color.fromRGBO(0, 106, 100, 1),
                              ])),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Container(
                                width: width * 0.4,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    AppLocalizations.of(context)!.user_profile,
                                    //'USER PROFILE',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            children: [
                              SizedBox(width: width * 0.025),
                              Icon(
                                Icons.account_circle_outlined,
                                size: width * 0.15,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              SizedBox(width: width * 0.04),
                              Text(
                                '${widget.userDataModel.data?.firstName}',
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: height * 0.03,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.002,
                          ),
                          Row(
                            children: [
                              SizedBox(width: width * 0.2),
                              Text(
                                AppLocalizations.of(context)!.teacher,
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: height * 0.025,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: width * 0.001, right: width * 0.3),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: height * 0.03),
                            // Text(
                            //   AppLocalizations.of(context)!.dob_small,
                            //   //'Date of Birth',
                            //   style: TextStyle(
                            //     color: const Color.fromRGBO(102, 102, 102, 1),
                            //     fontSize: height * 0.015,
                            //     fontFamily: "Inter",
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: height * 0.01,
                            // ),
                            // Text(
                            //   formatted,
                            //   style: TextStyle(
                            //     color: const Color.fromRGBO(48, 145, 139, 1),
                            //     fontSize: height * 0.02,
                            //     fontFamily: "Inter",
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.gender,
                              //'Gender',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              widget.userDataModel.data?.gender == "male"
                                  ?
                              AppLocalizations.of(context)!.male
                              //"Male"
                                  :
                              AppLocalizations.of(context)!.female,
                              //"Female",
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!
                                  .country_citizen_small,
                              //'Country Citizen',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data
                                  ?.countryNationality}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!
                                  .country_resident_small,
                              // 'Country Resident',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.countryResident}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.email_id,
                              // 'Email ID',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.email}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.also_teacher,
                              //'Registered as Student also',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              widget.userDataModel.data!.role.contains(
                                  "student")
                                  ? AppLocalizations.of(context)!.yes
                              //"Yes"
                                  : AppLocalizations.of(context)!.no,
                              //"No",
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.reg_id_small,
                              //'RegistrationID / Roll Number',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.rollNumber}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.ins_org,
                              //'Institute / Organization Name',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.organisationName}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                            ),
                            // Align(
                            //   alignment: Alignment.bottomCenter,
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor:
                            //           const Color.fromRGBO(82, 165, 160, 1),
                            //       minimumSize: const Size(280, 48),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(39),
                            //       ),
                            //     ),
                            //     child: Text('Edit Profile',
                            //         style: TextStyle(
                            //             fontFamily: 'Inter',
                            //             fontSize: height * 0.03,
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.w600)),
                            //     onPressed: () {},
                            //   ),
                            // )
                          ]),
                    ),
                  ],
                )))));
      }
      else {
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    constraints.maxWidth > 700
                        ?
                    Container(
                      height: height * 0.3,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(82, 165, 160, 1),
                                Color.fromRGBO(0, 106, 100, 1),
                              ])),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Container(
                                width: width * 0.4,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    AppLocalizations.of(context)!.user_profile,
                                    //'USER PROFILE',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            children: [
                              SizedBox(width: width * 0.025),
                              Icon(
                                Icons.account_circle_outlined,
                                size: width * 0.06,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              SizedBox(width: width * 0.010),
                              Column(
                                children: [
                                  SizedBox(width: width * 0.02),
                                  Text(
                                    '${widget.userDataModel.data?.firstName}',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.03,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Text(
                                    AppLocalizations.of(context)!.teacher,
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.03,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.002,
                          ),
                        ],
                      ),
                    )

                        : Container(
                      height: height * 0.25,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(82, 165, 160, 1),
                                Color.fromRGBO(0, 106, 100, 1),
                              ])),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Container(
                                width: width * 0.4,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    AppLocalizations.of(context)!.user_profile,
                                    //'USER PROFILE',
                                    style: TextStyle(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: height * 0.025,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            children: [
                              SizedBox(width: width * 0.025),
                              Icon(
                                Icons.account_circle_outlined,
                                size: width * 0.15,
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              SizedBox(width: width * 0.04),
                              Text(
                                '${widget.userDataModel.data?.firstName}',
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: height * 0.03,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.002,
                          ),
                          Row(
                            children: [
                              SizedBox(width: width * 0.2),
                              Text(
                                AppLocalizations.of(context)!.teacher,
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: height * 0.025,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: width * 0.001, right: width * 0.3),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: height * 0.03),
                            // Text(
                            //   AppLocalizations.of(context)!.dob_small,
                            //   //'Date of Birth',
                            //   style: TextStyle(
                            //     color: const Color.fromRGBO(102, 102, 102, 1),
                            //     fontSize: height * 0.015,
                            //     fontFamily: "Inter",
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: height * 0.01,
                            // ),
                            // Text(
                            //   formatted,
                            //   style: TextStyle(
                            //     color: const Color.fromRGBO(48, 145, 139, 1),
                            //     fontSize: height * 0.02,
                            //     fontFamily: "Inter",
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.gender,
                              //'Gender',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              widget.userDataModel.data?.gender == "male"
                                  ?
                              AppLocalizations.of(context)!.male
                              //"Male"
                                  :
                              AppLocalizations.of(context)!.female,
                              //"Female",
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!
                                  .country_citizen_small,
                              //'Country Citizen',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data
                                  ?.countryNationality}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!
                                  .country_resident_small,
                              // 'Country Resident',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.countryResident}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.email_id,
                              // 'Email ID',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.email}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.also_teacher,
                              //'Registered as Student also',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              widget.userDataModel.data!.role.contains(
                                  "student")
                                  ? AppLocalizations.of(context)!.yes
                              //"Yes"
                                  : AppLocalizations.of(context)!.no,
                              //"No",
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.reg_id_small,
                              //'RegistrationID / Roll Number',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.rollNumber}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              AppLocalizations.of(context)!.ins_org,
                              //'Institute / Organization Name',
                              style: TextStyle(
                                color: const Color.fromRGBO(102, 102, 102, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${widget.userDataModel.data?.organisationName}',
                              style: TextStyle(
                                color: const Color.fromRGBO(48, 145, 139, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                            ),
                            // Align(
                            //   alignment: Alignment.bottomCenter,
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor:
                            //           const Color.fromRGBO(82, 165, 160, 1),
                            //       minimumSize: const Size(280, 48),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(39),
                            //       ),
                            //     ),
                            //     child: Text('Edit Profile',
                            //         style: TextStyle(
                            //             fontFamily: 'Inter',
                            //             fontSize: height * 0.03,
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.w600)),
                            //     onPressed: () {},
                            //   ),
                            // )
                          ]),
                    ),
                  ],
                )));
      }
        }
    );}}
