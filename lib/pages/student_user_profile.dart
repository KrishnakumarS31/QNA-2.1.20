import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../EntityModel/user_data_model.dart';
class StudentUserProfile extends StatefulWidget {
   StudentUserProfile({
    Key? key,required this.userDataModel
  }) : super(key: key);
  UserDataModel userDataModel=UserDataModel(code: 0, message: '');


  @override
  StudentUserProfileState createState() => StudentUserProfileState();
}

class StudentUserProfileState extends State<StudentUserProfile> {
DateTime date=DateTime.now();
final DateFormat formatter = DateFormat('dd/MM/yyyy');
late String formatted='';
//= formatter.format(pickedDate!);

  @override
  void initState() {
    super.initState();
    date=DateTime.fromMicrosecondsSinceEpoch(widget.userDataModel.data!.dob);
    formatted=formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
    //     appBar:
    //     AppBar(
    //       centerTitle: true,
    //       toolbarHeight: height * 0.2,
    //       title: Column(
    //     children: [
    //       Column(
    //         children :  [
    //           SizedBox(height: height * 0.03),
    //        Text("USER PROFILE",
    //       style: TextStyle(
    //         color: Color.fromRGBO(255, 255, 255, 1),
    //         fontSize: 18.0,
    //         fontFamily: "Inter",
    //         fontWeight: FontWeight.w600,
    //       ),),
    //      ],
    //       ),
    //      SizedBox(height: height * 0.01),
    //       Align(
    //         alignment: Alignment.topLeft,
    //           //padding: EdgeInsets.only(right: 150),
    //       child: Row(
    //         // mainAxisAlignment: MainAxisAlignment.start,
    //         // crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           // Padding(
    //           //     padding: EdgeInsets.only(right: width * 0.1),
    //           //     child:
    //           //     Row(
    //                 //children: [
    //                   Icon(Icons.account_circle_outlined,size: height * 0.08,),
    //
    //           Text("${widget.userDataModel.data?.firstName} ${widget.userDataModel.data?.lastName}",
    //             style: const TextStyle(
    //               color: Color.fromRGBO(255, 255, 255, 1),
    //               fontSize: 18.0,
    //               fontFamily: "Inter",
    //               fontWeight: FontWeight.w600,
    //             ),),
    //                       ])),
    //
    //               //   ],
    //               // )),
    //           SizedBox(width: width * 0.02,),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Text("${widget.userDataModel.data?.firstName}",
    //                 style: const TextStyle(
    //                   color: Color.fromRGBO(255, 255, 255, 1),
    //                   fontSize: 18.0,
    //                   fontFamily: "Inter",
    //                   fontWeight: FontWeight.w600,
    //                 ),),
    //
    //               Text("${widget.userDataModel.data?.lastName}",
    //                 style: const TextStyle(
    //                   color: Color.fromRGBO(255, 255, 255, 1),
    //                   fontSize: 18.0,
    //                   fontFamily: "Inter",
    //                   fontWeight: FontWeight.w600,
    //                 ),),
    //
    //               Text("${widget.userDataModel.data?.role}",
    //                 style: const TextStyle(
    //                   color: Color.fromRGBO(255, 255, 255, 1),
    //                   fontSize: 18.0,
    //                   fontFamily: "Inter",
    //                   fontWeight: FontWeight.w400,
    //                 ),),
    //             ],
    //           ),
    // ],
    //     ),
    //       leading:
    //         Align(
    //           alignment: Alignment.topLeft,
    //           child: Row(
    //            mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               IconButton(
    //                 icon:const Icon(
    //                   Icons.chevron_left,
    //                   size: 40.0,
    //                   color: Colors.white,
    //                 ), onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //       flexibleSpace: Container(
    //         decoration: const BoxDecoration(
    //             gradient: LinearGradient(
    //                 end: Alignment.topCenter,
    //                 begin: Alignment.bottomCenter,
    //                 colors: [Color.fromRGBO(82, 165, 160, 1),Color.fromRGBO(0, 106, 100, 1),])
    //         ),
    //
    //       ),
    //     ),
        body: Column(
          children: [
            Container(
              height: height * 0.2,
              decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [Color.fromRGBO(82, 165, 160, 1),Color.fromRGBO(0, 106, 100, 1),])
                    ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.02,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: IconButton(
                          alignment: Alignment.centerLeft,
                                          icon:const Icon(
                                            Icons.chevron_left,
                                            size: 40.0,
                                            color: Colors.white,
                                          ), onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.center,
                        child: Padding(
                          padding:  EdgeInsets.only(top: height * 0.01),
                          child: Text(
                            'USER PROFILE',
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: height * 0.025,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.005,),
                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Icon(Icons.account_circle_outlined,size: width * 0.2,color: const Color.fromRGBO(255, 255, 255, 1),),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.userDataModel.data?.firstName}',
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${widget.userDataModel.data?.lastName}',
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontSize: height * 0.02,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${widget.userDataModel.data?.role}',
                              style: TextStyle(
                                color: const Color.fromRGBO(221, 221, 221, 1),
                                fontSize: height * 0.015,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.035,right: width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:height * 0.03),
                    Text(
                      'Date of Birth',
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
                      formatted,
                      style: TextStyle(
                        color: const Color.fromRGBO(48, 145, 139, 1),
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height:height * 0.02),
                    Text(
                      'Gender',
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
                      ? "Male"
                      : "Female",
                      style: TextStyle(
                        color: const Color.fromRGBO(48, 145, 139, 1),
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height:height * 0.02),
                    Text(
                      'Country Citizen',
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
                      '${widget.userDataModel.data?.countryNationality}',
                      style: TextStyle(
                        color: const Color.fromRGBO(48, 145, 139, 1),
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height:height * 0.02),
                    Text(
                      'Country Resident',
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

                    SizedBox(height:height * 0.02),
                    Text(
                      'Email ID',
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

                    SizedBox(height:height * 0.02),
                    Text(
                      'Registered as Teacher also',
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
                      widget.userDataModel.data?.role == "student,teacher"
                        ? "Yes"
                          : "No",
                      style: TextStyle(
                        color: const Color.fromRGBO(48, 145, 139, 1),
                        fontSize: height * 0.02,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height:height * 0.02),
                    Text(
                      'RegistrationID / Roll Number',
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

                    SizedBox(height:height * 0.02),
                    Text(
                      'Institute / Organization Name',
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
                    Align(alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                          minimumSize: const Size(280, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(39),
                          ),
                        ),
                        //shape: StadiumBorder(),
                        child: Text('Edit Profile',
                            style:  TextStyle(
                                fontFamily: 'Inter',
                                fontSize: height * 0.03,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            )
                        ),
                        onPressed: () {

                        },
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }
}