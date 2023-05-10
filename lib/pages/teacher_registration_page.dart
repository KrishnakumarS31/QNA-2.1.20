import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:qna_test/Pages/teacher_registration_verify_page.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/custom_http_response.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/student_registration_model.dart';
import '../Services/qna_service.dart';

class TeacherRegistrationPage extends StatefulWidget {
  const TeacherRegistrationPage({super.key});

  @override
  TeacherRegistrationPageState createState() => TeacherRegistrationPageState();
}

class TeacherRegistrationPageState extends State<TeacherRegistrationPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController teacherFirstNameController = TextEditingController();
  TextEditingController teacherLastNameController = TextEditingController();
  SingleValueDropDownController studentNationalityController =
      SingleValueDropDownController();
  TextEditingController teacherEmailController = TextEditingController();
  TextEditingController teacherRollNumberController = TextEditingController();
  TextEditingController teacherOrganisationNameController =
      TextEditingController();
  TextEditingController teacherIsTeacherController = TextEditingController();
  TextEditingController teacherPasswordController = TextEditingController();
  TextEditingController teacherconfirmPasswordController =
      TextEditingController();
  // bool tocCheck = false;
  // bool also = false;
  bool pPCheck = false;
  bool error = true;
  String? gender;
  final teacherDobController = TextEditingController();
  late Response userDetails;
  int n = 244;
  List<String> countryCitizenList = [
    "India",
    "Ascension Island",
    "Andorra",
    "United Arab Emirates",
    "Antigua & Barbuda",
    "Anguilla",
    "Albania",
    "Armenia",
    "Angola",
    "Antarctica",
    "Argentina",
    "American Samoa",
    "Austria",
    "Australia",
    "Aruba",
    "Åland Islands",
    "Azerbaijan",
    "Bosnia & Herzegovina",
    "Barbados",
    "Bangladesh",
    "Belgium",
    "Burkina Faso",
    "Bulgaria",
    "Bahrain",
    "Burundi",
    "Benin",
    "St. Barthélemy",
    "Bermuda",
    "Brunei",
    "Bolivia",
    "Caribbean Netherlands",
    "Brazil",
    "Bahamas",
    "Bhutan",
    "Bouvet Island",
    "Botswana",
    "Belarus",
    "Belize",
    "Canada",
    "Cocos (Keeling) Islands",
    "Congo (DRC)",
    "Central African Republic",
    "Congo (Republic)",
    "Switzerland",
    "Côte d’Ivoire",
    "Cook Islands",
    "Chile",
    "Cameroon",
    "Colombia",
    "Costa Rica",
    "Cape Verde",
    "Curaçao",
    "Christmas Island",
    "Cyprus",
    "Czech Republic",
    "Germany",
    "Djibouti",
    "Denmark",
    "Dominica",
    "Dominican Republic",
    "Algeria",
    "Ecuador",
    "Estonia",
    "Egypt",
    "Western Sahara",
    "Eritrea",
    "Spain",
    "Ethiopia",
    "Finland",
    "Fiji",
    "Falkland Islands (Islas Malvinas)",
    "Micronesia",
    "Faroe Islands",
    "France",
    "Gabon",
    "United Kingdom",
    "Grenada",
    "Georgia",
    "French Guiana",
    "Guernsey",
    "Ghana",
    "Gibraltar",
    "Greenland",
    "Gambia",
    "Guinea",
    "Guadeloupe",
    "Equatorial Guinea",
    "Greece",
    "South Georgia & South Sandwich Islands",
    "Guatemala",
    "Guam",
    "Guinea-Bissau",
    "Guyana",
    "Hong Kong",
    "Heard & McDonald Islands",
    "Honduras",
    "Croatia",
    "Haiti",
    "Hungary",
    "Indonesia",
    "Ireland",
    "Israel",
    "Isle of Man",
    "India",
    "British Indian Ocean Territory",
    "Iraq",
    "Iceland",
    "Italy",
    "Jersey",
    "Jamaica",
    "Jordan",
    "Japan",
    "Kenya",
    "Kyrgyzstan",
    "Cambodia",
    "Kiribati",
    "Comoros",
    "St. Kitts & Nevis",
    "South Korea",
    "Kuwait",
    "Cayman Islands",
    "Kazakhstan",
    "Laos",
    "Lebanon",
    "St. Lucia",
    "Liechtenstein",
    "Sri Lanka",
    "Liberia",
    "Lesotho",
    "Lithuania",
    "Luxembourg",
    "Latvia",
    "Libya",
    "Morocco",
    "Monaco",
    "Moldova",
    "Montenegro",
    "St. Martin",
    "Madagascar",
    "Marshall Islands",
    "Macedonia (FYROM)",
    "Mali",
    "Myanmar (Burma)",
    "Mongolia",
    "Macau",
    "Northern Mariana Islands",
    "Martinique",
    "Mauritania",
    "Montserrat",
    "Malta",
    "Mauritius",
    "Maldives",
    "Malawi",
    "Mexico",
    "Malaysia",
    "Mozambique",
    "Namibia",
    "New Caledonia",
    "Niger",
    "Norfolk Island",
    "Nigeria",
    "Nicaragua",
    "Netherlands",
    "Norway",
    "Nepal",
    "Nauru",
    "Niue",
    "New Zealand",
    "Oman",
    "Panama",
    "Peru",
    "French Polynesia",
    "Papua New Guinea",
    "Philippines",
    "Pakistan",
    "Poland",
    "St. Pierre & Miquelon",
    "Pitcairn Islands",
    "Puerto Rico",
    "Palestine",
    "Portugal",
    "Palau",
    "Paraguay",
    "Qatar",
    "Réunion",
    "Romania",
    "Serbia",
    "Russia",
    "Rwanda",
    "Saudi Arabia",
    "Solomon Islands",
    "Seychelles",
    "Sweden",
    "Singapore",
    "St. Helena",
    "Slovenia",
    "Svalbard & Jan Mayen",
    "Slovakia",
    "Sierra Leone",
    "San Marino",
    "Senegal",
    "Somalia",
    "Suriname",
    "South Sudan",
    "São Tomé & Príncipe",
    "El Salvador",
    "Sint Maarten",
    "Swaziland",
    "Tristan da Cunha",
    "Turks & Caicos Islands",
    "Chad",
    "French Southern Territories",
    "Togo",
    "Thailand",
    "Tajikistan",
    "Tokelau",
    "Timor-Leste",
    "Turkmenistan",
    "Tunisia",
    "Tonga",
    "Turkey",
    "Trinidad & Tobago",
    "Tuvalu",
    "Taiwan",
    "Tanzania",
    "Ukraine",
    "Uganda",
    "U.S. Outlying Islands",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vatican City",
    "St. Vincent & Grenadines",
    "Venezuela",
    "British Virgin Islands",
    "U.S. Virgin Islands",
    "Vietnam",
    "Vanuatu",
    "Wallis & Futuna",
    "Samoa",
    "Kosovo",
    "Yemen",
    "Mayotte",
    "South Africa",
    "Zambia",
    "Zimbabwe"
  ];
  SingleValueDropDownController selectedCountryCitizen =
      SingleValueDropDownController();
  List<String> countryResidentList = [
    "India",
    "United States",
    "European Union",
    "Rest of World"
  ];
  SingleValueDropDownController selectedCountryResident =
      SingleValueDropDownController();
  int d = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    teacherDobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery.of(context).size.width;
    double localHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
            centerTitle: true,
            title: const Text(
              "TEACHER REGISTRATION",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 18.0,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
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
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                              child: TextFormField(
                                controller: teacherFirstNameController,
                                maxLength: 100,
                                maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .first_name_caps,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: localHeight * 0.018),
                                    ),
                                    TextSpan(
                                        text: "\t*",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                219, 35, 35, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.018)),
                                  ])),
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintText: AppLocalizations.of(context)!
                                      .first_name_hint,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  formKey.currentState!.validate();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter First Name';
                                  } else {
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
                              child: TextFormField(
                                controller: teacherLastNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  label: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .last_name_caps,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: localHeight * 0.018),
                                    ),
                                    TextSpan(
                                        text: "\t*",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                219, 35, 35, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.018)),
                                  ])),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: TextStyle(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: localHeight * 0.012),
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintText: AppLocalizations.of(context)!
                                      .last_name_hint,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  formKey.currentState!.validate();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Last Name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: localHeight * 0.03,
                            ),
                            MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                              onTap: () async {
                                var pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary:
                                              Color.fromRGBO(82, 165, 160, 1),
                                          onPrimary: Colors.white,
                                          onSurface:
                                              Colors.black, // <-- SEE HERE
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                const Color.fromRGBO(
                                                    82, 165, 160, 1),
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                final DateFormat formatter =
                                    DateFormat('dd/MM/yyyy');
                                final String formatted =
                                    formatter.format(pickedDate!);
                                d = pickedDate.microsecondsSinceEpoch;
                                teacherDobController.text = formatted;
                                formKey.currentState!.validate();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: teacherDobController,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .dob_caps,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.018),
                                      ),
                                      TextSpan(
                                          text: "\t*",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.018)),
                                    ])),
                                    hintStyle: TextStyle(
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 0.3),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: localHeight * 0.016),
                                    hintText: AppLocalizations.of(context)!
                                        .dob_format,
                                    suffixIcon: const Icon(
                                      Icons.calendar_today_outlined,
                                      color: Color.fromRGBO(141, 167, 167, 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                82, 165, 160, 1)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Date Of Birth';
                                    } else {
                                      return null;
                                    }
                                  },
                                  enabled: true,
                                  onChanged: (value) {},
                                ),
                              ),
                            )),
                            SizedBox(
                              height: localHeight * 0.03,
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 7),
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
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: DropdownButtonHideUnderline(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: "male",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value..toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .male,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      localHeight * 0.014),
                                            ),
                                            Radio(
                                              value: "female",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .female,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      localHeight * 0.014),
                                            ),
                                            Radio(
                                              value: "others",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .others,
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      localHeight * 0.014),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left:
                                  constraints.maxWidth > 700
                                      ? localWidth * 0.009
                                      : localWidth * 0.025,
                                  child: Container(
                                    color: Colors.white,
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .gender,
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.015),
                                      ),
                                      TextSpan(
                                          text: "\t*\t",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.016)),
                                    ])),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: localHeight * 0.03,
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 7),
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
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      child: DropdownButtonHideUnderline(
                                        child: DropDownTextField(
                                          controller: selectedCountryCitizen,
                                          clearOption: true,
                                          enableSearch: true,
                                          textFieldDecoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      localHeight * 0.016),
                                              hintText: "Enter Country"),
                                          clearIconProperty: IconProperty(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3)),
                                          searchDecoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      localHeight * 0.016),
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
                                            for (int i = 0; i <= n; i++)
                                              DropDownValueModel(
                                                  name: countryCitizenList[i],
                                                  value: countryCitizenList[i])
                                          ],
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left:
                                  constraints.maxWidth > 700
                                      ? localWidth * 0.009
                                      : localWidth * 0.025,
                                  child: Container(
                                    color: Colors.white,
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: "\tCOUNTRY CITIZEN",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.014),
                                      ),
                                      TextSpan(
                                          text: "\t*\t",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.016)),
                                    ])),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: localHeight * 0.03,
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 7),
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
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      child: DropdownButtonHideUnderline(
                                        child: DropDownTextField(
                                          controller: selectedCountryResident,
                                          clearOption: true,
                                          enableSearch: true,
                                          textFieldDecoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      localHeight * 0.016),
                                              hintText: "Enter Country"),
                                          clearIconProperty: IconProperty(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 0.3)),
                                          searchDecoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      102, 102, 102, 0.3),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      localHeight * 0.016),
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
                                            DropDownValueModel(
                                                name: countryResidentList[0],
                                                value: countryResidentList[0]),
                                            DropDownValueModel(
                                                name: countryResidentList[1],
                                                value: countryResidentList[1]),
                                            DropDownValueModel(
                                                name: countryResidentList[2],
                                                value: countryResidentList[2]),
                                            DropDownValueModel(
                                                name: countryResidentList[3],
                                                value: countryResidentList[3])
                                          ],
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left:
                                  constraints.maxWidth > 700
                                      ? localWidth * 0.009
                                      : localWidth * 0.025,
                                  child: Container(
                                    color: Colors.white,
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: '\tCOUNTRY RESIDENT',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.014),
                                      ),
                                      TextSpan(
                                          text: "\t*",
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  219, 35, 35, 1),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: localHeight * 0.016)),
                                    ])),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: localHeight * 0.03,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                controller: teacherEmailController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .email_id_caps,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: localHeight * 0.018),
                                    ),
                                    TextSpan(
                                        text: "\t*",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                219, 35, 35, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.018)),
                                  ])),
                                  helperText: 'an OTP will be sent to Email ID',
                                  labelStyle: TextStyle(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: localHeight * 0.012),
                                  helperStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintText: "emailID@email.com",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  formKey.currentState!.validate();
                                },
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .error_regID;
                                  } else {
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
                              child: TextFormField(
                                controller: teacherRollNumberController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .reg_roll_caps,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: localHeight * 0.018),
                                    ),
                                    // TextSpan(
                                    //     text: "\t*",
                                    //     style: TextStyle(
                                    //         color: const Color.fromRGBO(
                                    //             219, 35, 35, 1),
                                    //         fontFamily: 'Inter',
                                    //         fontWeight: FontWeight.w600,
                                    //         fontSize: localHeight * 0.018)),
                                  ])),
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintText: 'Registration ID',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  formKey.currentState!.validate();
                                },
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Enter Roll Number';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                            SizedBox(
                              height: localHeight * 0.03,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                controller: teacherOrganisationNameController,
                                maxLength: 200,
                                maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .ins_org_caps,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: localHeight * 0.018),
                                    ),
                                    TextSpan(
                                        text: "\t*",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                219, 35, 35, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.018)),
                                  ])),
                                  labelStyle: TextStyle(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: localHeight * 0.012),
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintText:
                                      AppLocalizations.of(context)!.ins_org,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  formKey.currentState!.validate();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Organization Name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: localHeight * 0.02,
                            ),
                            // Row(children: [
                            //   Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Checkbox(
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(10)),
                            //       value: tocCheck,
                            //       onChanged: (val) {
                            //         setState(() {
                            //           tocCheck = val!;
                            //           if (tocCheck) {
                            //             also = true;
                            //           }
                            //         });
                            //       },
                            //     ),
                            //   ),
                            //   const Text(
                            //     'Register me also as STUDENT',
                            //     style: TextStyle(
                            //         fontSize: 17.0,
                            //         fontWeight: FontWeight.w600,
                            //         color: Color.fromRGBO(102, 102, 102, 1),
                            //         fontFamily: "Inter"),
                            //   ),
                            // ]),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppLocalizations.of(context)!.create_pass,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Inter"),
                                )),
                            SizedBox(
                              height: localHeight * 0.02,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                controller: teacherPasswordController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .password_caps,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: localHeight * 0.017),
                                    ),
                                    TextSpan(
                                        text: "\t*",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                219, 35, 35, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.017)),
                                  ])),
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintText: AppLocalizations.of(context)!
                                      .password_hint,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  formKey.currentState!.validate();
                                },
                                validator: (value) {
                                  if (value!.length < 8) {
                                    return "Enter Minimum 8 Characters";
                                  } else {
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
                              child: TextFormField(
                                controller: teacherconfirmPasswordController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  label: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .confirm_password,
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              102, 102, 102, 1),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: localHeight * 0.017),
                                    ),
                                    TextSpan(
                                        text: "\t*",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                219, 35, 35, 1),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: localHeight * 0.017)),
                                  ])),
                                  hintStyle: TextStyle(
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 0.3),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: localHeight * 0.016),
                                  hintText: AppLocalizations.of(context)!
                                      .verify_password,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(82, 165, 160, 1)),
                                      borderRadius: BorderRadius.circular(15)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onChanged: (value) {
                                  formKey.currentState!.validate();
                                },
                                validator: (value) {
                                  if (teacherPasswordController.text !=
                                      teacherconfirmPasswordController.text) {
                                    return 'Re-enter exact same password';
                                  } else if (value!.isEmpty) {
                                    return 'Re-enter exact same password';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        //SizedBox(height:localHeight * 0.05),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: localHeight * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: localWidth * 0.1),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)!.pri_terms,
                          style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter"),
                        )),
                  ),
                  SizedBox(
                    height: localHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: localWidth * 0.08),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1)),
                            value: pPCheck,
                            onChanged: (val) {
                              setState(() {
                                pPCheck = val!;
                                if (pPCheck) {}
                              });
                            },
                          ),
                          Flexible(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.agree_msg,
                                style:  TextStyle(
                                    fontSize: localHeight * 0.02,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.privacy_Policy,
                                style:  TextStyle(
                                    fontSize: localHeight * 0.02,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!.and,
                                style:  TextStyle(
                                    fontSize: localHeight * 0.02,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!.terms,
                                style:  TextStyle(
                                    fontSize: localHeight * 0.02,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(82, 165, 160, 1),
                                    fontFamily: "Inter"),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!.services,
                                style:  TextStyle(
                                    fontSize: localHeight * 0.02,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                    fontFamily: "Inter"),
                              ),
                            ])),
                          ),
                        ]),
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
                      onPressed: () async {
                        bool valid = formKey.currentState!.validate();
                        StudentRegistrationModel student =
                        StudentRegistrationModel(
                            firstName: teacherFirstNameController.text,
                            lastName: teacherLastNameController.text,
                            dob: d,
                            gender: gender,
                            countryNationality: selectedCountryCitizen
                                .dropDownValue?.value,
                            email: teacherEmailController.text,
                            password: teacherPasswordController.text,
                            rollNumber: teacherRollNumberController.text,
                            organisationName:
                            teacherOrganisationNameController.text,
                            countryResident:
                            selectedCountryResident
                                .dropDownValue?.value,
                            role:
                            //also == true ?
                            ["teacher","student"]
                               // : ["teacher"]
                        );
                        if (pPCheck) {
                        bool valid = formKey.currentState!.validate();
                        if (valid) {
                          LoginModel res =
                              await QnaService.postUserDetailsService(student);
                          if (res.code == 200) {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: TeacherRegistrationOtpPage(
                                    email: student.email,
                                  )),
                            );
                          } else {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CustomDialog(
                                  title: 'Incorrect Data',
                                  content: '${res.message}',
                                  button: AppLocalizations.of(context)!.retry,
                                ),
                              ),
                            );
                          }
                        }
                      }
                        else {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CustomDialog(
                                  title: AppLocalizations.of(context)!
                                      .agree_privacy_terms,
                                  content: AppLocalizations.of(context)!.error,
                                  button: AppLocalizations.of(context)!.retry),
                            ),
                          );
                        }
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
          ),
          //)
        ));
  }
    );}}
