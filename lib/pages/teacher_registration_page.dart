import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_verify_page.dart';
import 'package:qna_test/pages/teacher_registration_verify_page.dart';

import '../Services/qna_service.dart';

class TeacherRegistrationPage extends StatefulWidget {
  const TeacherRegistrationPage({super.key});


  @override
  TeacherRegistrationPageState createState() => TeacherRegistrationPageState();
}
class TeacherRegistrationPageState extends State<TeacherRegistrationPage> {
  final formKey=GlobalKey<FormState>();
  bool tocCheck = false;
  bool pPCheck = false;
  bool error =true;
  String? gender;

  final studentDobController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    studentDobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;
    TextEditingController studentFirstNameController = TextEditingController();
    TextEditingController studentLastNameController = TextEditingController();
    SingleValueDropDownController studentNationalityController = SingleValueDropDownController();
    TextEditingController studentEmailController = TextEditingController();
    TextEditingController studentRollNumberController = TextEditingController();
    TextEditingController studentOrganisationNameController = TextEditingController();
    TextEditingController studentPasswordController = TextEditingController();

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.white,
          ), onPressed: () {
          Navigator.of(context).pop();
        },
        ),
        centerTitle: true,
        title: const Text("TEACHER  REGISTRATION",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 18.0,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [Color.fromRGBO(0, 106, 100, 1),
                    Color.fromRGBO(82, 165, 160, 1),])
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            SizedBox(
              width: localWidth * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: localHeight * 0.05,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextFormField(
                            controller: studentFirstNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "FIRST NAME",
                              labelStyle: TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                              hintText: "First Name",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextFormField(
                            controller: studentLastNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "LAST NAME",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                              hintText: "Last Name",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      GestureDetector(
                        onTap:  () async {
                          var pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromRGBO(82, 165, 160, 1),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black, // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color.fromRGBO(82, 165, 160, 1),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          final DateFormat formatter = DateFormat('dd-MM-yyyy');
                          final String formatted = formatter.format(pickedDate!);
                          studentDobController.text = formatted;
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: studentDobController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "DATE OF BIRTH",
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: "DD / MM / YYYY",
                              suffixIcon: const Icon(
                                Icons.calendar_today_outlined,
                                color: Color.fromRGBO(141, 167, 167, 1),
                              ),
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            enabled: true,
                            onChanged: (value) {
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      Container(
                        height: localHeight * 0.057,
                        decoration: BoxDecoration(
                          //color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(17),
                          border: Border.all(
                            color: const Color.fromRGBO(196, 196, 196, 1),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              width: localWidth * 0.03,
                            ),
                            // Padding(
                            //padding: EdgeInsets.only(left: localWidth * 0.002, bottom:localWidth * 0.15),
                            const Text("Gender"),
                            //),
                            Radio(
                              value: "male",
                              groupValue: gender,
                              fillColor:
                              MaterialStateColor.resolveWith((states) => const Color.fromRGBO(82, 165, 160, 1)),
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style:
                              TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                            ),

                            Radio(
                              value: "female",
                              groupValue: gender,
                              fillColor:
                              MaterialStateColor.resolveWith((states) => const Color.fromRGBO(82, 165, 160, 1)),
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text(
                              'Female',
                              style:
                              TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                            ),

                            Radio(
                              value: "others",
                              groupValue: gender,
                              fillColor:
                              MaterialStateColor.resolveWith((states) => const Color.fromRGBO(82, 165, 160, 1)),
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text(
                              'Others',
                              style:
                              TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          border: Border.all(
                            color: const Color.fromRGBO(196, 196, 196, 1),
                            width: 1.5,
                          ),
                        ),
                        child: DropDownTextField(
                          controller: studentNationalityController,
                          clearOption: true,
                          enableSearch: true,
                          textFieldDecoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "COUNTRY CITIZEN",
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: "Enter Country"),
                          clearIconProperty: IconProperty(color: Colors.green),
                          searchDecoration: InputDecoration(
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: "Enter Country"),
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 6,

                          dropDownList: const [
                            DropDownValueModel(name: 'name1', value: "value1"),
                            DropDownValueModel(
                                name: 'name2',
                                value: "value2",
                                toolTipMsg:
                                "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                            DropDownValueModel(name: 'name3', value: "value3"),
                            DropDownValueModel(
                                name: 'name4',
                                value: "value4",
                                toolTipMsg:
                                "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                            DropDownValueModel(name: 'name5', value: "value5"),
                            DropDownValueModel(name: 'name6', value: "value6"),
                            DropDownValueModel(name: 'name7', value: "value7"),
                            DropDownValueModel(name: 'name8', value: "value8"),
                          ],
                          onChanged: (val) {},
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextField(
                            controller: studentEmailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "EMAIL ID",
                              helperText: 'an OTP will be sent to Email ID',
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.015),
                              hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                              hintText: "Sample Email ID@email.com",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextFormField(
                            controller: studentRollNumberController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "REGISTRATION ID",
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                              hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                              hintText: "Registration ID",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextField(
                            controller: studentOrganisationNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "INSTITUTE / ORGANIZATION NAME",
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                              hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                              hintText: "Institute / Organization Name",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.02,
                      ),
                      Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10)),
                                value: tocCheck,
                                fillColor:
                                MaterialStateColor.resolveWith((states) => const Color.fromRGBO(82, 165, 160, 1)),
                                onChanged: (val) {
                                  setState(() {
                                    tocCheck = val!;
                                    if (tocCheck) {}
                                  });
                                },
                              ),
                            ),
                            const Text(
                              'Register me also as STUDENT',
                              style: TextStyle(fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: "Inter"),
                            ),
                          ]),
                      SizedBox(
                        height: localHeight * 0.01,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'CREATE PASSWORD',
                            style: TextStyle(fontSize: 17.0,
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Inter"),
                          )),
                      SizedBox(
                        height: localHeight * 0.023,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextFormField(
                            controller: studentPasswordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "PASSWORD",
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                              hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                              hintText: "Password (Min 8 characters)",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),
                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextField(
                            controller: studentPasswordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "CONFIRM PASSWORD",
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.015),
                              hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                              hintText: "Confirm Password",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),

                      ),
                      SizedBox(
                        height: localHeight * 0.03,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'PRIVACY & TERMS',
                            style: TextStyle(fontSize: 17.0,
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Inter"),
                          )),
                      SizedBox(
                        height: localHeight * 0.02,
                      ),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        1)),
                                value: pPCheck,
                                onChanged: (val) {
                                  setState(() {
                                    pPCheck = val!;
                                    if (pPCheck) {}
                                  });
                                },
                              ),
                            ),
                            const Text(
                              'I hereby certify that I have read and AGREE to',
                              style: TextStyle(fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontFamily: "Inter"),
                            ),
                            RichText(
                                text: const TextSpan(children: [
                                  // WidgetSpan(
                                  //   alignment:
                                  //   PlaceholderAlignment.middle,
                                  //   // child: Transform.scale(
                                  //   //   scale: localWidth * 0.0022,
                                  //   // ),
                                  // ),
                                  TextSpan(
                                    text: "\n Terms of Service",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        decoration:
                                        TextDecoration.underline,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: " and  ",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),),
                                  // WidgetSpan(
                                  //   alignment:
                                  //   PlaceholderAlignment.middle,
                                  //   child: Transform.scale(
                                  //     scale: localWidth * 0.0022,
                                  //     // alignment: Alignment.centerLeft,
                                  //   ),
                                  // ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        decoration:
                                        TextDecoration.underline,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: "Inter"),
                                  ),
                                ])),
                          ]),

                    ],
                  ),
                  //SizedBox(height:localHeight * 0.05),
                ],
              ),
            ),
            SizedBox(
              height: localHeight * 0.05,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(82, 165, 160, 1),
                  minimumSize: const Size(280, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(39),
                  ),
                ),
                onPressed: () {
                  QnaService.sendOtp();
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: TeacherRegistrationOtpPage()
                    ),
                  );
                },
                child: Text(
                  'Send OTP',
                  style: TextStyle(
                      fontSize: localHeight * 0.024,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: localHeight * 0.05,
            ),
          ],
        ),
      ),
      //)
    );}
}