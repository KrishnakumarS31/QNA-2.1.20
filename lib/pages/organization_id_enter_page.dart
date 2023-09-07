import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:qna_test/Entity/organisation.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Services/qna_service.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganisationIdEnterPage extends StatefulWidget {
  OrganisationIdEnterPage({super.key,required this.isFromStudent});
  bool isFromStudent;

  @override
  OrganisationIdEnterPageState createState() => OrganisationIdEnterPageState();
}

class OrganisationIdEnterPageState extends State<OrganisationIdEnterPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController studentRollNumberController = TextEditingController();
  TextEditingController studentOrganisationNameController =
  TextEditingController();
  List<String>? ages =[];
  Map<String, int> idAndNameMap = {};
  String selectedValue = ''; // To store the selected dropdown value
  //TextEditingController textFieldController = TextEditingController();
  bool valueForDrop = false;
  OrganisationResponse? questionResponse;

  @override
  void initState() {
    print("widget isfrom student");
    print(widget.isFromStudent);
    super.initState();
  }

  @override
  void dispose() {
    // studentDobController.dispose();
    super.dispose();
  }


  _somefun(String value)
  {


    print("INSIDEEEEE SOME FUNNNNNN");

    _performAsyncWork(value).then((responseEntity){


      setState(() {
        print("Inside Set State");
        print(responseEntity.code);
        // organizationId =
        //     value;
        List<Institution>? questions;
        if (responseEntity.code == 200) {
          questionResponse = OrganisationResponse.fromJson(responseEntity.data);
          questions = questionResponse?.institutions;
          ages = questions?.map((e) => e.institutionName).toList();
          idAndNameMap = {};
          questions?.forEach((person) {
            idAndNameMap[person.institutionName] = person.institutionId;
          });
          valueForDrop = true;
          selectedValue = ages![0];
          print(ages);
          print(idAndNameMap);
        }
        else if(responseEntity.code != 200)
          {
            print("WALLLAH");
            print(responseEntity.message);

            double localWidth = MediaQuery.of(context).size.width;
            double localHeight = MediaQuery.of(context).size.height;
            forgotPasswordPopup(context, localHeight, localWidth,responseEntity.message!);

          }
        //   ResponseEntity responseEntity = await QnaService.getQuestionBankService(
        //       10, pageNumber, search, userDetails);
        // });
      });


    });

    print(valueForDrop);

  }

  Future<ResponseEntity> _performAsyncWork(String value) async
  {
    ResponseEntity responseEntity = await QnaService.getInstitutionNames(value);
    return responseEntity;
  }

  forgotPasswordPopup(BuildContext context, double height,double width,String message) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: width>960 ? Size(width * 0.06, height * 0.05): (width <= 960 && width > 500) ? Size(width * 0.15, height * 0.03) : Size(width * 0.2, height * 0.05),
        shape: RoundedRectangleBorder(      borderRadius:
        BorderRadius
            .circular(
            39),),
        backgroundColor: Colors.white,
        textStyle: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(48, 145, 139, 1),
            fontWeight: FontWeight.w500),
      ),
      child: Text(
        AppLocalizations.of(context)!.ok_caps,
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
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color.fromRGBO(238, 71, 0, 1),
          ),
          Text(
            "Alert",
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
        "No Institution Found for this Organization ID",
        //AppLocalizations.of(context)!.sure_to_submit_qn_bank,
        //code == 401 ? 'Please enter the correct password.' : code == 400 ? 'Invalid role. Check your login data': "Server error",
        style: TextStyle(
            fontSize: height * 0.02,
            fontFamily: "Inter",
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontWeight: FontWeight.w400),
      ),
      actions: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cancelButton,
            const SizedBox(height:10.0),
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
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth <= 960 && constraints.maxWidth >=500) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    appBar:
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 40.0,
                          color: Color.fromRGBO(28, 78, 80, 1),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      centerTitle: true,
                      title: Text(
                        AppLocalizations.of(context)!.student_register,
                        style: const TextStyle(
                          color: Color.fromRGBO(28, 78, 80, 1),
                          fontSize: 18.0,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      flexibleSpace: Container(
                        color: Colors.white,
                      ),
                    ),
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child:
                      Column(
                          children:[
                            SizedBox(height: localHeight * 0.05),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: localWidth * 0.9,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: localHeight * 0.05,
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 40, right: 30),
                                                      child:
                                                      Column(
                                                          children: [
                                                            Row(
                                                                children:[
                                                                  Text(AppLocalizations.of(
                                                                      context)!
                                                                      .reg_roll_caps,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            102, 102, 102, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontSize: localHeight *
                                                                            0.0155),
                                                                  ),
                                                                ]
                                                            ),
                                                          ])
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.8,
                                                        child: TextFormField(
                                                          controller: studentRollNumberController,
                                                          keyboardType: TextInputType.text,
                                                          maxLength: 8,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(
                                                                RegExp('[a-zA-Z0-9]')),
                                                          ],
                                                          decoration: InputDecoration(
                                                            //labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            // label: Text(AppLocalizations.of(
                                                            //     context)!
                                                            //     .reg_roll_caps,
                                                            //   style: TextStyle(
                                                            //       color: const Color
                                                            //           .fromRGBO(
                                                            //           102, 102, 102, 1),
                                                            //       fontFamily: 'Inter',
                                                            //       fontWeight: FontWeight
                                                            //           .w600,
                                                            //       fontSize: localHeight *
                                                            //           0.020),
                                                            // ),
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            helperStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontStyle: FontStyle.italic,
                                                                fontSize: localHeight * 0.016),
                                                            helperText: AppLocalizations.of(context)!.organization_helper,
                                                            hintText: "Enter 8-Digit ID",
                                                          ),
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'Enter Organization ID';
                                                            }
                                                            else if(value.isNotEmpty && value.length<8)
                                                            {
                                                              return 'Enter 8 characters';
                                                            }
                                                            else if (value.startsWith("0")) {
                                                               _somefun(value);
                                                            }
                                                            // else if (value.length < 8) {
                                                            //   return " ${8- value.length} more characters needed to verify";
                                                            // }
                                                            else if (value.length == 8) {
                                                               _somefun(value);
                                                            }
                                                            else {
                                                              return null;
                                                            }
                                                            return null;
                                                          },
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },

                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03
                                                    ,
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 40, right: 30),
                                                      child:
                                                      Column(
                                                          children: [
                                                            Row(
                                                                children:[
                                                                  Text(AppLocalizations.of(
                                                                      context)!
                                                                      .ins_org_caps,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            102, 102, 102, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontSize: localHeight *
                                                                            0.0155),
                                                                  ),
                                                                ]
                                                            ),
                                                          ])
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      // valueForDrop == false ?
                                                      // TextFormField(
                                                      //   controller: studentOrganisationNameController,
                                                      //   maxLength: 200,
                                                      //   maxLengthEnforcement: MaxLengthEnforcement
                                                      //       .truncateAfterCompositionEnds,
                                                      //   keyboardType: TextInputType.text,
                                                      //   decoration: InputDecoration(
                                                      //       labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      //       floatingLabelBehavior:
                                                      //       FloatingLabelBehavior.always,
                                                      //       hintStyle: TextStyle(
                                                      //           color: const Color.fromRGBO(
                                                      //               102, 102, 102, 0.3),
                                                      //           fontFamily: 'Inter',
                                                      //           fontWeight: FontWeight.w400,
                                                      //           fontSize: localHeight * 0.018),
                                                      //       hintText:
                                                      //       AppLocalizations.of(
                                                      //           context)!
                                                      //           .enter_here
                                                      //   ),
                                                      //   onChanged: (value) {
                                                      //     formKey.currentState!.validate();
                                                      //   },
                                                      //   validator: (value) {
                                                      //     if (value!.isEmpty) {
                                                      //       return 'Enter Institution Name Name';
                                                      //     } else {
                                                      //       return null;
                                                      //     }
                                                      //   },
                                                      // ) :
                                                      DropdownButton<String>(
                                                        value: selectedValue,
                                                        isExpanded:true,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedValue = newValue!;
                                                          });
                                                        },

                                                        items: ages!.map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        hint: Text('Select an option',
                                                            style:TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.018)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.01,
                                                  ),

                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child: IconButton(
                                                      iconSize: localHeight * 0.06,
                                                      icon: Icon(Icons.arrow_circle_right,
                                                          color: const Color.fromRGBO(82, 165, 160, 1)
                                                      ),
                                                      onPressed: () async {
                                                        print("INSIDE ");
                                                        if(selectedValue.isEmpty || selectedValue == null)
                                                        {

                                                        }
                                                        //bool valid = formKey.currentState!.validate();
                                                        if( studentRollNumberController.text.isNotEmpty && widget.isFromStudent) {
                                                          print("INSIDE VIPER");
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/studentRegistrationPage',
                                                              arguments: [
                                                                idAndNameMap[selectedValue],
                                                                selectedValue,
                                                                studentRollNumberController.text
                                                              ]);
                                                        }
                                                        else if(studentRollNumberController.text.isNotEmpty && widget.isFromStudent == false)
                                                        {
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/teacherRegistrationPage',
                                                              arguments: [
                                                                idAndNameMap[selectedValue],
                                                                selectedValue,
                                                                studentRollNumberController.text
                                                              ]);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  //SizedBox(height:localHeight * 0.05),
                                                ],
                                              )]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //)
                            ),
                            SizedBox(
                              height: localHeight * 0.05,
                            ),
                          ]
                      ),
                    )));
          }
          else if(constraints.maxWidth > 960) {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 40.0,
                          color: Color.fromRGBO(28, 78, 80, 1),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      centerTitle: true,
                      title: Text(
                        AppLocalizations.of(context)!.student_register,
                        style: const TextStyle(
                          color: Color.fromRGBO(28, 78, 80, 1),
                          fontSize: 18.0,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      flexibleSpace: Container(
                        color: Colors.white,
                      ),
                    ),
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child:
                      Column(
                          children:[
                            SizedBox(height: localHeight * 0.05),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: localWidth * 0.7,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: localHeight * 0.05,
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.65,
                                                        child: TextFormField(
                                                          controller: studentRollNumberController,
                                                          keyboardType: TextInputType.text,
                                                          maxLength: 8,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(
                                                                RegExp('[a-zA-Z0-9]')),
                                                          ],
                                                          decoration: InputDecoration(
                                                            labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            label: Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .reg_roll_caps,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  fontSize: localHeight *
                                                                      0.020),
                                                            ),
                                                            helperStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontStyle: FontStyle.italic,
                                                                fontSize: localHeight * 0.018),
                                                            helperText: AppLocalizations.of(context)!.organization_helper,
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: "Enter 8-Digit ID",
                                                          ),
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'Enter Organization ID';;
                                                            }
                                                            else if(value.isNotEmpty && value.length<8)
                                                            {
                                                              return 'Enter 8 characters';
                                                            }
                                                            else if (value.startsWith("0")) {
                                                              _somefun(value);
                                                            }
                                                            // else if (value.length < 8) {
                                                            //   return " ${8- value.length} more characters needed to verify";
                                                            // }
                                                            else if (value.length == 8) {
                                                              _somefun(value);

                                                            }
                                                            else
                                                            {

                                                            }
                                                            return null;
                                                          },
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },

                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03
                                                    ,
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30, right: 30),
                                                      child:
                                                      Column(
                                                          children: [
                                                            Row(
                                                                children:[
                                                                  Text(AppLocalizations.of(
                                                                      context)!
                                                                      .ins_org_caps,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            102, 102, 102, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontSize: localHeight *
                                                                            0.0155),
                                                                  ),
                                                                ]
                                                            ),
                                                          ])
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                      width: localWidth * 0.65,
                                                      // child:valueForDrop == false ?
                                                      // TextFormField(
                                                      //   controller: studentOrganisationNameController,
                                                      //   maxLength: 200,
                                                      //   maxLengthEnforcement: MaxLengthEnforcement
                                                      //       .truncateAfterCompositionEnds,
                                                      //   keyboardType: TextInputType.text,
                                                      //   decoration: InputDecoration(
                                                      //       labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      //       floatingLabelBehavior:
                                                      //       FloatingLabelBehavior.always,
                                                      //       hintStyle: TextStyle(
                                                      //           color: const Color.fromRGBO(
                                                      //               102, 102, 102, 0.3),
                                                      //           fontFamily: 'Inter',
                                                      //           fontWeight: FontWeight.w400,
                                                      //           fontSize: localHeight * 0.018),
                                                      //       hintText:
                                                      //       AppLocalizations.of(
                                                      //           context)!
                                                      //           .enter_here
                                                      //   ),
                                                      //   onChanged: (value) {
                                                      //     formKey.currentState!.validate();
                                                      //   },
                                                      //   validator: (value) {
                                                      //     if (value!.isEmpty) {
                                                      //       return 'Enter Institution Name Name';
                                                      //     } else {
                                                      //       return null;
                                                      //     }
                                                      //   },
                                                      // ) :
                                                      child:DropdownButton<String>(
                                                        value: selectedValue,
                                                        isExpanded:true,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedValue = newValue!;
                                                          });
                                                        },

                                                        items: ages!.map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        hint: Text('Select an option'
                                                        , style:TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.01,
                                                  ),
                                                  Center(
                                                    child: IconButton(
                                                      iconSize: localHeight * 0.06,
                                                      icon: Icon(Icons.arrow_circle_right,
                                                          color: const Color.fromRGBO(82, 165, 160, 1)
                                                      ),
                                                      onPressed: () async {
                                                        //bool valid = formKey.currentState!.validate();
                                                        if(selectedValue.isEmpty || selectedValue == null)
                                                        {

                                                        }
                                                        if(studentRollNumberController.text.isNotEmpty && widget.isFromStudent) {
                                                          print("dffb");
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/studentRegistrationPage',
                                                              arguments: [
                                                                idAndNameMap[selectedValue],
                                                                selectedValue,
                                                                studentRollNumberController.text
                                                              ]);
                                                        }
                                                        else if(studentRollNumberController.text.isNotEmpty && widget.isFromStudent == false)
                                                          {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/teacherRegistrationPage',
                                                                arguments: [
                                                                  idAndNameMap[selectedValue],
                                                                  selectedValue,
                                                                  studentRollNumberController.text
                                                                ]);
                                                          }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  //SizedBox(height:localHeight * 0.05),
                                                ],
                                              )]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //)
                            ),
                            SizedBox(
                              height: localHeight * 0.05,
                            ),
                          ]
                      ),
                    )));
          }
          else
          {
            return WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 40.0,
                          color: Color.fromRGBO(28, 78, 80, 1),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      centerTitle: true,
                      title: Text(
                        AppLocalizations.of(context)!.student_register,
                        style: const TextStyle(
                          color: Color.fromRGBO(28, 78, 80, 1),
                          fontSize: 18.0,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      flexibleSpace: Container(
                        color: Colors.white,
                      ),
                    ),
                    body: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child:
                      Column(
                          children:[
                            SizedBox(height: localHeight * 0.05),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                width: localWidth * 0.9,
                                child: Form(
                                  key: formKey,
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: localHeight * 0.05,
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: localWidth * 0.05, right: localWidth * 0.05),
                                                      child:
                                                      Column(
                                                          children: [
                                                            Row(
                                                                children:[
                                                                  Text(AppLocalizations.of(
                                                                      context)!
                                                                      .reg_roll_caps,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            102, 102, 102, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontSize: localHeight *
                                                                            0.020),
                                                                  ),
                                                                ]
                                                            ),
                                                          ])
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.8,
                                                        child: TextFormField(
                                                          controller: studentRollNumberController,
                                                          keyboardType: TextInputType.text,
                                                          maxLength: 8,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(
                                                                RegExp('[a-zA-Z0-9]')),
                                                          ],
                                                          decoration: InputDecoration(
                                                            labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            helperStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontStyle: FontStyle.italic,
                                                                fontSize: localHeight * 0.016),
                                                            helperText: AppLocalizations.of(context)!.organization_helper,
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: "Enter 8-Digit ID",
                                                          ),
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'Enter Organization ID'; ;
                                                            }
                                                            else if(value.isNotEmpty && value.length<8)
                                                              {
                                                                return 'Enter 8 characters';
                                                              }
                                                            else if (value.startsWith("0")) {
                                                              print("INSIDE VALUE");
                                                               _somefun(value);
                                                            }
                                                            // else if (value.length < 8) {
                                                            //   return " ${8- value.length} more characters needed to verify";
                                                            // }

                                                            else if (value.length == 8) {
                                                               _somefun(value);
                                                            }


                                                            else {
                                                              return null;
                                                            }
                                                          },
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },

                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03
                                                    ,
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: localWidth * 0.05, right: localWidth * 0.05),
                                                      child:
                                                      Column(
                                                          children: [
                                                            Row(
                                                                children:[
                                                                  Text(AppLocalizations.of(
                                                                      context)!
                                                                      .ins_org_caps,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            102, 102, 102, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontSize: localHeight *
                                                                            0.020),
                                                                  ),
                                                                ]
                                                            ),
                                                          ])
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      // valueForDrop == false ?
                                                      // TextFormField(
                                                      //   controller: studentOrganisationNameController,
                                                      //   maxLength: 200,
                                                      //   maxLengthEnforcement: MaxLengthEnforcement
                                                      //       .truncateAfterCompositionEnds,
                                                      //   keyboardType: TextInputType.text,
                                                      //   decoration: InputDecoration(
                                                      //       labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      //       floatingLabelBehavior:
                                                      //       FloatingLabelBehavior.always,
                                                      //       hintStyle: TextStyle(
                                                      //           color: const Color.fromRGBO(
                                                      //               102, 102, 102, 0.3),
                                                      //           fontFamily: 'Inter',
                                                      //           fontWeight: FontWeight.w400,
                                                      //           fontSize: localHeight * 0.018),
                                                      //       hintText:
                                                      //       AppLocalizations.of(
                                                      //           context)!
                                                      //           .enter_here
                                                      //   ),
                                                      //   onChanged: (value) {
                                                      //     formKey.currentState!.validate();
                                                      //   },
                                                      //   validator: (value) {
                                                      //     if (value!.isEmpty) {
                                                      //       return 'Enter Institution Name Name';
                                                      //     } else {
                                                      //       return null;
                                                      //     }
                                                      //   },
                                                      // ) :
                                                      DropdownButton<String>(
                                                        value: selectedValue,
                                                        isExpanded:true,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedValue = newValue!;
                                                          });
                                                        },

                                                        items: ages!.map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        hint: Text('Select an option',
                                                        style:TextStyle(
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 0.3),
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: localHeight * 0.018),),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.01,
                                                  ),
                                                  Center(
                                                    child: IconButton(
                                                      iconSize: localHeight * 0.06,
                                                      icon: const Icon(Icons.arrow_circle_right,
                                                          color: Color.fromRGBO(82, 165, 160, 1)
                                                      ),
                                                      onPressed: () async {
                                                          //if(selectedValue == )
                                                        //bool valid = formKey.currentState!.validate();
                                                        if(selectedValue.isEmpty || selectedValue == null)
                                                          {

                                                          }
                                                        else if(studentRollNumberController.text.isNotEmpty && widget.isFromStudent) {
                                                          print("INSIDE FIRST IF");
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/studentRegistrationPage',
                                                              arguments: [
                                                                idAndNameMap[selectedValue],
                                                                selectedValue,
                                                                studentRollNumberController.text
                                                              ]);
                                                        }
                                                        else if(studentRollNumberController.text.isNotEmpty && widget.isFromStudent == false)
                                                        {
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/teacherRegistrationPage',
                                                              arguments: [
                                                                idAndNameMap[selectedValue],
                                                                selectedValue,
                                                                studentRollNumberController.text

                                                              ]);
                                                        }

                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  //SizedBox(height:localHeight * 0.05),
                                                ],
                                              )]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //)
                            ),
                            SizedBox(
                              height: localHeight * 0.05,
                            ),
                          ]
                      ),
                    )));
          }

        }


    );
  }
}
