import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:qna_test/EntityModel/user_data_model.dart';
import '../Components/custom_alert_box.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/custom_http_response.dart';
import '../Entity/user_details.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/student_registration_model.dart';
import '../Providers/LanguageChangeProvider.dart';
import '../Services/qna_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class TeacherEditProfilePage extends StatefulWidget {
  const TeacherEditProfilePage({super.key, required this.userDataModel});
  final UserDataModel userDataModel;
  @override
  TeacherEditProfilePageState createState() => TeacherEditProfilePageState();
}

class TeacherEditProfilePageState extends State<TeacherEditProfilePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController teacherFirstNameController = TextEditingController();
  TextEditingController teacherLastNameController = TextEditingController();
  TextEditingController teacherEmailController = TextEditingController();
  TextEditingController teacherRollNumberController = TextEditingController();
  TextEditingController teacherOrganisationNameController =
  TextEditingController();
  TextEditingController teacherPasswordController = TextEditingController();
  TextEditingController teacherconfirmPasswordController = TextEditingController();
  TextEditingController organisationIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  // bool tocCheck = false;
  bool pPCheck = false;
  // bool also = false;
  bool error = true;
  String? enableAsStudent;
  String? gender;
  // final studentDobController = TextEditingController();
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
  late SingleValueDropDownController selectedCountryCitizen;
  List<String> countryResidentList = [
    "India",
    "United States",
    "European Union",
    "Rest of World"
  ];
  late SingleValueDropDownController selectedCountryResident;
  int d = 0;
  List<String> roleBackup=[];
  UserDetails userDetails=UserDetails();
  @override
  void initState() {
    userDetails=Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
    roleBackup= List.from(widget.userDataModel.data!.role);
    enableAsStudent= widget.userDataModel.data!=null &&
        roleBackup.contains("student")
        ? "yes"
        : "no";
    selectedCountryResident=SingleValueDropDownController(data: DropDownValueModel(
        name: widget.userDataModel.data?.countryResident ?? "",
        value: widget.userDataModel.data?.countryResident ?? ""));
    selectedCountryCitizen=SingleValueDropDownController(data: DropDownValueModel(
        name: widget.userDataModel.data?.countryNationality ?? "",
        value: widget.userDataModel.data?.countryNationality ?? ""));
    gender=widget.userDataModel.data?.gender ?? "";
    teacherFirstNameController.text=widget.userDataModel.data?.firstName ?? "";
    teacherLastNameController.text=widget.userDataModel.data?.lastName ?? "";
    teacherEmailController.text=widget.userDataModel.data!.email.isEmpty ? "-" :widget.userDataModel.data!.email;
    teacherRollNumberController.text=widget.userDataModel.data?.rollNumber ?? "";
    organisationIdController.text = widget.userDataModel.data?.organizationId.toString() ?? "-";
    print("WIDGET USERID");
    print(widget.userDataModel.data!.loginId.isEmpty);
    userIdController.text = (widget.userDataModel.data!.loginId.isEmpty || widget.userDataModel.data!.loginId == null) ? "-" :  widget.userDataModel.data!.loginId;
    teacherOrganisationNameController.text=widget.userDataModel.data?.organisationName ?? "-";
    // teacherIsTeacherController.text=widget.userDataModel.data?.
    super.initState();
  }

  @override
  void dispose() {
    // teacherDobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userDataModel.data!.role);
    print('backup$roleBackup');

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
                        AppLocalizations.of(context)!.edit_user_profile,
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
                                              SizedBox(
                                                height: localHeight * 0.05,
                                              ),
                                              Center(
                                                child:
                                                SizedBox(
                                                    width: localWidth * 0.8,
                                                    child: TextFormField(
                                                      controller: teacherFirstNameController,
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
                                                      controller: teacherLastNameController,
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
                                                                      0.0155),
                                                            ),
                                                          ]
                                                      ),
                                                      Row(
                                                        children: [
                                                          Radio(
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                          .citizen_country,
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
                                                            .resident_country,
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
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                  child:
                                                  SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      TextFormField(
                                                        enabled: false,
                                                        controller: teacherEmailController,
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
                                                                    153, 153, 153, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.020),
                                                          ),),
                                                      ))),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                  child:
                                                  SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      TextFormField(
                                                        enabled: false,
                                                        controller: userIdController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                          floatingLabelBehavior:
                                                          FloatingLabelBehavior.always,
                                                          label: Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .user_id,
                                                            style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    153, 153, 153, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.020),
                                                          ),),
                                                      ))),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                child:
                                                SizedBox(
                                                    width: localWidth * 0.8,
                                                    child: TextFormField(
                                                      enabled:false,
                                                      controller: organisationIdController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                    child:TextFormField(
                                                      controller: teacherOrganisationNameController,
                                                      enabled: false,
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
                                                          return 'Enter Institution Name';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: localHeight * 0.03,
                                              ),
                                              //Padding(
                                               //   padding: EdgeInsets.only(
                                                 //     left: localWidth * 0.05, right: localWidth * 0.05),
                                                  //child:
                                                  //Column(
                                                    //children: [
                                                      //Row(
                                                        //  children:[
                                                          //  Text(
                                                            //  AppLocalizations.of(
                                                              //    context)!
                                                                //  .enable_as_student,
                                                              //style: TextStyle(
                                                                //  color: const Color
                                                                  //    .fromRGBO(
                                                                    //  102, 102, 102, 1),
                                                                  //fontFamily: 'Inter',
                                                                  //fontWeight: FontWeight
                                                                    //  .w600,
                                                                  // fontSize: localHeight *
                                                                     // 0.0155),
                                                    //        ),
                                                      //    ]
                                                      //),
                                                      //Row(
                                                        //children: [
                                                          //Radio(
                                                            //activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                            //value: "yes",
                                                             //groupValue: enableAsStudent,
                                                            //onChanged: (value) {
                                                              //setState(() {
                                                                //enableAsStudent =
                                                              //  value..toString();
                                                                //roleBackup.add('student');
                                                              //});
                                                            //},
                                                          //),
                                                          //Text(
                                                            //AppLocalizations.of(
                                                              //  context)!
                                                                //.yes,
                                                            //style: TextStyle(
                                                              //  color: const Color
                                                                //    .fromRGBO(
                                                                //    51, 51, 51, 1),
                                                                //fontFamily: 'Inter',
                                                                //fontWeight: FontWeight
                                                                  //  .w400,
                                                                //fontSize:
                                                                //localHeight * 0.016),
                                                          //),
                                                          //Radio(
                                                           // activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                            //value: "no",
                                                           // groupValue: enableAsStudent,
                                                            //onChanged: (value) {
                                                              //setState(() {
                                                                //enableAsStudent =
                                                                 //   value.toString();
                                                               // roleBackup.remove('student');
                                                             // });
                                                           // },
                                                         // ),
                                                         // Text(
                                                            //AppLocalizations.of(
                                                                //context)!
                                                              //  .no,
                                                            //style: TextStyle(
                                                                //color: const Color
                                                                    //.fromRGBO(
                                                                  //  51, 51, 51, 1),
                                                                //fontFamily: 'Inter',
                                                                //fontWeight: FontWeight
                                                               //     .w400,
                                                             //   fontSize:
                                                           //     localHeight * 0.016),
                                                         // ),
                                                       // ],
                                                     // ),
                                                   // ],
                                                 // )),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    minimumSize: const Size(250, 40),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(39),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    bool valid = formKey.currentState!.validate();
                                                    StudentRegistrationModel teacher =
                                                    StudentRegistrationModel(
                                                        firstName: teacherFirstNameController.text,
                                                        lastName: teacherLastNameController.text,
                                                        dob: widget.userDataModel.data!.dob,
                                                        gender: gender,
                                                        countryNationality: selectedCountryCitizen
                                                            .dropDownValue?.value,
                                                        email: teacherEmailController.text,
                                                        password: teacherPasswordController.text,
                                                        countryResident:
                                                        selectedCountryResident
                                                            .dropDownValue?.value,
                                                        role: roleBackup,
                                                        userRole: "teacher",
                                                      organisationName: widget.userDataModel.data?.organisationName,
                                                      organisationId: widget.userDataModel.data!.organizationId,

                                                      //also == true?
                                                      //["student","teacher"]
                                                      //: ["student"]
                                                    );

                                                    if (valid) {
                                                      showAlertDialog(
                                                          context,teacher);
                                                    }

                                                  }, child: Text(AppLocalizations.of(
                                                    context)!.submit),
                                                ),
                                              ),
                                              SizedBox(
                                                height: localHeight * 0.03,
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
                        AppLocalizations.of(context)!.edit_user_profile,
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
                                              SizedBox(
                                                height: localHeight * 0.05,
                                              ),
                                              Center(
                                                child:
                                                SizedBox(
                                                    width: localWidth * 0.8,
                                                    child: TextFormField(
                                                      controller: teacherFirstNameController,
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
                                                      controller: teacherLastNameController,
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
                                                                      0.0155),
                                                            ),
                                                          ]
                                                      ),
                                                      Row(
                                                        children: [
                                                          Radio(
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                          .citizen_country,
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
                                                            .resident_country,
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
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                  child:
                                                  SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      TextFormField(
                                                        enabled: false,
                                                        controller: teacherEmailController,
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
                                                                    153, 153, 153, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.020),
                                                          ),),
                                                      ))),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                  child:
                                                  SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      TextFormField(
                                                        enabled: false,
                                                        controller: userIdController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                          floatingLabelBehavior:
                                                          FloatingLabelBehavior.always,
                                                          label: Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .user_id,
                                                            style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    153, 153, 153, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.020),
                                                          ),),
                                                      ))),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                child:
                                                SizedBox(

                                                    width: localWidth * 0.8,
                                                    child: TextFormField(
                                                      enabled:false,
                                                      controller: organisationIdController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                    child:TextFormField(
                                                      enabled:false,
                                                      controller: teacherOrganisationNameController,
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
                                                          return 'Enter Institution Name';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: localHeight * 0.03,
                                              ),
                                             // Padding(
                                               //   padding: EdgeInsets.only(
                                                 //     left: localWidth * 0.05, right: localWidth * 0.05),
                                                  //child:
                                                  //Column(
                                                    //children: [
                                                      //Row(
                                                        //  children:[
                                                          //  Text(
                                                            //  AppLocalizations.of(
                                                              //    context)!.enable_as_student,
                                                              //style: TextStyle(
                                                                //  color: const Color
                                                                  //    .fromRGBO(
                                                                    //  102, 102, 102, 1),
                                                               //   fontFamily: 'Inter',
                                                                 // fontWeight: FontWeight
                                                                   //   .w600,
                                                                  //fontSize: localHeight *
                                                                    //  0.0155),
                                                            //),
                                                          //]
                                                    //  ),
                                                      //Row(
                                                        //children: [
                                                          //Radio(
                                                            //activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                            //value: "yes",
                                                            //groupValue: enableAsStudent,
                                                            //onChanged: (value) {
                                                              //setState(() {
                                                                //enableAsStudent =
                                                                //value..toString();
                                                                //roleBackup.add('student');
                                                              //});
                                                            //},
                                                          //),
                                                          //Text(
                                                            //AppLocalizations.of(
                                                              //  context)!
                                                                //.yes,
                                                           // style: TextStyle(
                                                             //   color: const Color
                                                               //     .fromRGBO(
                                                                 //   51, 51, 51, 1),
                                                                //fontFamily: 'Inter',
                                                                //fontWeight: FontWeight
                                                                  //  .w400,
                                                                //fontSize:
                                                                //localHeight * 0.016),
                                                          //),
                                                          //Radio(
                                                            //activeColor: const Color.fromRGBO(82, 165, 160, 1),
                                                            //value: "no",
                                                            //groupValue: enableAsStudent,
                                                            //onChanged: (value) {
                                                            //  setState(() {
                                                              //  enableAsStudent =
                                                                //    value.toString();
                                                               // roleBackup.remove('student');
                                                              //});
                                                            //},
                                                          //),
                                                          //Text(
                                                            //AppLocalizations.of(
                                                              //  context)!
                                                                //.no,
                                                           // style: TextStyle(
                                                             //   color: const Color
                                                               //     .fromRGBO(
                                                                 //   51, 51, 51, 1),
                                                             //   fontFamily: 'Inter',
                                                               // fontWeight: FontWeight
                                                                 //   .w400,
                                                            //    fontSize:
                                                              //  localHeight * 0.016),
                                                        //  ),
                                                        //],
                                                      //),
                                                   // ],
                                                  //)),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    minimumSize: const Size(280, 48),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(39),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    bool valid = formKey.currentState!.validate();
                                                    StudentRegistrationModel teacher =
                                                    StudentRegistrationModel(
                                                        firstName: teacherFirstNameController.text,
                                                        lastName: teacherLastNameController.text,
                                                        dob: widget.userDataModel.data!.dob,
                                                        gender: gender,
                                                        countryNationality: selectedCountryCitizen
                                                            .dropDownValue?.value,
                                                        email: teacherEmailController.text,
                                                        password: teacherPasswordController.text,
                                                        countryResident:
                                                        selectedCountryResident
                                                            .dropDownValue?.value,
                                                        role: roleBackup,
                                                        userRole: "teacher",
                                                      organisationName: widget.userDataModel.data?.organisationName,
                                                      organisationId: widget.userDataModel.data!.organizationId,
                                                      //also == true?
                                                      //["student","teacher"]
                                                      //: ["student"]
                                                    );

                                                    if (valid) {
                                                      showAlertDialog(
                                                          context,teacher);
                                                    }

                                                  }, child: Text(AppLocalizations.of(
                                                    context)!.submit),
                                                ),
                                              ),
                                              SizedBox(
                                                height: localHeight * 0.03,
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
                          // print('backup$roleBackup');
                          // print(widget.userDataModel.data!.role);
                          // roleBackup=[];
                          // widget.userDataModel.data!.role=roleBackup;
                          Navigator.of(context).pop();
                        },
                      ),
                      centerTitle: true,
                      title: Text(
                        AppLocalizations.of(context)!.edit_user_profile,
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
                                              SizedBox(
                                                height: localHeight * 0.05,
                                              ),
                                              Center(
                                                child:
                                                SizedBox(
                                                    width: localWidth * 0.8,
                                                    child: TextFormField(
                                                      controller: teacherFirstNameController,
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
                                                      controller: teacherLastNameController,
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
                                                                      0.0155),
                                                            ),
                                                          ]
                                                      ),
                                                      Row(
                                                        children: [
                                                          Radio(
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                            activeColor: const Color.fromRGBO(82, 165, 160, 1),
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
                                                          .citizen_country,
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
                                                            .resident_country,
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
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                  child:
                                                  SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      TextFormField(
                                                        enabled: false,
                                                        controller: teacherEmailController,
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
                                                                    153, 153, 153, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.020),
                                                          ),),
                                                      ))),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                  child:
                                                  SizedBox(
                                                      width: localWidth * 0.8,
                                                      child:
                                                      TextFormField(
                                                        enabled: false,
                                                        controller: userIdController,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                          floatingLabelBehavior:
                                                          FloatingLabelBehavior.always,
                                                          label: Text(
                                                            AppLocalizations.of(
                                                                context)!
                                                                .user_id,
                                                            style: TextStyle(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    153, 153, 153, 1),
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: localHeight *
                                                                    0.020),
                                                          ),),
                                                      ))),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                child:
                                                SizedBox(
                                                    width: localWidth * 0.8,
                                                    child: TextFormField(
                                                      enabled: false,
                                                      controller: organisationIdController,
                                                      keyboardType: TextInputType.text,
                                                      decoration: InputDecoration(
                                                        labelStyle: Theme.of(context).textTheme.headlineMedium,
                                                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                                    child:TextFormField(
                                                      enabled: false,
                                                      controller: teacherOrganisationNameController,
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
                                                          return 'Enter Institution Name';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: localHeight * 0.03,
                                              ),
                                              SizedBox(
                                                height: localHeight * 0.01,
                                              ),
                                              Center(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color.fromRGBO(82, 165, 160, 1),
                                                    minimumSize: const Size(280, 48),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(39),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    bool valid = formKey.currentState!.validate();
                                                    StudentRegistrationModel teacher =
                                                    StudentRegistrationModel(
                                                        firstName: teacherFirstNameController.text,
                                                        lastName: teacherLastNameController.text,
                                                        dob: widget.userDataModel.data!.dob,
                                                        gender: gender,
                                                        countryNationality: selectedCountryCitizen
                                                            .dropDownValue?.value,
                                                        email: teacherEmailController.text,
                                                        password: widget.userDataModel.data!.password,
                                                        rollNumber: teacherRollNumberController
                                                            .text,
                                                        organisationName:
                                                        teacherOrganisationNameController.text,
                                                        countryResident:
                                                        selectedCountryResident
                                                            .dropDownValue?.value,
                                                        role: roleBackup,
                                                        userRole: "teacher",
                                                      //organisationName: widget.userDataModel.data?.organisationName,
                                                      organisationId: widget.userDataModel.data!.organizationId,
                                                      //also == true?
                                                      //["student","teacher"]
                                                      //: ["student"]
                                                    );

                                                    if (valid) {
                                                      showAlertDialog(
                                                          context,teacher);
                                                    }

                                                  }, child: Text(AppLocalizations.of(
                                                    context)!.submit),
                                                ),
                                              ),
                                              SizedBox(
                                                height: localHeight * 0.03,
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

  showAlertDialog(BuildContext context,StudentRegistrationModel teacher) {
    // set up the button
    double height = MediaQuery.of(context).size.height;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.warning,
            size: height * 0.04,
            color: const Color.fromRGBO(238, 71, 0, 1),
          ),
          SizedBox(
            width: height * 0.002,
          ),
          Text(
            AppLocalizations.of(context)!
                .confirm,
            //"Success!",
            style: const TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ],
      ),
      content: Text(
        AppLocalizations.of(context)!
            .submit_your_profile,
        style: const TextStyle(
            color: Color.fromRGBO(51, 51, 51, 1),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 15),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(48, 145, 139, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(39))
          ),
          child: Text(
            AppLocalizations.of(context)!
                .yes,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          onPressed: () async {
            LoginModel res =
            await QnaService.editUserDetailsService(
                teacher,widget.userDataModel.data!.id,userDetails);
            print(res.code);
            if (res.code == 200) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: height * 0.04,
                            color: const Color.fromRGBO(66, 194, 0, 1),
                          ),
                          SizedBox(
                            width: height * 0.002,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .success,
                            //"Success!",
                            style: const TextStyle(
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      content: const Text(
                        "Your profile has been edited successfully.",
                        style: TextStyle(
                            color: Color.fromRGBO(51, 51, 51, 1),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      actions: [
                        TextButton(

                          child: const Text(
                            "OK",
                            style: TextStyle(
                                color: Color.fromRGBO(82, 165, 160, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.popUntil(context, ModalRoute.withName('/teacherSelectionPage'));
                          },
                        )
                      ],
                    );;
                  },
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

            // Navigator.popUntil(context, ModalRoute.withName('/```student```MemberLoginPage'));
          },
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(39),side: const BorderSide(color: Color.fromRGBO(82, 165, 160, 1),),)
          ),
          child: Text(
            AppLocalizations.of(context)!
                .no,
            style: const TextStyle(
                color: Color.fromRGBO(82, 165, 160, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
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
