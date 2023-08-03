// import 'package:flutter/material.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:flutter_gen/gen_l10n/app_localization.dart';
// import 'package:intl/intl.dart';
// import 'package:qna_test/pages/student_user_profile.dart';
// import '../Components/custom_incorrect_popup.dart';
// import '../Entity/custom_http_response.dart';
// import '../EntityModel/login_entity.dart';
// import '../EntityModel/student_registration_model.dart';
// import '../Services/qna_service.dart';
// import '../DataSource/http_url.dart';
// class StudentRegistrationUpdatePage extends StatefulWidget {
//   const StudentRegistrationUpdatePage({Key? key, required this.userData, required this.isEdit})
//       : super(key: key);
//
//   final StudentUserProfile userData;
//   final bool isEdit;
//
//   @override
//   StudentRegistrationUpdatePageState createState() =>
//       StudentRegistrationUpdatePageState();
// }
//
// class StudentRegistrationUpdatePageState
//     extends State<StudentRegistrationUpdatePage> {
//   final formKey = GlobalKey<FormState>();
//   TextEditingController studentFirstNameController = TextEditingController();
//   TextEditingController studentLastNameController = TextEditingController();
//   TextEditingController studentEmailController = TextEditingController();
//   TextEditingController studentRollNumberController = TextEditingController();
//   TextEditingController studentOrganisationNameController =
//       TextEditingController();
//   TextEditingController studentIsTeacherController = TextEditingController();
//   TextEditingController studentPasswordController = TextEditingController();
//   TextEditingController studentconfirmPasswordController =
//       TextEditingController();
//   DateTime date = DateTime.now();
//   final DateFormat formatter = DateFormat('dd/MM/yyyy');
//   late String formatted = '';
//   bool tocCheck = false;
//   bool pPCheck = false;
//   bool error = true;
//   String? gender;
//   TextEditingController studentDobController = TextEditingController();
//   late Response userDetails;
//   int n = 244;
//   List<String> countryCitizenList = [
//     "India",
//     "Ascension Island",
//     "Andorra",
//     "United Arab Emirates",
//     "Antigua & Barbuda",
//     "Anguilla",
//     "Albania",
//     "Armenia",
//     "Angola",
//     "Antarctica",
//     "Argentina",
//     "American Samoa",
//     "Austria",
//     "Australia",
//     "Aruba",
//     "Åland Islands",
//     "Azerbaijan",
//     "Bosnia & Herzegovina",
//     "Barbados",
//     "Bangladesh",
//     "Belgium",
//     "Burkina Faso",
//     "Bulgaria",
//     "Bahrain",
//     "Burundi",
//     "Benin",
//     "St. Barthélemy",
//     "Bermuda",
//     "Brunei",
//     "Bolivia",
//     "Caribbean Netherlands",
//     "Brazil",
//     "Bahamas",
//     "Bhutan",
//     "Bouvet Island",
//     "Botswana",
//     "Belarus",
//     "Belize",
//     "Canada",
//     "Cocos (Keeling) Islands",
//     "Congo (DRC)",
//     "Central African Republic",
//     "Congo (Republic)",
//     "Switzerland",
//     "Côte d’Ivoire",
//     "Cook Islands",
//     "Chile",
//     "Cameroon",
//     "Colombia",
//     "Costa Rica",
//     "Cape Verde",
//     "Curaçao",
//     "Christmas Island",
//     "Cyprus",
//     "Czech Republic",
//     "Germany",
//     "Djibouti",
//     "Denmark",
//     "Dominica",
//     "Dominican Republic",
//     "Algeria",
//     "Ecuador",
//     "Estonia",
//     "Egypt",
//     "Western Sahara",
//     "Eritrea",
//     "Spain",
//     "Ethiopia",
//     "Finland",
//     "Fiji",
//     "Falkland Islands (Islas Malvinas)",
//     "Micronesia",
//     "Faroe Islands",
//     "France",
//     "Gabon",
//     "United Kingdom",
//     "Grenada",
//     "Georgia",
//     "French Guiana",
//     "Guernsey",
//     "Ghana",
//     "Gibraltar",
//     "Greenland",
//     "Gambia",
//     "Guinea",
//     "Guadeloupe",
//     "Equatorial Guinea",
//     "Greece",
//     "South Georgia & South Sandwich Islands",
//     "Guatemala",
//     "Guam",
//     "Guinea-Bissau",
//     "Guyana",
//     "Hong Kong",
//     "Heard & McDonald Islands",
//     "Honduras",
//     "Croatia",
//     "Haiti",
//     "Hungary",
//     "Indonesia",
//     "Ireland",
//     "Israel",
//     "Isle of Man",
//     "India",
//     "British Indian Ocean Territory",
//     "Iraq",
//     "Iceland",
//     "Italy",
//     "Jersey",
//     "Jamaica",
//     "Jordan",
//     "Japan",
//     "Kenya",
//     "Kyrgyzstan",
//     "Cambodia",
//     "Kiribati",
//     "Comoros",
//     "St. Kitts & Nevis",
//     "South Korea",
//     "Kuwait",
//     "Cayman Islands",
//     "Kazakhstan",
//     "Laos",
//     "Lebanon",
//     "St. Lucia",
//     "Liechtenstein",
//     "Sri Lanka",
//     "Liberia",
//     "Lesotho",
//     "Lithuania",
//     "Luxembourg",
//     "Latvia",
//     "Libya",
//     "Morocco",
//     "Monaco",
//     "Moldova",
//     "Montenegro",
//     "St. Martin",
//     "Madagascar",
//     "Marshall Islands",
//     "Macedonia (FYROM)",
//     "Mali",
//     "Myanmar (Burma)",
//     "Mongolia",
//     "Macau",
//     "Northern Mariana Islands",
//     "Martinique",
//     "Mauritania",
//     "Montserrat",
//     "Malta",
//     "Mauritius",
//     "Maldives",
//     "Malawi",
//     "Mexico",
//     "Malaysia",
//     "Mozambique",
//     "Namibia",
//     "New Caledonia",
//     "Niger",
//     "Norfolk Island",
//     "Nigeria",
//     "Nicaragua",
//     "Netherlands",
//     "Norway",
//     "Nepal",
//     "Nauru",
//     "Niue",
//     "New Zealand",
//     "Oman",
//     "Panama",
//     "Peru",
//     "French Polynesia",
//     "Papua New Guinea",
//     "Philippines",
//     "Pakistan",
//     "Poland",
//     "St. Pierre & Miquelon",
//     "Pitcairn Islands",
//     "Puerto Rico",
//     "Palestine",
//     "Portugal",
//     "Palau",
//     "Paraguay",
//     "Qatar",
//     "Réunion",
//     "Romania",
//     "Serbia",
//     "Russia",
//     "Rwanda",
//     "Saudi Arabia",
//     "Solomon Islands",
//     "Seychelles",
//     "Sweden",
//     "Singapore",
//     "St. Helena",
//     "Slovenia",
//     "Svalbard & Jan Mayen",
//     "Slovakia",
//     "Sierra Leone",
//     "San Marino",
//     "Senegal",
//     "Somalia",
//     "Suriname",
//     "South Sudan",
//     "São Tomé & Príncipe",
//     "El Salvador",
//     "Sint Maarten",
//     "Swaziland",
//     "Tristan da Cunha",
//     "Turks & Caicos Islands",
//     "Chad",
//     "French Southern Territories",
//     "Togo",
//     "Thailand",
//     "Tajikistan",
//     "Tokelau",
//     "Timor-Leste",
//     "Turkmenistan",
//     "Tunisia",
//     "Tonga",
//     "Turkey",
//     "Trinidad & Tobago",
//     "Tuvalu",
//     "Taiwan",
//     "Tanzania",
//     "Ukraine",
//     "Uganda",
//     "U.S. Outlying Islands",
//     "United States",
//     "Uruguay",
//     "Uzbekistan",
//     "Vatican City",
//     "St. Vincent & Grenadines",
//     "Venezuela",
//     "British Virgin Islands",
//     "U.S. Virgin Islands",
//     "Vietnam",
//     "Vanuatu",
//     "Wallis & Futuna",
//     "Samoa",
//     "Kosovo",
//     "Yemen",
//     "Mayotte",
//     "South Africa",
//     "Zambia",
//     "Zimbabwe"
//   ];
//   SingleValueDropDownController selectedCountryCitizen =
//       SingleValueDropDownController();
//   List<String> countryResidentList = [
//     "India",
//     "United States",
//     "European Union",
//     "Rest of World"
//   ];
//   SingleValueDropDownController selectedCountryResident =
//       SingleValueDropDownController();
//   int d = 0;
//
//   @override
//   void initState() {
//     if (widget.isEdit == true) {
//       date = DateTime.fromMicrosecondsSinceEpoch(
//           widget.userData.userDataModel.data!.dob);
//       formatted = formatter.format(date);
//       studentFirstNameController =
//           widget.userData.userDataModel.data?.firstName != null
//               ? TextEditingController(
//                   text: widget.userData.userDataModel.data?.firstName)
//               : studentFirstNameController;
//       studentLastNameController =
//           widget.userData.userDataModel.data?.lastName != null
//               ? TextEditingController(
//                   text: widget.userData.userDataModel.data?.lastName)
//               : studentLastNameController;
//       studentEmailController =
//           widget.userData.userDataModel.data?.email != null
//               ? TextEditingController(
//                   text: widget.userData.userDataModel.data?.email)
//               : studentEmailController;
//       studentRollNumberController =
//           widget.userData.userDataModel.data?.rollNumber != null
//               ? TextEditingController(
//                   text: widget.userData.userDataModel.data?.rollNumber)
//               : studentRollNumberController;
//       studentOrganisationNameController =
//           widget.userData.userDataModel.data?.organisationName != null
//               ? TextEditingController(
//                   text: widget.userData.userDataModel.data?.organisationName)
//               : studentOrganisationNameController;
//       studentDobController = formatted != null
//           ? TextEditingController(text: formatted)
//           : studentDobController;
//     }
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     studentDobController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double localWidth = MediaQuery.of(context).size.width;
//     double localHeight = MediaQuery.of(context).size.height;
//     bool isAlso = false;
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints)
//     {
//       if (constraints.maxWidth > webWidth) {
//         return Center(
//             child: SizedBox(
//             width: webWidth,
//             child: WillPopScope(
//             onWillPop: () async => false,
//             child: Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                   icon: const Icon(
//                     Icons.chevron_left,
//                     size: 40.0,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 centerTitle: true,
//                 title: Text(
//                   AppLocalizations.of(context)!.student_register,
//                   style: const TextStyle(
//                     color: Color.fromRGBO(255, 255, 255, 1),
//                     fontSize: 18.0,
//                     fontFamily: "Inter",
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 flexibleSpace: Container(
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                           end: Alignment.bottomCenter,
//                           begin: Alignment.topCenter,
//                           colors: [
//                             Color.fromRGBO(0, 106, 100, 1),
//                             Color.fromRGBO(82, 165, 160, 1),
//                           ])),
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: webWidth * 0.8,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: localHeight * 0.05,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentFirstNameController,
//                                     //initialValue: widget.isEdit == true ? widget.userData?.userDataModel.data?.firstName : " ",
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .first_name_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText: AppLocalizations.of(
//                                           context)!
//                                           .enter_here,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter First Name';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentLastNameController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .last_name_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText: AppLocalizations.of(context)!
//                                           .last_name_hint,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter Last Name';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () async {
//                                     var pickedDate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(1900),
//                                       lastDate: DateTime.now(),
//                                       builder: (context, child) {
//                                         return Theme(
//                                           data: Theme.of(context).copyWith(
//                                             colorScheme: const ColorScheme
//                                                 .light(
//                                               primary:
//                                               Color.fromRGBO(82, 165, 160, 1),
//                                               onPrimary: Colors.white,
//                                               onSurface:
//                                               Colors.black, // <-- SEE HERE
//                                             ),
//                                             textButtonTheme: TextButtonThemeData(
//                                               style: TextButton.styleFrom(
//                                                 foregroundColor:
//                                                 const Color.fromRGBO(
//                                                     82, 165, 160, 1),
//                                               ),
//                                             ),
//                                           ),
//                                           child: child!,
//                                         );
//                                       },
//                                     );
//                                     formKey.currentState!.validate();
//                                     final DateFormat formatter =
//                                     DateFormat('dd/MM/yyyy');
//                                     final String formatted =
//                                     formatter.format(pickedDate!);
//                                     d = pickedDate.microsecondsSinceEpoch;
//                                     studentDobController.text = formatted;
//                                     formKey.currentState!.validate();
//                                   },
//                                   child: AbsorbPointer(
//                                     child: TextFormField(
//                                       controller: studentDobController,
//                                       keyboardType: TextInputType.datetime,
//                                       decoration: InputDecoration(
//                                         floatingLabelBehavior:
//                                         FloatingLabelBehavior.always,
//                                         label: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: AppLocalizations.of(
//                                                     context)!
//                                                     .dob_caps,
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t*",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.018)),
//                                             ])),
//                                         hintStyle: TextStyle(
//                                             color: const Color.fromRGBO(
//                                                 102, 102, 102, 0.3),
//                                             fontFamily: 'Inter',
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: localHeight * 0.016),
//                                         hintText: AppLocalizations.of(context)!
//                                             .dob_format,
//                                         suffixIcon: const Icon(
//                                           Icons.calendar_today_outlined,
//                                           color: Color.fromRGBO(
//                                               141, 167, 167, 1),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: const BorderSide(
//                                                 color: Color.fromRGBO(
//                                                     82, 165, 160, 1)),
//                                             borderRadius:
//                                             BorderRadius.circular(15)),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(15)),
//                                       ),
//                                       onChanged: (value) {
//                                         formKey.currentState!.validate();
//                                       },
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'Enter Date Of Birth';
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                       enabled: true,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                       const EdgeInsets.only(left: 5, top: 7),
//                                       child: DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Colors.black38,
//                                               width: 1),
//                                           //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               17),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 20, right: 20),
//                                           child: DropdownButtonHideUnderline(
//                                             child: Row(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                               children: [
//                                                 Radio(
//                                                   value: "male",
//                                                   groupValue: gender,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       gender =
//                                                       value..toString();
//                                                     });
//                                                   },
//                                                 ),
//                                                 Text(
//                                                   AppLocalizations.of(context)!
//                                                       .male,
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           51, 51, 51, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                 ),
//                                                 Radio(
//                                                   value: "female",
//                                                   groupValue: gender,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       gender = value.toString();
//                                                     });
//                                                   },
//                                                 ),
//                                                 Text(
//                                                   AppLocalizations.of(context)!
//                                                       .female,
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           51, 51, 51, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                 ),
//                                                 Radio(
//                                                   value: "others",
//                                                   groupValue: gender,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       gender = value.toString();
//                                                     });
//                                                   },
//                                                 ),
//                                                 Text(
//                                                   AppLocalizations.of(context)!
//                                                       .others,
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           51, 51, 51, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: webWidth * 0.038,
//                                       child: Container(
//                                         color: Colors.white,
//                                         child: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: AppLocalizations.of(
//                                                     context)!
//                                                     .gender,
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.015),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t* \t",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.016)),
//                                             ])),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                       const EdgeInsets.only(left: 5, top: 7),
//                                       child: DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           //background color of dropdown button
//                                           border: Border.all(
//                                               color: Colors.black38,
//                                               width: 1),
//                                           //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               17), //border radius of dropdown button
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 30, right: 30),
//                                           child: DropdownButtonHideUnderline(
//                                             child: DropDownTextField(
//                                               controller: selectedCountryCitizen,
//                                               clearOption: true,
//                                               enableSearch: true,
//                                               textFieldDecoration: InputDecoration(
//                                                   floatingLabelBehavior:
//                                                   FloatingLabelBehavior.always,
//                                                   border: InputBorder.none,
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               clearIconProperty: IconProperty(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 0.3)),
//                                               searchDecoration: InputDecoration(
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return "Required field";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               dropDownItemCount: 5,
//                                               dropDownList: [
//                                                 for (int i = 0; i <= n; i++)
//                                                   DropDownValueModel(
//                                                       name: countryCitizenList[i],
//                                                       value: countryCitizenList[i])
//                                               ],
//                                               onChanged: (value) {},
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: webWidth * 0.038,
//                                       child: Container(
//                                         color: Colors.white,
//                                         child: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: "\tCOUNTRY CITIZEN",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.013),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t* \t",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.016)),
//                                             ])),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                       const EdgeInsets.only(left: 5, top: 7),
//                                       child: DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           //background color of dropdown button
//                                           border: Border.all(
//                                               color: Colors.black38,
//                                               width: 1),
//                                           //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               17), //border radius of dropdown button
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 30, right: 30),
//                                           child: DropdownButtonHideUnderline(
//                                             child: DropDownTextField(
//                                               controller: selectedCountryResident,
//                                               clearOption: true,
//                                               enableSearch: true,
//                                               textFieldDecoration: InputDecoration(
//                                                   floatingLabelBehavior:
//                                                   FloatingLabelBehavior.always,
//                                                   border: InputBorder.none,
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               clearIconProperty: IconProperty(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 0.3)),
//                                               searchDecoration: InputDecoration(
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return "Required field";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               dropDownItemCount: 5,
//                                               dropDownList: [
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[0],
//                                                     value: countryResidentList[0]),
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[1],
//                                                     value: countryResidentList[1]),
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[2],
//                                                     value: countryResidentList[2]),
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[3],
//                                                     value: countryResidentList[3])
//                                               ],
//                                               onChanged: (value) {},
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: webWidth * 0.038,
//                                       child: Container(
//                                         color: Colors.white,
//                                         child: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: '\tCOUNTRY RESIDENT',
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.013),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t*\t",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.016)),
//                                             ])),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentEmailController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .email_id_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       helperText: 'an OTP will be sent to Email ID',
//                                       labelStyle: TextStyle(
//                                           color:
//                                           const Color.fromRGBO(51, 51, 51, 1),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: localHeight * 0.016),
//                                       helperStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText: "emailID@email.com",
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty ||
//                                           !RegExp(
//                                               r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
//                                               .hasMatch(value)) {
//                                         return 'Enter Valid Email';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentRollNumberController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .reg_roll_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       labelStyle: TextStyle(
//                                           color:
//                                           const Color.fromRGBO(51, 51, 51, 1),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: localHeight * 0.016),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText:
//                                       AppLocalizations.of(context)!.reg_roll,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter Roll Number';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentOrganisationNameController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .ins_org_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText:
//                                       AppLocalizations.of(context)!.ins_org,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter Organization Name';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.02,
//                                 ),
//                                 Row(children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Checkbox(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               10)),
//                                       value: tocCheck,
//                                       onChanged: (val) {
//                                         setState(() {
//                                           tocCheck = val!;
//                                           if (tocCheck) {}
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                   Text(
//                                     AppLocalizations.of(context)!
//                                         .reg_as_student,
//                                     style: const TextStyle(
//                                         fontSize: 17.0,
//                                         fontWeight: FontWeight.w600,
//                                         color: Color.fromRGBO(102, 102, 102, 1),
//                                         fontFamily: "Inter"),
//                                   ),
//                                 ]),
//                                 SizedBox(
//                                   height: localHeight * 0.01,
//                                 ),
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       AppLocalizations.of(context)!.pri_terms,
//                                       style: const TextStyle(
//                                           fontSize: 17.0,
//                                           color: Color.fromRGBO(
//                                               102, 102, 102, 1),
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: "Inter"),
//                                     )),
//                                 SizedBox(
//                                   height: localHeight * 0.02,
//                                 ),
//                                 Row(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Checkbox(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                                 1)),
//                                         value: pPCheck,
//                                         onChanged: (val) {
//                                           setState(() {
//                                             pPCheck = val!;
//                                             if (pPCheck) {
//                                               isAlso = true;
//                                             }
//                                           });
//                                         },
//                                       ),
//                                       RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .agree_msg,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color.fromRGBO(
//                                                       51, 51, 51, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .privacy_Policy,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   decoration: TextDecoration
//                                                       .underline,
//                                                   color:
//                                                   Color.fromRGBO(
//                                                       82, 165, 160, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .and,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   decoration: TextDecoration
//                                                       .underline,
//                                                   color:
//                                                   Color.fromRGBO(
//                                                       82, 165, 160, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .terms,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   decoration: TextDecoration
//                                                       .underline,
//                                                   color:
//                                                   Color.fromRGBO(
//                                                       82, 165, 160, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .services,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color.fromRGBO(
//                                                       51, 51, 51, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                           ])),
//                                     ]),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       AppLocalizations.of(context)!.create_pass,
//                                       style: const TextStyle(
//                                           fontSize: 17.0,
//                                           color: Color.fromRGBO(
//                                               102, 102, 102, 1),
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: "Inter"),
//                                     )),
//                                 SizedBox(
//                                   height: localHeight * 0.02,
//                                 ),
//                                 // Align(
//                                 //   alignment: Alignment.topLeft,
//                                 //   child: TextFormField(
//                                 //     controller: studentPasswordController,
//                                 //     keyboardType: TextInputType.text,
//                                 //     decoration: InputDecoration(
//                                 //       floatingLabelBehavior:
//                                 //       FloatingLabelBehavior.always,
//                                 //       label: RichText(
//                                 //           text: TextSpan(children: [
//                                 //             TextSpan(
//                                 //               text: AppLocalizations.of(context)!
//                                 //                   .password_caps,
//                                 //               style: TextStyle(
//                                 //                   color: const Color.fromRGBO(
//                                 //                       102, 102, 102, 1),
//                                 //                   fontFamily: 'Inter',
//                                 //                   fontWeight: FontWeight.w600,
//                                 //                   fontSize: localHeight * 0.017),
//                                 //             ),
//                                 //             TextSpan(
//                                 //                 text: "\t*",
//                                 //                 style: TextStyle(
//                                 //                     color: const Color.fromRGBO(
//                                 //                         219, 35, 35, 1),
//                                 //                     fontFamily: 'Inter',
//                                 //                     fontWeight: FontWeight.w600,
//                                 //                     fontSize: localHeight * 0.017)),
//                                 //           ])),
//                                 //       hintStyle: TextStyle(
//                                 //           color:
//                                 //           const Color.fromRGBO(102, 102, 102, 0.3),
//                                 //           fontFamily: 'Inter',
//                                 //           fontWeight: FontWeight.w400,
//                                 //           fontSize: localHeight * 0.016),
//                                 //       hintText:
//                                 //       AppLocalizations.of(context)!.password_hint,
//                                 //       focusedBorder: OutlineInputBorder(
//                                 //           borderSide: const BorderSide(
//                                 //               color: Color.fromRGBO(82, 165, 160, 1)),
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //       border: OutlineInputBorder(
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //     ),
//                                 //     inputFormatters: [
//                                 //       FilteringTextInputFormatter.deny(' ')
//                                 //     ],
//                                 //     onChanged: (val) {
//                                 //       formKey.currentState!.validate();
//                                 //     },
//                                 //     validator: (value) {
//                                 //       if (value!.length < 8) {
//                                 //         return "Enter Minimum 8 Characters";
//                                 //       } else {
//                                 //         return null;
//                                 //       }
//                                 //     },
//                                 //     // validator: (value){
//                                 //     //   if(value!.isEmpty){
//                                 //     //     return 'Enter Password';
//                                 //     //   }
//                                 //     //   else if(value!.length < 8){
//                                 //     //     return 'Enter Minimum 8 characters for password';
//                                 //     //   }
//                                 //     //   else{
//                                 //     //     return null;
//                                 //     //   }
//                                 //     // },
//                                 //   ),
//                                 // ),
//                                 // SizedBox(
//                                 //   height: localHeight * 0.03,
//                                 // ),
//                                 // Align(
//                                 //   alignment: Alignment.topLeft,
//                                 //   child: TextFormField(
//                                 //     controller: studentconfirmPasswordController,
//                                 //     keyboardType: TextInputType.text,
//                                 //     decoration: InputDecoration(
//                                 //       floatingLabelBehavior:
//                                 //       FloatingLabelBehavior.always,
//                                 //       label: RichText(
//                                 //           text: TextSpan(children: [
//                                 //             TextSpan(
//                                 //               text: AppLocalizations.of(context)!
//                                 //                   .confirm_password,
//                                 //               style: TextStyle(
//                                 //                   color: const Color.fromRGBO(
//                                 //                       102, 102, 102, 1),
//                                 //                   fontFamily: 'Inter',
//                                 //                   fontWeight: FontWeight.w600,
//                                 //                   fontSize: localHeight * 0.017),
//                                 //             ),
//                                 //             TextSpan(
//                                 //                 text: "\t*",
//                                 //                 style: TextStyle(
//                                 //                     color: const Color.fromRGBO(
//                                 //                         219, 35, 35, 1),
//                                 //                     fontFamily: 'Inter',
//                                 //                     fontWeight: FontWeight.w600,
//                                 //                     fontSize: localHeight * 0.017)),
//                                 //           ])),
//                                 //       // SizedBox(
//                                 //       //   width: localWidth * 0.25,
//                                 //       //   child: Row(
//                                 //       //     children: [
//                                 //       //       Text(AppLocalizations.of(context)!.confirm_password,
//                                 //       //         style: TextStyle(
//                                 //       //           color: const Color.fromRGBO(51, 51, 51, 1),
//                                 //       //           fontSize: localHeight *0.016,
//                                 //       //           fontFamily: "Inter",
//                                 //       //           fontWeight: FontWeight.w600,
//                                 //       //         ),),
//                                 //       //       const Text("\t*", style: TextStyle(color: Colors.red)),
//                                 //       //     ],
//                                 //       //   ),
//                                 //       // ),
//                                 //       labelStyle: TextStyle(
//                                 //           color: const Color.fromRGBO(51, 51, 51, 1),
//                                 //           fontFamily: 'Inter',
//                                 //           fontWeight: FontWeight.w600,
//                                 //           fontSize: localHeight * 0.016),
//                                 //       hintStyle: TextStyle(
//                                 //           color:
//                                 //           const Color.fromRGBO(102, 102, 102, 0.3),
//                                 //           fontFamily: 'Inter',
//                                 //           fontWeight: FontWeight.w400,
//                                 //           fontSize: localHeight * 0.016),
//                                 //       hintText:
//                                 //       AppLocalizations.of(context)!.verify_password,
//                                 //       focusedBorder: OutlineInputBorder(
//                                 //           borderSide: const BorderSide(
//                                 //               color: Color.fromRGBO(82, 165, 160, 1)),
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //       border: OutlineInputBorder(
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //     ),
//                                 //     onChanged: (value) {
//                                 //       formKey.currentState!.validate();
//                                 //     },
//                                 //     validator: (value) {
//                                 //       if (studentPasswordController.text !=
//                                 //           studentconfirmPasswordController.text) {
//                                 //         return 'Re-Enter Password';
//                                 //       } else if (value!.isEmpty) {
//                                 //         return 'Enter Confirm Password';
//                                 //       } else {
//                                 //         return null;
//                                 //       }
//                                 //     },
//                                 //   ),
//                                 // )
//                               ],
//                             ),
//                             //SizedBox(height:localHeight * 0.05),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: localHeight * 0.05,
//                       ),
//                       Center(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color.fromRGBO(
//                                 82, 165, 160, 1),
//                             minimumSize: const Size(280, 48),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(39),
//                             ),
//                           ),
//                           onPressed: () async {
//                             bool valid = formKey.currentState!.validate();
//                             StudentRegistrationModel student =
//                             StudentRegistrationModel(
//                                 firstName: studentFirstNameController.text,
//                                 lastName: studentLastNameController.text,
//                                 dob: d,
//                                 gender: gender,
//                                 countryNationality: selectedCountryCitizen
//                                     .dropDownValue?.value,
//                                 email: studentEmailController.text,
//                                 password: studentPasswordController.text,
//                                 rollNumber: studentRollNumberController.text,
//                                 organisationName:
//                                 studentOrganisationNameController.text,
//                                 countryResident:
//                                 selectedCountryResident
//                                     .dropDownValue?.value,
//                                 role: isAlso
//                                     ? ["student", "teacher"]
//                                     : ["student"]);
//                             if (valid) {
//                               LoginModel res =
//                               await QnaService.postUserDetailsService(student);
//                               if (res.code == 200) {
//                                 Navigator.pushNamed(
//                                   context, '/studentRegisVerifyOtpPage',
//                                   arguments: studentEmailController.text,);
//                                 // Navigator.push(
//                                 //   context,
//                                 //   PageTransition(
//                                 //       type: PageTransitionType.fade,
//                                 //       child: StudentRegisVerifyOtpPage(
//                                 //         email: studentEmailController.text,
//                                 //       )),
//                                 // );
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   PageTransition(
//                                     type: PageTransitionType.rightToLeft,
//                                     child: CustomDialog(
//                                       title: 'Incorrect Data',
//                                       content: '${res.message}',
//                                       button: AppLocalizations.of(context)!
//                                           .retry,
//                                     ),
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                           child: Text(
//                             AppLocalizations.of(context)!.sent_otp,
//                             style: TextStyle(
//                                 fontSize: localHeight * 0.024,
//                                 fontFamily: "Inter",
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: localHeight * 0.05,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               //)
//             ))));
//       }
//       else {
//         return WillPopScope(
//             onWillPop: () async => false,
//             child: Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                   icon: const Icon(
//                     Icons.chevron_left,
//                     size: 40.0,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 centerTitle: true,
//                 title: Text(
//                   AppLocalizations.of(context)!.student_register,
//                   style: const TextStyle(
//                     color: Color.fromRGBO(255, 255, 255, 1),
//                     fontSize: 18.0,
//                     fontFamily: "Inter",
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 flexibleSpace: Container(
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                           end: Alignment.bottomCenter,
//                           begin: Alignment.topCenter,
//                           colors: [
//                             Color.fromRGBO(0, 106, 100, 1),
//                             Color.fromRGBO(82, 165, 160, 1),
//                           ])),
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: localWidth * 0.8,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: localHeight * 0.05,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentFirstNameController,
//                                     //initialValue: widget.isEdit == true ? widget.userData?.userDataModel.data?.firstName : " ",
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .first_name_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText: AppLocalizations.of(
//                                           context)!
//                                           .enter_here,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter First Name';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentLastNameController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .last_name_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText: AppLocalizations.of(context)!
//                                           .last_name_hint,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter Last Name';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () async {
//                                     var pickedDate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(1900),
//                                       lastDate: DateTime.now(),
//                                       builder: (context, child) {
//                                         return Theme(
//                                           data: Theme.of(context).copyWith(
//                                             colorScheme: const ColorScheme
//                                                 .light(
//                                               primary:
//                                               Color.fromRGBO(82, 165, 160, 1),
//                                               onPrimary: Colors.white,
//                                               onSurface:
//                                               Colors.black, // <-- SEE HERE
//                                             ),
//                                             textButtonTheme: TextButtonThemeData(
//                                               style: TextButton.styleFrom(
//                                                 foregroundColor:
//                                                 const Color.fromRGBO(
//                                                     82, 165, 160, 1),
//                                               ),
//                                             ),
//                                           ),
//                                           child: child!,
//                                         );
//                                       },
//                                     );
//                                     formKey.currentState!.validate();
//                                     final DateFormat formatter =
//                                     DateFormat('dd/MM/yyyy');
//                                     final String formatted =
//                                     formatter.format(pickedDate!);
//                                     d = pickedDate.microsecondsSinceEpoch;
//                                     studentDobController.text = formatted;
//                                     formKey.currentState!.validate();
//                                   },
//                                   child: AbsorbPointer(
//                                     child: TextFormField(
//                                       controller: studentDobController,
//                                       keyboardType: TextInputType.datetime,
//                                       decoration: InputDecoration(
//                                         floatingLabelBehavior:
//                                         FloatingLabelBehavior.always,
//                                         label: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: AppLocalizations.of(
//                                                     context)!
//                                                     .dob_caps,
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t*",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.018)),
//                                             ])),
//                                         hintStyle: TextStyle(
//                                             color: const Color.fromRGBO(
//                                                 102, 102, 102, 0.3),
//                                             fontFamily: 'Inter',
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: localHeight * 0.016),
//                                         hintText: AppLocalizations.of(context)!
//                                             .dob_format,
//                                         suffixIcon: const Icon(
//                                           Icons.calendar_today_outlined,
//                                           color: Color.fromRGBO(
//                                               141, 167, 167, 1),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: const BorderSide(
//                                                 color: Color.fromRGBO(
//                                                     82, 165, 160, 1)),
//                                             borderRadius:
//                                             BorderRadius.circular(15)),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(15)),
//                                       ),
//                                       onChanged: (value) {
//                                         formKey.currentState!.validate();
//                                       },
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'Enter Date Of Birth';
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                       enabled: true,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                       const EdgeInsets.only(left: 5, top: 7),
//                                       child: DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Colors.black38,
//                                               width: 1),
//                                           //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               17),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 20, right: 20),
//                                           child: DropdownButtonHideUnderline(
//                                             child: Row(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                               children: [
//                                                 Radio(
//                                                   value: "male",
//                                                   groupValue: gender,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       gender =
//                                                       value..toString();
//                                                     });
//                                                   },
//                                                 ),
//                                                 Text(
//                                                   AppLocalizations.of(context)!
//                                                       .male,
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           51, 51, 51, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                 ),
//                                                 Radio(
//                                                   value: "female",
//                                                   groupValue: gender,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       gender = value.toString();
//                                                     });
//                                                   },
//                                                 ),
//                                                 Text(
//                                                   AppLocalizations.of(context)!
//                                                       .female,
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           51, 51, 51, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                 ),
//                                                 Radio(
//                                                   value: "others",
//                                                   groupValue: gender,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       gender = value.toString();
//                                                     });
//                                                   },
//                                                 ),
//                                                 Text(
//                                                   AppLocalizations.of(context)!
//                                                       .others,
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           51, 51, 51, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: localWidth * 0.038,
//                                       child: Container(
//                                         color: Colors.white,
//                                         child: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: AppLocalizations.of(
//                                                     context)!
//                                                     .gender,
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.015),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t* \t",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.016)),
//                                             ])),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                       const EdgeInsets.only(left: 5, top: 7),
//                                       child: DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           //background color of dropdown button
//                                           border: Border.all(
//                                               color: Colors.black38,
//                                               width: 1),
//                                           //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               17), //border radius of dropdown button
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 30, right: 30),
//                                           child: DropdownButtonHideUnderline(
//                                             child: DropDownTextField(
//                                               controller: selectedCountryCitizen,
//                                               clearOption: true,
//                                               enableSearch: true,
//                                               textFieldDecoration: InputDecoration(
//                                                   floatingLabelBehavior:
//                                                   FloatingLabelBehavior.always,
//                                                   border: InputBorder.none,
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               clearIconProperty: IconProperty(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 0.3)),
//                                               searchDecoration: InputDecoration(
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return "Required field";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               dropDownItemCount: 5,
//                                               dropDownList: [
//                                                 for (int i = 0; i <= n; i++)
//                                                   DropDownValueModel(
//                                                       name: countryCitizenList[i],
//                                                       value: countryCitizenList[i])
//                                               ],
//                                               onChanged: (value) {},
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: localWidth * 0.038,
//                                       child: Container(
//                                         color: Colors.white,
//                                         child: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: "\tCOUNTRY CITIZEN",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.013),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t* \t",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.016)),
//                                             ])),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                       const EdgeInsets.only(left: 5, top: 7),
//                                       child: DecoratedBox(
//                                         decoration: BoxDecoration(
//                                           //background color of dropdown button
//                                           border: Border.all(
//                                               color: Colors.black38,
//                                               width: 1),
//                                           //border of dropdown button
//                                           borderRadius: BorderRadius.circular(
//                                               17), //border radius of dropdown button
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 30, right: 30),
//                                           child: DropdownButtonHideUnderline(
//                                             child: DropDownTextField(
//                                               controller: selectedCountryResident,
//                                               clearOption: true,
//                                               enableSearch: true,
//                                               textFieldDecoration: InputDecoration(
//                                                   floatingLabelBehavior:
//                                                   FloatingLabelBehavior.always,
//                                                   border: InputBorder.none,
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               clearIconProperty: IconProperty(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 0.3)),
//                                               searchDecoration: InputDecoration(
//                                                   hintStyle: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           102, 102, 102, 0.3),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w400,
//                                                       fontSize:
//                                                       localHeight * 0.016),
//                                                   hintText: "Enter Country"),
//                                               validator: (value) {
//                                                 if (value == null) {
//                                                   return "Required field";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                               dropDownItemCount: 5,
//                                               dropDownList: [
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[0],
//                                                     value: countryResidentList[0]),
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[1],
//                                                     value: countryResidentList[1]),
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[2],
//                                                     value: countryResidentList[2]),
//                                                 DropDownValueModel(
//                                                     name: countryResidentList[3],
//                                                     value: countryResidentList[3])
//                                               ],
//                                               onChanged: (value) {},
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: localWidth * 0.038,
//                                       child: Container(
//                                         color: Colors.white,
//                                         child: RichText(
//                                             text: TextSpan(children: [
//                                               TextSpan(
//                                                 text: '\tCOUNTRY RESIDENT',
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         102, 102, 102, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.013),
//                                               ),
//                                               TextSpan(
//                                                   text: "\t*\t",
//                                                   style: TextStyle(
//                                                       color: const Color
//                                                           .fromRGBO(
//                                                           219, 35, 35, 1),
//                                                       fontFamily: 'Inter',
//                                                       fontWeight: FontWeight
//                                                           .w600,
//                                                       fontSize: localHeight *
//                                                           0.016)),
//                                             ])),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentEmailController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .email_id_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       helperText: 'an OTP will be sent to Email ID',
//                                       labelStyle: TextStyle(
//                                           color:
//                                           const Color.fromRGBO(51, 51, 51, 1),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: localHeight * 0.016),
//                                       helperStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText: "emailID@email.com",
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty ||
//                                           !RegExp(
//                                               r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
//                                               .hasMatch(value)) {
//                                         return 'Enter Valid Email';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentRollNumberController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .reg_roll_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       labelStyle: TextStyle(
//                                           color:
//                                           const Color.fromRGBO(51, 51, 51, 1),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: localHeight * 0.016),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText:
//                                       AppLocalizations.of(context)!.reg_roll,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter Roll Number';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: TextFormField(
//                                     controller: studentOrganisationNameController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: InputDecoration(
//                                       floatingLabelBehavior:
//                                       FloatingLabelBehavior.always,
//                                       label: RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .ins_org_caps,
//                                               style: TextStyle(
//                                                   color: const Color.fromRGBO(
//                                                       102, 102, 102, 1),
//                                                   fontFamily: 'Inter',
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: localHeight *
//                                                       0.018),
//                                             ),
//                                             TextSpan(
//                                                 text: "\t*",
//                                                 style: TextStyle(
//                                                     color: const Color.fromRGBO(
//                                                         219, 35, 35, 1),
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: localHeight *
//                                                         0.018)),
//                                           ])),
//                                       hintStyle: TextStyle(
//                                           color: const Color.fromRGBO(
//                                               102, 102, 102, 0.3),
//                                           fontFamily: 'Inter',
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: localHeight * 0.016),
//                                       hintText:
//                                       AppLocalizations.of(context)!.ins_org,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color:
//                                               Color.fromRGBO(82, 165, 160, 1)),
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               15)),
//                                     ),
//                                     onChanged: (value) {
//                                       formKey.currentState!.validate();
//                                     },
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Enter Organization Name';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: localHeight * 0.02,
//                                 ),
//                                 Row(children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Checkbox(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               10)),
//                                       value: tocCheck,
//                                       onChanged: (val) {
//                                         setState(() {
//                                           tocCheck = val!;
//                                           if (tocCheck) {}
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                   Text(
//                                     AppLocalizations.of(context)!
//                                         .reg_as_student,
//                                     style: const TextStyle(
//                                         fontSize: 17.0,
//                                         fontWeight: FontWeight.w600,
//                                         color: Color.fromRGBO(102, 102, 102, 1),
//                                         fontFamily: "Inter"),
//                                   ),
//                                 ]),
//                                 SizedBox(
//                                   height: localHeight * 0.01,
//                                 ),
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       AppLocalizations.of(context)!.pri_terms,
//                                       style: const TextStyle(
//                                           fontSize: 17.0,
//                                           color: Color.fromRGBO(
//                                               102, 102, 102, 1),
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: "Inter"),
//                                     )),
//                                 SizedBox(
//                                   height: localHeight * 0.02,
//                                 ),
//                                 Row(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Checkbox(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                                 1)),
//                                         value: pPCheck,
//                                         onChanged: (val) {
//                                           setState(() {
//                                             pPCheck = val!;
//                                             if (pPCheck) {
//                                               isAlso = true;
//                                             }
//                                           });
//                                         },
//                                       ),
//                                       RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .agree_msg,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color.fromRGBO(
//                                                       51, 51, 51, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .privacy_Policy,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   decoration: TextDecoration
//                                                       .underline,
//                                                   color:
//                                                   Color.fromRGBO(
//                                                       82, 165, 160, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .and,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   decoration: TextDecoration
//                                                       .underline,
//                                                   color:
//                                                   Color.fromRGBO(
//                                                       82, 165, 160, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .terms,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   decoration: TextDecoration
//                                                       .underline,
//                                                   color:
//                                                   Color.fromRGBO(
//                                                       82, 165, 160, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                             TextSpan(
//                                               text: AppLocalizations.of(
//                                                   context)!
//                                                   .services,
//                                               style: const TextStyle(
//                                                   fontSize: 15.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color.fromRGBO(
//                                                       51, 51, 51, 1),
//                                                   fontFamily: "Inter"),
//                                             ),
//                                           ])),
//                                     ]),
//                                 SizedBox(
//                                   height: localHeight * 0.03,
//                                 ),
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       AppLocalizations.of(context)!.create_pass,
//                                       style: const TextStyle(
//                                           fontSize: 17.0,
//                                           color: Color.fromRGBO(
//                                               102, 102, 102, 1),
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: "Inter"),
//                                     )),
//                                 SizedBox(
//                                   height: localHeight * 0.02,
//                                 ),
//                                 // Align(
//                                 //   alignment: Alignment.topLeft,
//                                 //   child: TextFormField(
//                                 //     controller: studentPasswordController,
//                                 //     keyboardType: TextInputType.text,
//                                 //     decoration: InputDecoration(
//                                 //       floatingLabelBehavior:
//                                 //       FloatingLabelBehavior.always,
//                                 //       label: RichText(
//                                 //           text: TextSpan(children: [
//                                 //             TextSpan(
//                                 //               text: AppLocalizations.of(context)!
//                                 //                   .password_caps,
//                                 //               style: TextStyle(
//                                 //                   color: const Color.fromRGBO(
//                                 //                       102, 102, 102, 1),
//                                 //                   fontFamily: 'Inter',
//                                 //                   fontWeight: FontWeight.w600,
//                                 //                   fontSize: localHeight * 0.017),
//                                 //             ),
//                                 //             TextSpan(
//                                 //                 text: "\t*",
//                                 //                 style: TextStyle(
//                                 //                     color: const Color.fromRGBO(
//                                 //                         219, 35, 35, 1),
//                                 //                     fontFamily: 'Inter',
//                                 //                     fontWeight: FontWeight.w600,
//                                 //                     fontSize: localHeight * 0.017)),
//                                 //           ])),
//                                 //       hintStyle: TextStyle(
//                                 //           color:
//                                 //           const Color.fromRGBO(102, 102, 102, 0.3),
//                                 //           fontFamily: 'Inter',
//                                 //           fontWeight: FontWeight.w400,
//                                 //           fontSize: localHeight * 0.016),
//                                 //       hintText:
//                                 //       AppLocalizations.of(context)!.password_hint,
//                                 //       focusedBorder: OutlineInputBorder(
//                                 //           borderSide: const BorderSide(
//                                 //               color: Color.fromRGBO(82, 165, 160, 1)),
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //       border: OutlineInputBorder(
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //     ),
//                                 //     inputFormatters: [
//                                 //       FilteringTextInputFormatter.deny(' ')
//                                 //     ],
//                                 //     onChanged: (val) {
//                                 //       formKey.currentState!.validate();
//                                 //     },
//                                 //     validator: (value) {
//                                 //       if (value!.length < 8) {
//                                 //         return "Enter Minimum 8 Characters";
//                                 //       } else {
//                                 //         return null;
//                                 //       }
//                                 //     },
//                                 //     // validator: (value){
//                                 //     //   if(value!.isEmpty){
//                                 //     //     return 'Enter Password';
//                                 //     //   }
//                                 //     //   else if(value!.length < 8){
//                                 //     //     return 'Enter Minimum 8 characters for password';
//                                 //     //   }
//                                 //     //   else{
//                                 //     //     return null;
//                                 //     //   }
//                                 //     // },
//                                 //   ),
//                                 // ),
//                                 // SizedBox(
//                                 //   height: localHeight * 0.03,
//                                 // ),
//                                 // Align(
//                                 //   alignment: Alignment.topLeft,
//                                 //   child: TextFormField(
//                                 //     controller: studentconfirmPasswordController,
//                                 //     keyboardType: TextInputType.text,
//                                 //     decoration: InputDecoration(
//                                 //       floatingLabelBehavior:
//                                 //       FloatingLabelBehavior.always,
//                                 //       label: RichText(
//                                 //           text: TextSpan(children: [
//                                 //             TextSpan(
//                                 //               text: AppLocalizations.of(context)!
//                                 //                   .confirm_password,
//                                 //               style: TextStyle(
//                                 //                   color: const Color.fromRGBO(
//                                 //                       102, 102, 102, 1),
//                                 //                   fontFamily: 'Inter',
//                                 //                   fontWeight: FontWeight.w600,
//                                 //                   fontSize: localHeight * 0.017),
//                                 //             ),
//                                 //             TextSpan(
//                                 //                 text: "\t*",
//                                 //                 style: TextStyle(
//                                 //                     color: const Color.fromRGBO(
//                                 //                         219, 35, 35, 1),
//                                 //                     fontFamily: 'Inter',
//                                 //                     fontWeight: FontWeight.w600,
//                                 //                     fontSize: localHeight * 0.017)),
//                                 //           ])),
//                                 //       // SizedBox(
//                                 //       //   width: localWidth * 0.25,
//                                 //       //   child: Row(
//                                 //       //     children: [
//                                 //       //       Text(AppLocalizations.of(context)!.confirm_password,
//                                 //       //         style: TextStyle(
//                                 //       //           color: const Color.fromRGBO(51, 51, 51, 1),
//                                 //       //           fontSize: localHeight *0.016,
//                                 //       //           fontFamily: "Inter",
//                                 //       //           fontWeight: FontWeight.w600,
//                                 //       //         ),),
//                                 //       //       const Text("\t*", style: TextStyle(color: Colors.red)),
//                                 //       //     ],
//                                 //       //   ),
//                                 //       // ),
//                                 //       labelStyle: TextStyle(
//                                 //           color: const Color.fromRGBO(51, 51, 51, 1),
//                                 //           fontFamily: 'Inter',
//                                 //           fontWeight: FontWeight.w600,
//                                 //           fontSize: localHeight * 0.016),
//                                 //       hintStyle: TextStyle(
//                                 //           color:
//                                 //           const Color.fromRGBO(102, 102, 102, 0.3),
//                                 //           fontFamily: 'Inter',
//                                 //           fontWeight: FontWeight.w400,
//                                 //           fontSize: localHeight * 0.016),
//                                 //       hintText:
//                                 //       AppLocalizations.of(context)!.verify_password,
//                                 //       focusedBorder: OutlineInputBorder(
//                                 //           borderSide: const BorderSide(
//                                 //               color: Color.fromRGBO(82, 165, 160, 1)),
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //       border: OutlineInputBorder(
//                                 //           borderRadius: BorderRadius.circular(15)),
//                                 //     ),
//                                 //     onChanged: (value) {
//                                 //       formKey.currentState!.validate();
//                                 //     },
//                                 //     validator: (value) {
//                                 //       if (studentPasswordController.text !=
//                                 //           studentconfirmPasswordController.text) {
//                                 //         return 'Re-Enter Password';
//                                 //       } else if (value!.isEmpty) {
//                                 //         return 'Enter Confirm Password';
//                                 //       } else {
//                                 //         return null;
//                                 //       }
//                                 //     },
//                                 //   ),
//                                 // )
//                               ],
//                             ),
//                             //SizedBox(height:localHeight * 0.05),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: localHeight * 0.05,
//                       ),
//                       Center(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color.fromRGBO(
//                                 82, 165, 160, 1),
//                             minimumSize: const Size(280, 48),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(39),
//                             ),
//                           ),
//                           onPressed: () async {
//                             bool valid = formKey.currentState!.validate();
//                             StudentRegistrationModel student =
//                             StudentRegistrationModel(
//                                 firstName: studentFirstNameController.text,
//                                 lastName: studentLastNameController.text,
//                                 dob: d,
//                                 gender: gender,
//                                 countryNationality: selectedCountryCitizen
//                                     .dropDownValue?.value,
//                                 email: studentEmailController.text,
//                                 password: studentPasswordController.text,
//                                 rollNumber: studentRollNumberController.text,
//                                 organisationName:
//                                 studentOrganisationNameController.text,
//                                 countryResident:
//                                 selectedCountryResident
//                                     .dropDownValue?.value,
//                                 role: isAlso
//                                     ? ["student", "teacher"]
//                                     : ["student"]);
//                             if (valid) {
//                               LoginModel res =
//                               await QnaService.postUserDetailsService(student);
//                               if (res.code == 200) {
//                                 Navigator.pushNamed(
//                                   context, '/studentRegisVerifyOtpPage',
//                                   arguments: studentEmailController.text,);
//                                 // Navigator.push(
//                                 //   context,
//                                 //   PageTransition(
//                                 //       type: PageTransitionType.fade,
//                                 //       child: StudentRegisVerifyOtpPage(
//                                 //         email: studentEmailController.text,
//                                 //       )),
//                                 // );
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   PageTransition(
//                                     type: PageTransitionType.rightToLeft,
//                                     child: CustomDialog(
//                                       title: 'Incorrect Data',
//                                       content: '${res.message}',
//                                       button: AppLocalizations.of(context)!
//                                           .retry,
//                                     ),
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                           child: Text(
//                             AppLocalizations.of(context)!.sent_otp,
//                             style: TextStyle(
//                                 fontSize: localHeight * 0.024,
//                                 fontFamily: "Inter",
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: localHeight * 0.05,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               //)
//             ));
//       }
//     }
//     );}
// }
