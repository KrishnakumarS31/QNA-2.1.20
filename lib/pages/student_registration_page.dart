import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:qna_test/Entity/student.dart';
import 'package:qna_test/services/student_services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({super.key});


  @override
  StudentRegistrationPageState createState() => StudentRegistrationPageState();
}
class StudentRegistrationPageState extends State<StudentRegistrationPage> {
  final formKey=GlobalKey<FormState>();
  bool tocCheck = false;
  bool pPCheck = false;
  bool error =true;
  String? gender;
  Student? student;
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
    final studentFirstNameController = TextEditingController();
    TextEditingController studentLastNameController = TextEditingController();
    SingleValueDropDownController studentNationalityController = SingleValueDropDownController();
    SingleValueDropDownController studentResidentCountryController = SingleValueDropDownController();
    TextEditingController studentEmailController = TextEditingController();
    TextEditingController studentRollNumberController = TextEditingController();
    TextEditingController studentOrganisationNameController = TextEditingController();
    TextEditingController studentIsTeacherController = TextEditingController();
    TextEditingController studentPasswordController = TextEditingController();
    final body = {
      "firstName": "user1",
      "lastName": "123",
      "dob": "01/01/2001",
      "gender": "female",
      "nationality":"India",
      "residentCountry": "United States",
      "email": "user1.123@itc.com",
      "rollNumber": "A0987654",
      "organisationName": "abcde",
      "roleId": ["1"],
      "password": "acsdfvb7@0987"
      // "firstName": "super",
      // "lastName": "man",
      // "dob": "23/12/2022",
      // "nationality": "india",
      // "residentCountry": "test",
      // "email": "e@email.com",
      // "rollNumber": "23122022",
      // "organisationName": "india",
      // "isTeacher": "yes",
      // "password": "e@emailcom",
      // student?.firstName : studentFirstNameController.text,
      // student?.lastName : studentLastNameController.text,
      // student?.dob: studentDobController.text,
      // student?.nationality: studentNationalityController.dropDownValue,
      // student?.residentCountry: studentResidentCountryController.dropDownValue,
      // student?.email: studentEmailController.text,
      // student?.rollNumber: studentRollNumberController.text,
      // student?.organisationName: studentOrganisationNameController.text,
      // student?.isTeacher: studentIsTeacherController.text,
      // student?.password: studentPasswordController.text,
    };
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
        title: Text(AppLocalizations.of(context)!.student_register,
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
                        TextField(
                            controller: studentFirstNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: AppLocalizations.of(context)!.first_name_caps,
                              labelStyle: TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.first_name_hint,
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
                            controller: studentLastNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.last_name_caps,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.last_name_hint,
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
                            lastDate: DateTime(2100),
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
                          studentDobController.text = pickedDate.toString().substring(0,10);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: studentDobController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: AppLocalizations.of(context)!.dob_caps,
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.dob_format,
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
                             Text(AppLocalizations.of(context)!.gender),
                            //),
                            Radio(
                              value: "male",
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.male,
                              style:
                              TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                            ),

                            Radio(
                              value: "female",
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.female,
                              style:
                              TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                            ),

                            Radio(
                              value: "others",
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.ohers,
                              style:
                              TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
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
                              labelText: AppLocalizations.of(context)!.country_citizen,
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.enter_country),
                          clearIconProperty: IconProperty(color: Colors.green),
                          searchDecoration: InputDecoration(
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.enter_country),
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 6,

                          dropDownList: const [
                            DropDownValueModel(name: 'India', value: "value1"),
                            DropDownValueModel(
                                name: 'Singapore',
                                value: "value2",
                                toolTipMsg:
                                "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                            DropDownValueModel(name: 'United States of America', value: "value3"),
                            DropDownValueModel(
                                name: 'Russia',
                                value: "value4",
                                toolTipMsg:
                                "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                            DropDownValueModel(name: 'Poland', value: "value5"),
                            DropDownValueModel(name: 'Japan', value: "value6"),
                            DropDownValueModel(name: 'United Kingdom', value: "value7"),
                            DropDownValueModel(name: 'China', value: "value8"),
                          ],
                          onChanged: (val) {},
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
                          controller: studentResidentCountryController,
                          clearOption: true,
                          enableSearch: true,
                          textFieldDecoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.country_resident,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.enter_country),
                          clearIconProperty: IconProperty(color: Colors.green),
                          searchDecoration: InputDecoration(
                              hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.enter_country),
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 6,

                          dropDownList: const [
                            DropDownValueModel(name: 'India', value: "value1"),
                            DropDownValueModel(
                                name: 'Singapore',
                                value: "value2",
                                toolTipMsg:
                                "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                            DropDownValueModel(name: 'United States of America', value: "value3"),
                            DropDownValueModel(
                                name: 'Russia',
                                value: "value4",
                                toolTipMsg:
                                "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                            DropDownValueModel(name: 'Poland', value: "value5"),
                            DropDownValueModel(name: 'Japan', value: "value6"),
                            DropDownValueModel(name: 'United Kingdom', value: "value7"),
                            DropDownValueModel(name: 'China', value: "value8"),
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
                              labelText: AppLocalizations.of(context)!.email_id_caps,
                              helperText: 'an OTP will be sent to Email ID',
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: "emailID@email.com",
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
                            controller: studentRollNumberController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: AppLocalizations.of(context)!.reg_roll_caps,
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: "Registration ID / Roll Number",
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
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
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
                                onChanged: (val) {
                                  setState(() {
                                    tocCheck = val!;
                                    if (tocCheck) {}
                                  });
                                },
                              ),
                            ),
                            const Text(
                              'Register me also as TEACHER',
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
                      SizedBox(
                        height: localHeight * 0.03,
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
                        height: localHeight * 0.02,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        TextField(
                            controller: studentPasswordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "PASSWORD",
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
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
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: "Verify Password",
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            )
                        ),
                      )],
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
                  StudentService.addStudent(body).then((success) {
                    print(body);
                    // print(studentFirstNameController);
                    // print(student?.firstName);
                    // print(studentLastNameController);
                    // print(studentOrganisationNameController);
                    // print("vcfev");
                    // print(studentPasswordController);
                    // print(studentEmailController);
                    // print('dfsvfev');
                    // print(studentResidentCountryController.toString());
                    // print(studentDobController.text);
                    // print(studentIsTeacherController);
                    // print('wcdwcv');
                    // print(studentNationalityController.dropDownValue);
                    if (success) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: const Text('Student has been added!!!'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                // print(studentFirstNameController);
                                print("student");
                                // print(studentLastNameController);
                                // print(studentLastNameController);

                                // Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }else{
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: const Text('Error Adding Student!!!'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }
                  });
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