import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Entity/student.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:qna_test/Pages/student_regis_verify_otp.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/custom_http_response.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/student_registration_model.dart';
import '../Services/qna_service.dart';

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({super.key});


  @override
  StudentRegistrationPageState createState() => StudentRegistrationPageState();
}
class StudentRegistrationPageState extends State<StudentRegistrationPage> {
  final formKey=GlobalKey<FormState>();
  TextEditingController studentFirstNameController = TextEditingController();
  TextEditingController studentLastNameController = TextEditingController();
  SingleValueDropDownController studentNationalityController = SingleValueDropDownController();
  SingleValueDropDownController studentResidentCountryController = SingleValueDropDownController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentRollNumberController = TextEditingController();
  TextEditingController studentOrganisationNameController = TextEditingController();
  TextEditingController studentIsTeacherController = TextEditingController();
  TextEditingController studentPasswordController = TextEditingController();
  TextEditingController studentconfirmPasswordController = TextEditingController();
  bool tocCheck = false;
  bool pPCheck = false;
  bool error =true;
  String? gender;
  String? countryCtizen;
  final studentDobController = TextEditingController();
  late Response userDetails;

  List<String> counrtyCitizenList = ['India','Singapore','Poland','Japan','United Kingdom','China'];
  String? selectedCounrtyCitizen;
  List<String> counrtyResidentList = ['India','Singapore','Poland','Japan','United Kingdom','China'];
  String? selectedCounrtyResident;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    studentDobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;

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
          style: const TextStyle(
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
        child: Form(
          key: formKey,
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
                                label: SizedBox(
                                  width: localWidth * 0.15,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.first_name_caps,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                       const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                //labelStyle: TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                                hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                hintText: AppLocalizations.of(context)!.first_name_hint,
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter First Name';
                              }
                              else{
                                return null;
                              }
                            },
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
                                label: SizedBox(
                                  width: localWidth * 0.15,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.last_name_caps,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                //labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                                hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                hintText: AppLocalizations.of(context)!.last_name_hint,
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Last Name';
                              }
                              else{
                                return null;
                              }
                            },
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
                            final DateFormat formatter = DateFormat('dd/MM/yyyy');
                            final String formatted = formatter.format(pickedDate!);

                              studentDobController.text = formatted;


                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: studentDobController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                label: SizedBox(
                                  width: localWidth * 0.15,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.dob_caps,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                                hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
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
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter Date Of Birth';
                                }
                                else{
                                  return null;
                                }
                              },
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
                              const Text("\t*", style: TextStyle(color: Colors.red)),
                              //),
                              Radio(
                                value: "male",
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value..toString();
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
                                AppLocalizations.of(context)!.others,
                                style:
                                TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3, top: 3),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  //background color of dropdown button
                                  border: Border.all(
                                      color: Colors.black38,
                                      width: 1), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      17), //border radius of dropdown button
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Text("Select Country name"),
                                      isExpanded: true,
                                      items: counrtyCitizenList.map((subtype) {
                                        return DropdownMenuItem(
                                          value: subtype.toString(),
                                          child: new Text(subtype.toString()),
                                        );
                                      }).toList(),
                                      style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                                      onChanged: (newCounrtyCitizenValue) {
                                        setState(() {
                                          selectedCounrtyCitizen = newCounrtyCitizenValue!;
                                          //getItemNameData(selectedLinenType);
                                        });
                                      },
                                      value: selectedCounrtyCitizen,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: localWidth * 0.038,
                              child: Container(
                              color: Colors.white,
                              child: Text(
                                'COUNTRY CITIZEN',
                                style: TextStyle(
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                    fontSize: localHeight * 0.012,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),)
                          ],
                        ),
                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3, top: 3),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  //background color of dropdown button
                                  border: Border.all(
                                      color: Colors.black38,
                                      width: 1), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      17), //border radius of dropdown button
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Text("Select Country name"),
                                      isExpanded: true,
                                      items: counrtyResidentList.map((subtype) {
                                        return DropdownMenuItem(
                                          value: subtype.toString(),
                                          child: new Text(subtype.toString()),
                                        );
                                      }).toList(),
                                      style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.02),
                                      onChanged: (newCounrtyCitizenValue) {
                                        setState(() {
                                          selectedCounrtyResident = newCounrtyCitizenValue!;
                                          //getItemNameData(selectedLinenType);
                                        });
                                      },
                                      value: selectedCounrtyResident,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: localWidth * 0.038,
                              child: Container(
                                color: Colors.white,
                                child: Text(
                                  'COUNTRY CITIZEN',
                                  style: TextStyle(
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                      fontSize: localHeight * 0.012,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),)
                          ],
                        ),

                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          TextFormField(
                              controller: studentEmailController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                label: SizedBox(
                                  width: localWidth * 0.10,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.email_id_caps,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                helperText: 'an OTP will be sent to Email ID',
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                                helperStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                hintText: "emailID@email.com",
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Valid Email';
                              }
                              else{
                                return null;
                              }
                            },
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
                                label: SizedBox(
                                  width: localWidth * 0.35,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.reg_roll_caps,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                                hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                hintText: AppLocalizations.of(context)!.reg_roll,
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Roll Number';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          TextFormField(
                              controller: studentOrganisationNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                label: SizedBox(
                                  width: localWidth * 0.35,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.ins_org_caps,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                              hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                              hintText: AppLocalizations.of(context)!.ins_org,
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Organization Name';
                              }
                              else{
                                return null;
                              }
                            },
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
                             Text(
                              AppLocalizations.of(context)!.reg_as_student,
                                style: const TextStyle(fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: "Inter"),
                              ),
                            ]),
                        SizedBox(
                          height: localHeight * 0.01,
                        ),
                         Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                            AppLocalizations.of(context)!.pri_terms,
                              style: const TextStyle(fontSize: 17.0,
                                  color: Color.fromRGBO(102, 102, 102, 1),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Inter"),
                            )),
                        SizedBox(
                          height: localHeight * 0.02,
                        ),
                        Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                         //mainAxisAlignment: MainAxisAlignment.start,
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
                               Text(
                                AppLocalizations.of(context)!.agree_msg,
                                style: const TextStyle(fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: "Inter"),
                              ),
                              RichText(
                                  text:  TextSpan(children: [
                                    // WidgetSpan(
                                    //   alignment:
                                    //   PlaceholderAlignment.middle,
                                    //   // child: Transform.scale(
                                    //   //   scale: localWidth * 0.0022,
                                    //   // ),
                                    // ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.terms_services,
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                          TextDecoration.underline,
                                          color: Color.fromRGBO(82, 165, 160, 1),
                                          fontFamily: "Inter"),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.and,
                                      style: const TextStyle(
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
                                      text: AppLocalizations.of(context)!.privacy_Policy,
                                      style: const TextStyle(
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.create_pass,
                              style: const TextStyle(fontSize: 17.0,
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
                          TextFormField(
                              controller: studentPasswordController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                label: SizedBox(
                                  width: localWidth * 0.15,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.password_caps,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                                hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                hintText: AppLocalizations.of(context)!.password_hint,
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Password';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: localHeight * 0.03,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          TextFormField(
                              controller: studentconfirmPasswordController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                label: SizedBox(
                                  width: localWidth * 0.25,
                                  child: Row(
                                    children: [
                                      Text(AppLocalizations.of(context)!.confirm_password,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(51, 51, 51, 1),
                                          fontSize: localHeight * 0.012,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      const Text("\t*", style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                labelStyle:  TextStyle(color: const Color.fromRGBO(51, 51, 51, 1),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: localHeight * 0.012),
                                hintStyle:  TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                hintText: AppLocalizations.of(context)!.verify_password,
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            validator: (value){
                              if(studentPasswordController.text!=studentconfirmPasswordController.text ){
                                  return 'Re-Enter Password';
                              }
                              else{
                                return null;
                              }
                            },
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
                  onPressed: ()async
                  {
                  bool valid=formKey.currentState!.validate();
                  print(studentFirstNameController.text);
                  print(studentLastNameController.text);
                  print(studentDobController.text);
                  print(gender);
                  print(selectedCounrtyCitizen);
                  print(selectedCounrtyResident);
                  print(studentEmailController.text);
                  print(studentPasswordController.text);
                  print(studentRollNumberController.text);
                  print(studentOrganisationNameController);


                  StudentRegistrationModel student=StudentRegistrationModel(
                      firstName: studentFirstNameController.text,
                      lastName: studentLastNameController.text,
                      dob: 32546,
                      gender: gender,
                      countryNationality: selectedCounrtyCitizen,
                      email: studentEmailController.text,
                      password: studentPasswordController.text,
                      rollNumber: studentRollNumberController.text,
                      organisationName: studentOrganisationNameController.text,
                      countryResident: selectedCounrtyResident,
                      role: 'student');
                  if(valid) {
                    LoginModel res=await QnaService.postUserDetailsService(student);
                    if(res.code==200){
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: StudentRegisVerifyOtpPage(email: studentEmailController.text,)
                      ),
                    );
                    }
                    else{
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CustomDialog(title: 'Incorrect Data', content: '${res.message}', button: AppLocalizations.of(context)!.retry,),
                        ),
                      );
                    }
                  }
                  },
                child: Text(
                  AppLocalizations.of(context)!.sent_otp,
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
      ),
      //)
    );}

}