import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/Pages/teacher_registration_verify_page.dart';


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
  int n = 244;
  List<String> counrtyCitizenList = ["India","Ascension Island",
    "Andorra","United Arab Emirates","Antigua & Barbuda","Anguilla",
    "Albania","Armenia","Angola","Antarctica","Argentina","American Samoa",
    "Austria","Australia","Aruba","Åland Islands","Azerbaijan","Bosnia & Herzegovina",
    "Barbados","Bangladesh","Belgium","Burkina Faso","Bulgaria","Bahrain","Burundi",
    "Benin","St. Barthélemy","Bermuda","Brunei","Bolivia","Caribbean Netherlands","Brazil",
    "Bahamas","Bhutan","Bouvet Island","Botswana","Belarus","Belize","Canada","Cocos (Keeling) Islands",
    "Congo (DRC)","Central African Republic","Congo (Republic)","Switzerland","Côte d’Ivoire","Cook Islands",
    "Chile","Cameroon","Colombia","Costa Rica","Cape Verde","Curaçao","Christmas Island","Cyprus",
    "Czech Republic","Germany","Djibouti","Denmark","Dominica","Dominican Republic","Algeria","Ecuador",
    "Estonia","Egypt","Western Sahara","Eritrea","Spain","Ethiopia","Finland","Fiji","Falkland Islands (Islas Malvinas)",
    "Micronesia","Faroe Islands","France","Gabon","United Kingdom","Grenada","Georgia","French Guiana",
    "Guernsey","Ghana","Gibraltar","Greenland","Gambia","Guinea","Guadeloupe","Equatorial Guinea","Greece",
    "South Georgia & South Sandwich Islands","Guatemala","Guam","Guinea-Bissau","Guyana","Hong Kong",
    "Heard & McDonald Islands","Honduras","Croatia","Haiti","Hungary","Indonesia","Ireland","Israel",
    "Isle of Man","India","British Indian Ocean Territory","Iraq","Iceland","Italy","Jersey","Jamaica","Jordan",
    "Japan","Kenya","Kyrgyzstan","Cambodia","Kiribati","Comoros","St. Kitts & Nevis","South Korea","Kuwait",
    "Cayman Islands","Kazakhstan","Laos","Lebanon","St. Lucia","Liechtenstein","Sri Lanka","Liberia","Lesotho",
    "Lithuania","Luxembourg","Latvia","Libya","Morocco","Monaco","Moldova","Montenegro","St. Martin","Madagascar",
    "Marshall Islands","Macedonia (FYROM)","Mali","Myanmar (Burma)","Mongolia","Macau","Northern Mariana Islands",
    "Martinique","Mauritania","Montserrat","Malta","Mauritius","Maldives","Malawi","Mexico","Malaysia","Mozambique",
    "Namibia","New Caledonia","Niger","Norfolk Island","Nigeria","Nicaragua","Netherlands","Norway","Nepal","Nauru",
    "Niue","New Zealand","Oman","Panama","Peru","French Polynesia","Papua New Guinea","Philippines","Pakistan",
    "Poland","St. Pierre & Miquelon","Pitcairn Islands","Puerto Rico","Palestine","Portugal","Palau","Paraguay",
    "Qatar","Réunion","Romania","Serbia","Russia","Rwanda","Saudi Arabia","Solomon Islands","Seychelles","Sweden",
    "Singapore","St. Helena","Slovenia","Svalbard & Jan Mayen","Slovakia","Sierra Leone","San Marino","Senegal",
    "Somalia","Suriname","South Sudan","São Tomé & Príncipe","El Salvador","Sint Maarten","Swaziland",
    "Tristan da Cunha","Turks & Caicos Islands","Chad","French Southern Territories","Togo","Thailand",
    "Tajikistan","Tokelau","Timor-Leste","Turkmenistan","Tunisia","Tonga","Turkey","Trinidad & Tobago","Tuvalu",
    "Taiwan","Tanzania","Ukraine","Uganda","U.S. Outlying Islands","United States","Uruguay","Uzbekistan",
    "Vatican City","St. Vincent & Grenadines","Venezuela","British Virgin Islands","U.S. Virgin Islands","Vietnam",
    "Vanuatu","Wallis & Futuna","Samoa","Kosovo","Yemen","Mayotte","South Africa","Zambia","Zimbabwe"];
  SingleValueDropDownController selectedCounrtyCitizen = SingleValueDropDownController();
  List<String> counrtyResidentList = ["INDIA", "United States", "EUROPEAN UNION", "Rest of World"];
  SingleValueDropDownController selectedCounrtyResident = SingleValueDropDownController();
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
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: DropdownButtonHideUnderline(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                              ),
                            ),
                          ),
                          Positioned(
                            left: localWidth * 0.038,
                            child: Container(
                              color: Colors.white,
                              child: Text(
                                AppLocalizations.of(context)!.gender,
                                style: TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
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
                                padding: const EdgeInsets.only(left: 30, right: 30),
                                child: DropdownButtonHideUnderline(
                                  child:  DropDownTextField(
                                    controller: selectedCounrtyCitizen,
                                    clearOption: true,
                                    enableSearch: true,
                                    textFieldDecoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                        hintText: "Enter Country"),
                                    clearIconProperty: IconProperty(color: const Color.fromRGBO(102, 102, 102, 0.3)),
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
                                    dropDownItemCount: 5,
                                    dropDownList: [
                                      for(int i =0 ; i<=n; i++)
                                        DropDownValueModel(name: counrtyCitizenList[i], value: counrtyCitizenList[i])
                                    ],
                                    onChanged: (value) {
                                    },
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
                                    color: const Color.fromRGBO(51, 51, 51, 1),
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
                                padding: const EdgeInsets.only(left: 30, right: 30),
                                child: DropdownButtonHideUnderline(
                                  child: DropDownTextField(
                                    controller: selectedCounrtyResident,
                                    clearOption: true,
                                    enableSearch: true,
                                    textFieldDecoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(color: const Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: localHeight * 0.016),
                                        hintText: "Enter Country"),
                                    clearIconProperty: IconProperty(color: const Color.fromRGBO(102, 102, 102, 0.3)),
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
                                    dropDownItemCount: 5,
                                    dropDownList: [
                                      DropDownValueModel(name: counrtyResidentList[0], value: counrtyResidentList[0]),
                                      DropDownValueModel(name: counrtyResidentList[1], value: counrtyResidentList[1]),
                                      DropDownValueModel(name: counrtyResidentList[2], value: counrtyResidentList[2]),
                                      DropDownValueModel(name: counrtyResidentList[3], value: counrtyResidentList[3])
                                    ],
                                    onChanged: (value) {
                                    },
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
                                'COUNTRY RESIDENT',
                                style: TextStyle(
                                    color: const Color.fromRGBO(51, 51, 51, 1),
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
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
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
                            RichText(
                                text:  TextSpan(children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.agree_msg,
                                    style: const TextStyle(fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),
                                  ),
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
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.and,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.terms,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        decoration:
                                        TextDecoration.underline,
                                        color: Color.fromRGBO(82, 165, 160, 1),
                                        fontFamily: "Inter"),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.services,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontFamily: "Inter"),),
                                ])
                            ),
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
                  QnaService.sendOtp('kkkl');
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const TeacherRegistrationOtpPage()
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