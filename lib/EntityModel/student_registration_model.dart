// To parse this JSON data, do
//
//     final studentRegistrationModel = studentRegistrationModelFromJson(jsonString);

import 'dart:convert';

StudentRegistrationModel studentRegistrationModelFromJson(String str) =>
    StudentRegistrationModel.fromJson(json.decode(str));

String studentRegistrationModelToJson(StudentRegistrationModel data) =>
    json.encode(data.toJson());

class StudentRegistrationModel {
  StudentRegistrationModel({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.countryNationality,
    required this.email,
    required this.password,
     this.rollNumber,
    this.organisationName,
    required this.countryResident,
    required this.role,
    required this.userRole,
    this.institutionId,
    this.organisationId
  });

  String firstName;
  String lastName;
  int dob;
  String? gender;
  String countryNationality;
  String email;
  String password;
  String? rollNumber;
  String? organisationName;
  String countryResident;
  List<String> role;
  String userRole;
  int? institutionId;
  int? organisationId;

  factory StudentRegistrationModel.fromJson(Map<String, dynamic> json) =>
      StudentRegistrationModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        dob: json["dob"],
        gender: json["gender"],
        countryNationality: json["country_nationality"],
        email: json["email"],
        password: json["password"],
        rollNumber: json["roll_number"],
        organisationName: json["organisation_name"],
        organisationId: json["organisation_id"],
        countryResident: json["country_resident"],
        role: json["role"],
        userRole : json["user_role"],
          institutionId: json["institution_id"]
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "dob": dob,
        "gender": gender,
        "country_nationality": countryNationality,
        "email": email,
        "password": password,
        "roll_number": rollNumber,
        "organisation_name": organisationName,
        "country_resident": countryResident,
        "role": role,
        "user_role": userRole,
    "institution_id":institutionId,
    "organisation_id":organisationId
      };
}
