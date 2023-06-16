import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/custom_http_response.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/student_registration_model.dart';
import '../Services/qna_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({super.key});

  @override
  StudentRegistrationPageState createState() => StudentRegistrationPageState();
}

class StudentRegistrationPageState extends State<StudentRegistrationPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController studentFirstNameController = TextEditingController();
  TextEditingController studentLastNameController = TextEditingController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentRollNumberController = TextEditingController();
  TextEditingController studentOrganisationNameController =
      TextEditingController();
  TextEditingController studentIsTeacherController = TextEditingController();
  TextEditingController studentPasswordController = TextEditingController();
  TextEditingController studentconfirmPasswordController =
      TextEditingController();
  // bool tocCheck = false;
  bool pPCheck = false;
  // bool also = false;
  bool error = true;
  String? gender;
  // final studentDobController = TextEditingController();
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
    // studentDobController.dispose();
    super.dispose();
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
                                                        width: localWidth * 0.8,
                                                      child: TextFormField(
                                                    controller: studentFirstNameController,
                                                    maxLength: 100,
                                                    maxLengthEnforcement: MaxLengthEnforcement
                                                        .truncateAfterCompositionEnds,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      label:
                                                      Text(AppLocalizations.of(
                                                                  context)!
                                                                  .first_name_caps,
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
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: localHeight * 0.018),
                                                      hintText: AppLocalizations.of(
                                                          context)!
                                                          .enter_here,
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                  )),
                                                ),

                                  Center(
                                    child:
                                    SizedBox(
                                      width: localWidth * 0.8,
                                      child: TextFormField(
                                                    controller: studentLastNameController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      label: Text(AppLocalizations.of(
                                                                  context)!
                                                                  .last_name_caps,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  fontSize: localHeight *
                                                                      0.020),),
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: localHeight * 0.018),
                                                      hintText: AppLocalizations.of(
                                                          context)!
                                                          .enter_here,
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
                                                )),
                                                SizedBox(
                                                  height: localHeight * 0.03,
                                                ),
                                                // MouseRegion(
                                                //     cursor: SystemMouseCursors.click,
                                                //     child: GestureDetector(
                                                //   onTap: () async {
                                                //     var pickedDate = await showDatePicker(
                                                //       context: context,
                                                //       initialDate: DateTime.now(),
                                                //       firstDate: DateTime(1900),
                                                //       lastDate: DateTime.now(),
                                                //       builder: (context, child) {
                                                //         return Theme(
                                                //           data: Theme.of(context).copyWith(
                                                //             colorScheme: const ColorScheme.light(
                                                //               primary:
                                                //                   Color.fromRGBO(82, 165, 160, 1),
                                                //               onPrimary: Colors.white,
                                                //               onSurface:
                                                //                   Colors.black, // <-- SEE HERE
                                                //             ),
                                                //             textButtonTheme: TextButtonThemeData(
                                                //               style: TextButton.styleFrom(
                                                //                 foregroundColor:
                                                //                     const Color.fromRGBO(
                                                //                         82, 165, 160, 1),
                                                //               ),
                                                //             ),
                                                //           ),
                                                //           child: child!,
                                                //         );
                                                //       },
                                                //     );
                                                //     // formKey.currentState!.validate();
                                                //     // final DateFormat formatter =
                                                //     //     DateFormat('dd/MM/yyyy');
                                                //     // final String formatted =
                                                //     //     formatter.format(pickedDate!);
                                                //     // d = pickedDate.microsecondsSinceEpoch;
                                                //    // studentDobController.text = formatted;
                                                //     //formKey.currentState!.validate();
                                                //   },
                                                //   child: AbsorbPointer(
                                                //     child: TextFormField(
                                                //       controller: studentDobController,
                                                //       keyboardType: TextInputType.datetime,
                                                //       decoration: InputDecoration(   
                                                //labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                //         floatingLabelBehavior:
                                                //             FloatingLabelBehavior.always,
                                                //         label: RichText(
                                                //             text: TextSpan(children: [
                                                //           TextSpan(
                                                //             text: AppLocalizations.of(context)!
                                                //                 .dob_caps,
                                                //             style: TextStyle(
                                                //                 color: const Color.fromRGBO(
                                                //                     102, 102, 102, 1),
                                                //                 fontFamily: 'Inter',
                                                //                 fontWeight: FontWeight.w600,
                                                //                 fontSize: localHeight * 0.018),
                                                //           ),
                                                //           TextSpan(
                                                //               text: "\t*",
                                                //               style: TextStyle(
                                                //                   color: const Color.fromRGBO(
                                                //                       219, 35, 35, 1),
                                                //                   fontFamily: 'Inter',
                                                //                   fontWeight: FontWeight.w600,
                                                //                   fontSize: localHeight * 0.018)),
                                                //         ])),
                                                //         hintStyle: TextStyle(
                                                //             color: const Color.fromRGBO(
                                                //                 102, 102, 102, 0.3),
                                                //             fontFamily: 'Inter',
                                                //             fontWeight: FontWeight.w400,
                                                //             fontSize: localHeight * 0.016),
                                                //         hintText: AppLocalizations.of(context)!
                                                //             .dob_format,
                                                //         suffixIcon: const Icon(
                                                //           Icons.calendar_today_outlined,
                                                //           color: Color.fromRGBO(141, 167, 167, 1),
                                                //         ),
                                                //         focusedBorder: OutlineInputBorder(
                                                //             borderSide: const BorderSide(
                                                //                 color: Color.fromRGBO(
                                                //                     82, 165, 160, 1)),
                                                //             borderRadius:
                                                //                 BorderRadius.circular(15)),
                                                //         border: OutlineInputBorder(
                                                //             borderRadius:
                                                //                 BorderRadius.circular(15)),
                                                //       ),
                                                //       onChanged: (value) {
                                                //         formKey.currentState!.validate();
                                                //       },
                                                //       validator: (value) {
                                                //         if (value!.isEmpty) {
                                                //           return 'Enter Date Of Birth';
                                                //         } else {
                                                //           return null;
                                                //         }
                                                //       },
                                                //       enabled: true,
                                                //     ),
                                                //   ),
                                                // )),
                                                // SizedBox(
                                                //   height: localHeight * 0.03,
                                                // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child:
                                                Column(
                                                  children: [
                                                    Row(
                                                      children:[
                                                        Text(AppLocalizations.of(
                                                            context)!
                                                            .gender,
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102, 102, 102, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: localHeight *
                                                                  0.020),),
                                          ]
                                                    ),
                                                    Row(
                                                              children: [
                                                                Radio(
                                                                  value: "male",
                                                                  groupValue: gender,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      gender =
                                                                      value..toString();
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .male,
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          51, 51, 51, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      localHeight * 0.016),
                                                                ),
                                                                Radio(
                                                                  value: "female",
                                                                  groupValue: gender,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      gender =
                                                                          value.toString();
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .female,
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          51, 51, 51, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      localHeight * 0.016),
                                                                ),
                                                                Radio(
                                                                  value: "others",
                                                                  groupValue: gender,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      gender =
                                                                          value.toString();
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .others,
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          51, 51, 51, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      localHeight * 0.016),
                                                                ),
                                                              ],
                                                            ),
                                                  ],
                                                )),
                                                SizedBox(
                                                  height: localHeight * 0.03,
                                                ),
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 30, right: 30, top: 13),
                                                      child: DropDownTextField(
                                                              controller: selectedCountryCitizen,
                                                              clearOption: true,
                                                              enableSearch: true,
                                                              textFieldDecoration: InputDecoration(   
                                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                                  floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                                  hintStyle: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          102, 102, 102,
                                                                          0.3),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      localHeight * 0.018),
                                                                  hintText: AppLocalizations.of(
                                                                      context)!
                                                                      .enter_here),
                                                              clearIconProperty: IconProperty(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 0.3)),
                                                              searchDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                                  hintStyle: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          102, 102, 102,
                                                                          0.3),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      localHeight * 0.016),
                                                                  hintText: AppLocalizations.of(
                                                                      context)!
                                                                      .enter_here),
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
                                                    Positioned(
                                                      left: localWidth * 0.05,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                  context)!
                                                                  .country_citizen,
                                                              //"Citizen of Country",
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  fontSize: localHeight *
                                                                      0.016),
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
                                                      const EdgeInsets.only(
                                                          left: 30, right: 30, top: 25),
                                                      child: DropDownTextField(
                                                              controller: selectedCountryResident,
                                                              clearOption: true,
                                                              enableSearch: true,
                                                              textFieldDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                                  floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                                  hintStyle: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          102, 102, 102,
                                                                          0.3),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      localHeight * 0.018),
                                                                  hintText: AppLocalizations.of(
                                                                      context)!
                                                                      .enter_here),
                                                              clearIconProperty: IconProperty(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 0.3)),
                                                              searchDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                                  hintStyle: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          102, 102, 102,
                                                                          0.3),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      fontSize:
                                                                      localHeight * 0.018),
                                                                  hintText: AppLocalizations.of(
                                                                      context)!
                                                                      .enter_here),
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
                                                    Positioned(
                                                      left: localWidth * 0.05,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                    context)!
                                                                    .country_resident,
                                                            //Resident of Country
                                                        style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        102, 102, 102, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight
                                                                        .w600,
                                                                    fontSize: localHeight *
                                                                        0.016),
                                                              ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: localHeight * 0.03,
                                                ),
                                                Center(
                                                    child:
                                                    SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:TextFormField(
                                                        controller: studentOrganisationNameController,
                                                        maxLength: 200,
                                                        maxLengthEnforcement: MaxLengthEnforcement
                                                            .truncateAfterCompositionEnds,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            label: Text(AppLocalizations.of(
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
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText:
                                                            AppLocalizations.of(
                                                                context)!
                                                                .enter_here
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
                                                    )),
                                  Center(
                                    child:
                                    SizedBox(
                                      width: localWidth * 0.8,
                                      child: TextFormField(
                                                    controller: studentRollNumberController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      label: RichText(
                                                          text: TextSpan(children: [
                                                            TextSpan(
                                                              text: AppLocalizations.of(
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
                                                            TextSpan(
                                                              text: AppLocalizations.of(
                                                                  context)!
                                                                  .optional,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  fontStyle: FontStyle.italic,
                                                                  fontSize: localHeight *
                                                                      0.020),
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
                                                      // labelStyle: TextStyle(
                                                      //     color:
                                                      //     const Color.fromRGBO(
                                                      //         51, 51, 51, 1),
                                                      //     fontFamily: 'Inter',
                                                      //     fontWeight: FontWeight.w600,
                                                      //     fontSize: localHeight * 0.018),
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: localHeight * 0.018),
                                                      hintText:
                                                      AppLocalizations.of(
                                                          context)!
                                                          .enter_here,
                                                    ),
                                                    onChanged: (value) {
                                                      formKey.currentState!.validate();
                                                    },

                                                  )),
                                                ),
                                                SizedBox(
                                                  height: localHeight * 0.03,
                                                ),
                                                Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.8,
                                                        child:
                                                        TextFormField(
                                                          controller: studentEmailController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            label: Text(
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .email_id_caps,
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
                                                            helperText:
                                                            AppLocalizations.of(
                                                                context)!.email_helper_text,
                                                            //'an OTP will be sent to Email ID',
                                                            // labelStyle: TextStyle(
                                                            //     color:
                                                            //     const Color.fromRGBO(
                                                            //         51, 51, 51, 1),
                                                            //     fontFamily: 'Inter',
                                                            //     fontWeight: FontWeight.w600,
                                                            //     fontSize: localHeight * 0.016),
                                                            helperStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontStyle: FontStyle.italic,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
                                                          ),
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },
                                                          validator: (value) {
                                                            if (value!.isEmpty ||
                                                                !RegExp(
                                                                    r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                                    .hasMatch(value)) {
                                                              return 'Enter Valid Email';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ))),
                                                SizedBox(
                                                  height: localHeight * 0.01,
                                                ),
                                  Center(
                                    child:
                                    SizedBox(
                                      width: localWidth * 0.8,
                                      child: TextFormField(
                                                    controller: studentPasswordController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      label: Text(AppLocalizations.of(
                                                                  context)!
                                                                  .password_caps,
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
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: localHeight * 0.018),
                                                      hintText: AppLocalizations.of(
                                                          context)!
                                                          .enter_here,
                                                    ),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.deny(' ')
                                                    ],
                                                    onChanged: (val) {
                                                      formKey.currentState!.validate();
                                                    },
                                                    validator: (value) {
                                                      if (value!.length < 8) {
                                                        return "Enter Minimum 8 Characters";
                                                      } else {
                                                        return null;
                                                      }
                                                    },

                                                  ))
                                                ),
                                                SizedBox(
                                                  height: localHeight * 0.03,
                                                ),
                                  Center(
                                    child:
                                    SizedBox(
                                      width: localWidth * 0.8,
                                      child: TextFormField(
                                                    controller: studentconfirmPasswordController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.always,
                                                      label: Text(AppLocalizations.of(
                                                                  context)!
                                                                  .confirm_password,
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
                                                      hintStyle: TextStyle(
                                                          color: const Color.fromRGBO(
                                                              102, 102, 102, 0.3),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: localHeight * 0.018),
                                                      hintText: AppLocalizations.of(
                                                          context)!
                                                          .enter_here,
                                                    ),
                                                    onChanged: (value) {
                                                      formKey.currentState!.validate();
                                                    },
                                                    validator: (value) {
                                                      if (studentPasswordController.text !=
                                                          studentconfirmPasswordController
                                                              .text) {
                                                        return 'Re-enter exact same password';
                                                      } else if (value!.isEmpty) {
                                                        return 'Re-enter exact same password';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                  )),
                                            ),
                                                SizedBox(
                                                  height: localHeight * 0.03,
                                                ),
                                                Row(
                                                    children:[
                                                      SizedBox(width: localWidth * 0.05),
                                                      Text(
                                                        AppLocalizations.of(context)!
                                                            .pri_terms,
                                                        style: TextStyle(
                                                            fontSize: localHeight * 0.018,
                                                            color: const Color.fromRGBO(
                                                                102, 102, 102, 1),
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: "Inter"),
                                                      )
                                                    ]),
                                                SizedBox(
                                                  height: localHeight * 0.02,
                                                ),
                                                Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      SizedBox(width: localWidth * 0.03),
                                                      Transform.scale(
                                                          filterQuality: FilterQuality.high,
                                                          scale: 1.5,
                                                          child: Checkbox(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(1)),
                                                            value: pPCheck,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                pPCheck = val!;
                                                                if (pPCheck) {}
                                                              });
                                                            },
                                                          )),
                                                      SizedBox(width: localWidth * 0.01),
                                                      Flexible(
                                                        child: RichText(
                                                            text: TextSpan(children: [
                                                              TextSpan(
                                                                text: AppLocalizations.of(
                                                                    context)!
                                                                    .agree_msg,
                                                                style: TextStyle(
                                                                    fontSize: localHeight *
                                                                        0.018,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: "Inter"),
                                                              ),
                                                              TextSpan(
                                                                text: AppLocalizations.of(
                                                                    context)!
                                                                    .privacy_Policy,
                                                                recognizer: TapGestureRecognizer()
                                                                  ..onTap = _launchUrlPrivacy,
                                                                style: TextStyle(
                                                                    fontSize: localHeight *
                                                                        0.018,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    decoration: TextDecoration
                                                                        .underline,
                                                                    color:
                                                                    const Color.fromRGBO(
                                                                        82, 165, 160, 1),
                                                                    fontFamily: "Inter"),
                                                              ),
                                                              TextSpan(
                                                                text: AppLocalizations.of(
                                                                    context)!.and,
                                                                style: TextStyle(
                                                                    fontSize: localHeight *
                                                                        0.018,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    color:
                                                                    const Color.fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: "Inter"),
                                                              ),
                                                              TextSpan(
                                                                text: AppLocalizations.of(
                                                                    context)!.terms,
                                                                recognizer: TapGestureRecognizer()
                                                                  ..onTap = _launchUrlTerms,
                                                                style: TextStyle(
                                                                    fontSize: localHeight *
                                                                        0.018,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    decoration: TextDecoration
                                                                        .underline,
                                                                    color:
                                                                    const Color.fromRGBO(
                                                                        82, 165, 160, 1),
                                                                    fontFamily: "Inter"),
                                                              ),
                                                              TextSpan(
                                                                text: AppLocalizations.of(
                                                                    context)!
                                                                    .services,
                                                                recognizer: TapGestureRecognizer()
                                                                  ..onTap = _launchUrlTerms,
                                                                style: TextStyle(
                                                                    fontSize: localHeight *
                                                                        0.018,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    decoration: TextDecoration
                                                                        .underline,
                                                                    color:
                                                                    const Color.fromRGBO(
                                                                        82, 165, 160, 1),
                                                                    fontFamily: "Inter"),
                                                              ),
                                                            ])),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: localHeight * 0.03,
                                                ),
                                                Center(
                                                  child: IconButton(
                                                    iconSize: localHeight * 0.06,
                                                    icon: const Icon(Icons.arrow_circle_right,
                                                      color: Color.fromRGBO(
                                                          82, 165, 160, 1),
                                                    ),
                                                    onPressed: () async {
                                                      bool valid = formKey.currentState!.validate();
                                                      StudentRegistrationModel student =
                                                      StudentRegistrationModel(
                                                          firstName: studentFirstNameController.text,
                                                          lastName: studentLastNameController.text,
                                                          dob: 01010001,
                                                          gender: gender,
                                                          countryNationality: selectedCountryCitizen
                                                              .dropDownValue?.value,
                                                          email: studentEmailController.text,
                                                          password: studentPasswordController.text,
                                                          rollNumber: studentRollNumberController
                                                              .text,
                                                          organisationName:
                                                          studentOrganisationNameController.text,
                                                          countryResident:
                                                          selectedCountryResident
                                                              .dropDownValue?.value,
                                                          role: ["student"]
                                                        //also == true?
                                                        //["student","teacher"]
                                                        //: ["student"]
                                                      );
                                                      if (pPCheck) {
                                                        bool valid = formKey.currentState!.validate();
                                                        if (valid) {
                                                          LoginModel res =
                                                          await QnaService.postUserDetailsService(
                                                              student);
                                                          if (res.code == 200) {
                                                            if (context.mounted) {
                                                              Navigator.pushNamed(
                                                                context,
                                                                '/studentRegisVerifyOtpPage',
                                                                arguments: student,);
                                                            }
                                                            else if (res.code == 409) {
                                                              Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                  type: PageTransitionType
                                                                      .rightToLeft,
                                                                  child: CustomDialog(
                                                                    title: AppLocalizations.of(
                                                                        context)!.alert_popup,
                                                                    //'Incorrect Data',
                                                                    content: AppLocalizations.of(
                                                                        context)!
                                                                        .already_registered_user,
                                                                    button: AppLocalizations.of(
                                                                        context)!.ok_caps,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType.rightToLeft,
                                                                child: CustomDialog(
                                                                  title: AppLocalizations.of(context)!.alert_popup,
                                                                  //'Alert',
                                                                  content: '${res.message}',
                                                                  button: AppLocalizations.of(
                                                                      context)!.retry,
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
                                                                    .alert_popup,
                                                                content: AppLocalizations.of(context)!
                                                                    .agree_privacy_terms,
                                                                button: AppLocalizations.of(context)!
                                                                    .retry),
                                                          ),
                                                        );
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
                                                          controller: studentFirstNameController,
                                                          maxLength: 100,
                                                          maxLengthEnforcement: MaxLengthEnforcement
                                                              .truncateAfterCompositionEnds,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            label:
                                                            Text(AppLocalizations.of(
                                                                context)!
                                                                .first_name_caps,
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
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                        )),
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                        width: localWidth * 0.65,
                                                        child: TextFormField(
                                                          controller: studentLastNameController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            label: Text(AppLocalizations.of(
                                                                context)!
                                                                .last_name_caps,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  fontSize: localHeight *
                                                                      0.020),),
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
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
                                                      )),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 30, right: 30),
                                                      child:
                                                      Column(
                                                        children: [
                                                          Row(
                                                              children:[
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .gender,
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          102, 102, 102, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w600,
                                                                      fontSize: localHeight *
                                                                          0.018),
                                                                ),
                                                              ]
                                                          ),
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                value: "male",
                                                                groupValue: gender,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    gender =
                                                                    value..toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .male,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    localHeight * 0.016),
                                                              ),
                                                              Radio(
                                                                value: "female",
                                                                groupValue: gender,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    gender =
                                                                        value.toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .female,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    localHeight * 0.016),
                                                              ),
                                                              Radio(
                                                                value: "others",
                                                                groupValue: gender,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    gender =
                                                                        value.toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .others,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    localHeight * 0.016),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 30, right: 30, top: 15),
                                                        child: DropDownTextField(
                                                          controller: selectedCountryCitizen,
                                                          clearOption: true,
                                                          enableSearch: true,
                                                          textFieldDecoration: InputDecoration(
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
                                                          clearIconProperty: IconProperty(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102, 102, 102, 0.3)),
                                                          searchDecoration: InputDecoration(
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.016),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
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
                                                      Positioned(
                                                        left: localWidth * 0.025,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .country_citizen,
                                                          //"Citizen of Country",
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102, 102, 102, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: localHeight *
                                                                  0.016),
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
                                                        const EdgeInsets.only(
                                                            left: 30, right: 30, top: 15),
                                                        child: DropDownTextField(
                                                          controller: selectedCountryResident,
                                                          clearOption: true,
                                                          enableSearch: true,
                                                          textFieldDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
                                                          clearIconProperty: IconProperty(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102, 102, 102, 0.3)),
                                                          searchDecoration: InputDecoration(
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
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
                                                      Positioned(
                                                        left: localWidth * 0.025,
                                                        child: Container(
                                                          color: Colors.white,
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .country_resident,
                                                            //Resident of Country
                                                            style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    102, 102, 102, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.016),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                        width: localWidth * 0.65,
                                                        child:TextFormField(
                                                          controller: studentOrganisationNameController,
                                                          maxLength: 200,
                                                          maxLengthEnforcement: MaxLengthEnforcement
                                                              .truncateAfterCompositionEnds,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior.always,
                                                              label: Text(AppLocalizations.of(
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
                                                              hintStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintText:
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here
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
                                                      )),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.65,
                                                        child: TextFormField(
                                                          controller: studentRollNumberController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            label: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text: AppLocalizations.of(
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
                                                                      TextSpan(
                                                                        text: AppLocalizations.of(
                                                                            context)!
                                                                            .optional,
                                                                        style: TextStyle(
                                                                            color: const Color
                                                                                .fromRGBO(
                                                                                102, 102, 102, 1),
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontSize: localHeight *
                                                                                0.020),
                                                                      ),
                                                                ])),
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText:
                                                            AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
                                                          ),
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },

                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                          width: localWidth * 0.65,
                                                          child:
                                                          TextFormField(
                                                            controller: studentEmailController,
                                                            keyboardType: TextInputType.text,
                                                            decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior.always,
                                                              label: Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .email_id_caps,
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
                                                              helperText: AppLocalizations.of(
                                                                  context)!.email_helper_text,
                                                              //'an OTP will be sent to Email ID',
                                                              helperStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontStyle: FontStyle.italic,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here,
                                                            ),
                                                            onChanged: (value) {
                                                              formKey.currentState!.validate();
                                                            },
                                                            validator: (value) {
                                                              if (value!.isEmpty ||
                                                                  !RegExp(
                                                                      r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                                      .hasMatch(value)) {
                                                                return 'Enter Valid Email';
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                          ))),
                                                  SizedBox(
                                                    height: localHeight * 0.01,
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                          width: localWidth * 0.65,
                                                          child: TextFormField(
                                                            controller: studentPasswordController,
                                                            keyboardType: TextInputType.text,
                                                            decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior.always,
                                                              label: Text(AppLocalizations.of(
                                                                  context)!
                                                                  .password_caps,
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
                                                              hintStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here,
                                                            ),
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.deny(' ')
                                                            ],
                                                            onChanged: (val) {
                                                              formKey.currentState!.validate();
                                                            },
                                                            validator: (value) {
                                                              if (value!.length < 8) {
                                                                return "Enter Minimum 8 Characters";
                                                              } else {
                                                                return null;
                                                              }
                                                            },

                                                          ))
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.65,
                                                        child: TextFormField(
                                                          controller: studentconfirmPasswordController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            label: Text(AppLocalizations.of(
                                                                context)!
                                                                .confirm_password,
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
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
                                                          ),
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },
                                                          validator: (value) {
                                                            if (studentPasswordController.text !=
                                                                studentconfirmPasswordController
                                                                    .text) {
                                                              return 'Re-enter exact same password';
                                                            } else if (value!.isEmpty) {
                                                              return 'Re-enter exact same password';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Row(
                                                      children:[
                                                        SizedBox(width: localWidth * 0.025),
                                                        Text(
                                                          AppLocalizations.of(context)!
                                                              .pri_terms,
                                                          style: TextStyle(
                                                              fontSize: localHeight * 0.018,
                                                              color: const Color.fromRGBO(
                                                                  102, 102, 102, 1),
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: "Inter"),
                                                        )
                                                      ]),
                                                  SizedBox(
                                                    height: localHeight * 0.02,
                                                  ),
                                                  Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        SizedBox(width: localWidth * 0.03),
                                                        Transform.scale(
                                                            filterQuality: FilterQuality.high,
                                                            scale: 1.5,
                                                            child: Checkbox(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius
                                                                      .circular(1)),
                                                              value: pPCheck,
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  pPCheck = val!;
                                                                  if (pPCheck) {}
                                                                });
                                                              },
                                                            )),
                                                        SizedBox(width: localWidth * 0.01),
                                                        Flexible(
                                                          child: RichText(
                                                              text: TextSpan(children: [
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!
                                                                      .agree_msg,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          51, 51, 51, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!
                                                                      .privacy_Policy,
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = _launchUrlPrivacy,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      decoration: TextDecoration
                                                                          .underline,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          82, 165, 160, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!.and,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          51, 51, 51, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!.terms,
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = _launchUrlTerms,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      decoration: TextDecoration
                                                                          .underline,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          82, 165, 160, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!
                                                                      .services,
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = _launchUrlTerms,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      decoration: TextDecoration
                                                                          .underline,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          82, 165, 160, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                              ])),
                                                        ),
                                                      ]),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child: IconButton(
                                                      iconSize: localHeight * 0.06,
                                                      icon: const Icon(Icons.arrow_circle_right,
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      ),
                                                      onPressed: () async {
                                                        bool valid = formKey.currentState!.validate();
                                                        StudentRegistrationModel student =
                                                        StudentRegistrationModel(
                                                            firstName: studentFirstNameController.text,
                                                            lastName: studentLastNameController.text,
                                                            dob: 01010001,
                                                            gender: gender,
                                                            countryNationality: selectedCountryCitizen
                                                                .dropDownValue?.value,
                                                            email: studentEmailController.text,
                                                            password: studentPasswordController.text,
                                                            rollNumber: studentRollNumberController
                                                                .text,
                                                            organisationName:
                                                            studentOrganisationNameController.text,
                                                            countryResident:
                                                            selectedCountryResident
                                                                .dropDownValue?.value,
                                                            role: ["student"]
                                                          //also == true?
                                                          //["student","teacher"]
                                                          //: ["student"]
                                                        );
                                                        if (pPCheck) {
                                                          bool valid = formKey.currentState!.validate();
                                                          if (valid) {
                                                            LoginModel res =
                                                            await QnaService.postUserDetailsService(
                                                                student);
                                                            if (res.code == 200) {
                                                              if (context.mounted) {
                                                                Navigator.pushNamed(
                                                                  context,
                                                                  '/studentRegisVerifyOtpPage',
                                                                  arguments: student,);
                                                              }
                                                              else if (res.code == 409) {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child: CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                          context)!.alert_popup,
                                                                      //'Incorrect Data',
                                                                      content: AppLocalizations.of(
                                                                          context)!
                                                                          .already_registered_user,
                                                                      button: AppLocalizations.of(
                                                                          context)!.ok_caps,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                  type: PageTransitionType.rightToLeft,
                                                                  child: CustomDialog(
                                                                    title: AppLocalizations.of(context)!.alert_popup,
                                                                    //'Alert',
                                                                    content: '${res.message}',
                                                                    button: AppLocalizations.of(
                                                                        context)!.retry,
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
                                                                    .alert_popup,
                                                                content: AppLocalizations.of(context)!
                                                                    .agree_privacy_terms,
                                                                button: AppLocalizations.of(context)!
                                                                    .retry),
                                                            ),
                                                          );
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
                                                        width: localWidth * 0.8,
                                                        child: TextFormField(
                                                          controller: studentFirstNameController,
                                                          maxLength: 100,
                                                          maxLengthEnforcement: MaxLengthEnforcement
                                                              .truncateAfterCompositionEnds,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            label:
                                                            Text(AppLocalizations.of(
                                                                context)!
                                                                .first_name_caps,
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
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
                                                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                        )),
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                        width: localWidth * 0.8,
                                                        child: TextFormField(
                                                          controller: studentLastNameController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            label: Text(AppLocalizations.of(
                                                                context)!
                                                                .last_name_caps,
                                                              style: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102, 1),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  fontSize: localHeight *
                                                                      0.020),),
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
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
                                                      )),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  // MouseRegion(
                                                  //     cursor: SystemMouseCursors.click,
                                                  //     child: GestureDetector(
                                                  //   onTap: () async {
                                                  //     var pickedDate = await showDatePicker(
                                                  //       context: context,
                                                  //       initialDate: DateTime.now(),
                                                  //       firstDate: DateTime(1900),
                                                  //       lastDate: DateTime.now(),
                                                  //       builder: (context, child) {
                                                  //         return Theme(
                                                  //           data: Theme.of(context).copyWith(
                                                  //             colorScheme: const ColorScheme.light(
                                                  //               primary:
                                                  //                   Color.fromRGBO(82, 165, 160, 1),
                                                  //               onPrimary: Colors.white,
                                                  //               onSurface:
                                                  //                   Colors.black, // <-- SEE HERE
                                                  //             ),
                                                  //             textButtonTheme: TextButtonThemeData(
                                                  //               style: TextButton.styleFrom(
                                                  //                 foregroundColor:
                                                  //                     const Color.fromRGBO(
                                                  //                         82, 165, 160, 1),
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //           child: child!,
                                                  //         );
                                                  //       },
                                                  //     );
                                                  //     // formKey.currentState!.validate();
                                                  //     // final DateFormat formatter =
                                                  //     //     DateFormat('dd/MM/yyyy');
                                                  //     // final String formatted =
                                                  //     //     formatter.format(pickedDate!);
                                                  //     // d = pickedDate.microsecondsSinceEpoch;
                                                  //    // studentDobController.text = formatted;
                                                  //     //formKey.currentState!.validate();
                                                  //   },
                                                  //   child: AbsorbPointer(
                                                  //     child: TextFormField(
                                                  //       controller: studentDobController,
                                                  //       keyboardType: TextInputType.datetime,
                                                  //       decoration: InputDecoration(   
                                                  //labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                  //         floatingLabelBehavior:
                                                  //             FloatingLabelBehavior.always,
                                                  //         label: RichText(
                                                  //             text: TextSpan(children: [
                                                  //           TextSpan(
                                                  //             text: AppLocalizations.of(context)!
                                                  //                 .dob_caps,
                                                  //             style: TextStyle(
                                                  //                 color: const Color.fromRGBO(
                                                  //                     102, 102, 102, 1),
                                                  //                 fontFamily: 'Inter',
                                                  //                 fontWeight: FontWeight.w600,
                                                  //                 fontSize: localHeight * 0.018),
                                                  //           ),
                                                  //           TextSpan(
                                                  //               text: "\t*",
                                                  //               style: TextStyle(
                                                  //                   color: const Color.fromRGBO(
                                                  //                       219, 35, 35, 1),
                                                  //                   fontFamily: 'Inter',
                                                  //                   fontWeight: FontWeight.w600,
                                                  //                   fontSize: localHeight * 0.018)),
                                                  //         ])),
                                                  //         hintStyle: TextStyle(
                                                  //             color: const Color.fromRGBO(
                                                  //                 102, 102, 102, 0.3),
                                                  //             fontFamily: 'Inter',
                                                  //             fontWeight: FontWeight.w400,
                                                  //             fontSize: localHeight * 0.016),
                                                  //         hintText: AppLocalizations.of(context)!
                                                  //             .dob_format,
                                                  //         suffixIcon: const Icon(
                                                  //           Icons.calendar_today_outlined,
                                                  //           color: Color.fromRGBO(141, 167, 167, 1),
                                                  //         ),
                                                  //         focusedBorder: OutlineInputBorder(
                                                  //             borderSide: const BorderSide(
                                                  //                 color: Color.fromRGBO(
                                                  //                     82, 165, 160, 1)),
                                                  //             borderRadius:
                                                  //                 BorderRadius.circular(15)),
                                                  //         border: OutlineInputBorder(
                                                  //             borderRadius:
                                                  //                 BorderRadius.circular(15)),
                                                  //       ),
                                                  //       onChanged: (value) {
                                                  //         formKey.currentState!.validate();
                                                  //       },
                                                  //       validator: (value) {
                                                  //         if (value!.isEmpty) {
                                                  //           return 'Enter Date Of Birth';
                                                  //         } else {
                                                  //           return null;
                                                  //         }
                                                  //       },
                                                  //       enabled: true,
                                                  //     ),
                                                  //   ),
                                                  // )),
                                                  // SizedBox(
                                                  //   height: localHeight * 0.03,
                                                  // ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                        left: localWidth * 0.05, right: localWidth * 0.05),
                                                      child:
                                                      Column(
                                                        children: [
                                                          Row(
                                                              children:[
                                                                Text(
                                                                  AppLocalizations.of(
                                                                      context)!
                                                                      .gender,
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          102, 102, 102, 1),
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight
                                                                          .w600,
                                                                      fontSize: localHeight *
                                                                          0.018),
                                                                ),
                                                              ]
                                                          ),
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                value: "male",
                                                                groupValue: gender,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    gender =
                                                                    value..toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .male,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    localHeight * 0.016),
                                                              ),
                                                              Radio(
                                                                value: "female",
                                                                groupValue: gender,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    gender =
                                                                        value.toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .female,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    localHeight * 0.016),
                                                              ),
                                                              Radio(
                                                                value: "others",
                                                                groupValue: gender,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    gender =
                                                                        value.toString();
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .others,
                                                                style: TextStyle(
                                                                    color: const Color
                                                                        .fromRGBO(
                                                                        51, 51, 51, 1),
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    fontSize:
                                                                    localHeight * 0.016),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: localHeight * 0.01,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                            left: localWidth * 0.05, right: localWidth * 0.05, top: localHeight * 0.02),
                                                        child: DropDownTextField(
                                                          controller: selectedCountryCitizen,
                                                          clearOption: true,
                                                          enableSearch: true,
                                                          textFieldDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
                                                          clearIconProperty: IconProperty(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102, 102, 102, 0.3)),
                                                          searchDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.016),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
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
                                                      Positioned(
                                                        left: localWidth * 0.05,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .country_citizen,
                                                          //"Citizen of Country",
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102, 102, 102, 1),
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: localHeight *
                                                                  0.016),
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
                                                        EdgeInsets.only(
                                                            left: localWidth * 0.05, right: localWidth * 0.05, top: localHeight * 0.02),
                                                        child: DropDownTextField(
                                                          controller: selectedCountryResident,
                                                          clearOption: true,
                                                          enableSearch: true,
                                                          textFieldDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
                                                          clearIconProperty: IconProperty(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  102, 102, 102, 0.3)),
                                                          searchDecoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              hintStyle: TextStyle(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      102, 102, 102,
                                                                      0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight
                                                                      .w400,
                                                                  fontSize:
                                                                  localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here),
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
                                                      Positioned(
                                                        left: localWidth * 0.05,
                                                        child: Container(
                                                          color: Colors.white,
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .country_resident,
                                                            //Resident of Country
                                                            style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    102, 102, 102, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.016),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                        width: localWidth * 0.8,
                                                        child:TextFormField(
                                                          controller: studentOrganisationNameController,
                                                          maxLength: 200,
                                                          maxLengthEnforcement: MaxLengthEnforcement
                                                              .truncateAfterCompositionEnds,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior.always,
                                                              label: Text(AppLocalizations.of(
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
                                                              hintStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintText:
                                                              AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here
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
                                                      )),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.8,
                                                        child: TextFormField(
                                                          controller: studentRollNumberController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            label: RichText(
                                                                text: TextSpan(children: [
                                                                  TextSpan(
                                                                    text: AppLocalizations.of(
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
                                                                  TextSpan(
                                                                    text: AppLocalizations.of(
                                                                        context)!
                                                                        .optional,
                                                                    style: TextStyle(
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            102, 102, 102, 1),
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontStyle: FontStyle.italic,
                                                                        fontSize: localHeight *
                                                                            0.020),
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
                                                                fontSize: localHeight * 0.018),
                                                            hintText:
                                                            AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
                                                          ),
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },

                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                          width: localWidth * 0.8,
                                                          child:
                                                          TextFormField(
                                                            controller: studentEmailController,
                                                            keyboardType: TextInputType.text,
                                                            decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior.always,
                                                              label: Text(
                                                                AppLocalizations.of(
                                                                    context)!
                                                                    .email_id_caps,
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
                                                              helperText: AppLocalizations.of(
                                                                  context)!.email_helper_text,
                                                              //'An OTP will be sent to Email ID',
                                                              helperStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontStyle: FontStyle.italic,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here,
                                                            ),
                                                            onChanged: (value) {
                                                              formKey.currentState!.validate();
                                                            },
                                                            validator: (value) {
                                                              if (value!.isEmpty ||
                                                                  !RegExp(
                                                                      r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                                                                      .hasMatch(value)) {
                                                                return 'Enter Valid Email';
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                          ))),
                                                  SizedBox(
                                                    height: localHeight * 0.01,
                                                  ),
                                                  Center(
                                                      child:
                                                      SizedBox(
                                                          width: localWidth * 0.8,
                                                          child: TextFormField(
                                                            controller: studentPasswordController,
                                                            keyboardType: TextInputType.text,
                                                            decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                              floatingLabelBehavior:
                                                              FloatingLabelBehavior.always,
                                                              label: Text(AppLocalizations.of(
                                                                  context)!
                                                                  .password_caps,
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
                                                              hintStyle: TextStyle(
                                                                  color: const Color.fromRGBO(
                                                                      102, 102, 102, 0.3),
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: localHeight * 0.018),
                                                              hintText: AppLocalizations.of(
                                                                  context)!
                                                                  .enter_here,
                                                            ),
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.deny(' ')
                                                            ],
                                                            onChanged: (val) {
                                                              formKey.currentState!.validate();
                                                            },
                                                            validator: (value) {
                                                              if (value!.length < 8) {
                                                                return "Enter Minimum 8 Characters";
                                                              } else {
                                                                return null;
                                                              }
                                                            },

                                                          ))
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child:
                                                    SizedBox(
                                                        width: localWidth * 0.8,
                                                        child: TextFormField(
                                                          controller: studentconfirmPasswordController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(   
labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.always,
                                                            label: Text(AppLocalizations.of(
                                                                context)!
                                                                .confirm_password,
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
                                                            hintStyle: TextStyle(
                                                                color: const Color.fromRGBO(
                                                                    102, 102, 102, 0.3),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: localHeight * 0.018),
                                                            hintText: AppLocalizations.of(
                                                                context)!
                                                                .enter_here,
                                                          ),
                                                          onChanged: (value) {
                                                            formKey.currentState!.validate();
                                                          },
                                                          validator: (value) {
                                                            if (studentPasswordController.text !=
                                                                studentconfirmPasswordController
                                                                    .text) {
                                                              return 'Re-enter exact same password';
                                                            } else if (value!.isEmpty) {
                                                              return 'Re-enter exact same password';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Row(
                                                      children:[
                                                        SizedBox(width: localWidth * 0.05),
                                                        Text(
                                                          AppLocalizations.of(context)!
                                                              .pri_terms,
                                                          style: TextStyle(
                                                              fontSize: localHeight * 0.018,
                                                              color: const Color.fromRGBO(
                                                                  102, 102, 102, 1),
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: "Inter"),
                                                        )
                                                      ]),
                                                  SizedBox(
                                                    height: localHeight * 0.02,
                                                  ),
                                                  Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        SizedBox(width: localWidth * 0.03),
                                                        Transform.scale(
                                                            filterQuality: FilterQuality.high,
                                                            scale: 1.5,
                                                            child: Checkbox(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius
                                                                      .circular(1)),
                                                              value: pPCheck,
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  pPCheck = val!;
                                                                  if (pPCheck) {}
                                                                });
                                                              },
                                                            )),
                                                        SizedBox(width: localWidth * 0.01),
                                                        Flexible(
                                                          child: RichText(
                                                              text: TextSpan(children: [
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!
                                                                      .agree_msg,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          51, 51, 51, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!
                                                                      .privacy_Policy,
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = _launchUrlPrivacy,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      decoration: TextDecoration
                                                                          .underline,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          82, 165, 160, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!.and,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          51, 51, 51, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!.terms,
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = _launchUrlTerms,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      decoration: TextDecoration
                                                                          .underline,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          82, 165, 160, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                                TextSpan(
                                                                  text: AppLocalizations.of(
                                                                      context)!
                                                                      .services,
                                                                  recognizer: TapGestureRecognizer()
                                                                    ..onTap = _launchUrlTerms,
                                                                  style: TextStyle(
                                                                      fontSize: localHeight *
                                                                          0.018,
                                                                      fontWeight: FontWeight
                                                                          .w400,
                                                                      decoration: TextDecoration
                                                                          .underline,
                                                                      color:
                                                                      const Color.fromRGBO(
                                                                          82, 165, 160, 1),
                                                                      fontFamily: "Inter"),
                                                                ),
                                                              ])),
                                                        ),
                                                      ]),
                                                  SizedBox(
                                                    height: localHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child: IconButton(
                                                      iconSize: localHeight * 0.06,
                                                      icon: const Icon(Icons.arrow_circle_right,
                                                        color: Color.fromRGBO(
                                                            82, 165, 160, 1),
                                                      ),
                                                      onPressed: () async {
                                                        bool valid = formKey.currentState!.validate();
                                                        StudentRegistrationModel student =
                                                        StudentRegistrationModel(
                                                            firstName: studentFirstNameController.text,
                                                            lastName: studentLastNameController.text,
                                                            dob: 01010001,
                                                            gender: gender,
                                                            countryNationality: selectedCountryCitizen
                                                                .dropDownValue?.value,
                                                            email: studentEmailController.text,
                                                            password: studentPasswordController.text,
                                                            rollNumber: studentRollNumberController
                                                                .text,
                                                            organisationName:
                                                            studentOrganisationNameController.text,
                                                            countryResident:
                                                            selectedCountryResident
                                                                .dropDownValue?.value,
                                                            role: ["student"]
                                                          //also == true?
                                                          //["student","teacher"]
                                                          //: ["student"]
                                                        );
                                                        if (pPCheck) {
                                                          bool valid = formKey.currentState!.validate();
                                                          if (valid) {
                                                            LoginModel res =
                                                            await QnaService.postUserDetailsService(
                                                                student);
                                                            if (res.code == 200) {
                                                              if (context.mounted) {
                                                                Navigator.pushNamed(
                                                                  context,
                                                                  '/studentRegisVerifyOtpPage',
                                                                  arguments: student,);
                                                              }
                                                              else if (res.code == 409) {
                                                                Navigator.push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child: CustomDialog(
                                                                      title: AppLocalizations.of(
                                                                          context)!.alert_popup,
                                                                      //'Incorrect Data',
                                                                      content: AppLocalizations.of(
                                                                          context)!
                                                                          .already_registered_user,
                                                                      button: AppLocalizations.of(
                                                                          context)!.ok_caps,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                  type: PageTransitionType.rightToLeft,
                                                                  child: CustomDialog(
                                                                    title: AppLocalizations.of(context)!.alert_popup,
                                                                    //'Alert',
                                                                    content: '${res.message}',
                                                                    button: AppLocalizations.of(
                                                                        context)!.retry,
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
                                                                      .alert_popup,
                                                                  content: AppLocalizations.of(context)!
                                                                      .agree_privacy_terms,
                                                                  button: AppLocalizations.of(context)!
                                                                      .retry),
                                                            ),
                                                          );
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
  Future<void> _launchUrlTerms() async {
    final Uri url = Uri.parse('https://www.itneducation.com/termsofservice');
    if (!await launchUrl(url)) {
      throw Exception('${AppLocalizations.of(context)!.could_not_launch} $url');
    }
  }

  Future<void> _launchUrlPrivacy() async {
    final Uri url = Uri.parse('https://www.itneducation.com/privacypolicy');
    if (!await launchUrl(url)) {
      throw Exception('${AppLocalizations.of(context)!.could_not_launch} $url');
    }
  }
}
