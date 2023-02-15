// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.nationality,
    required this.residentCountry,
    required this.email,
    required this.rollNumber,
    required this.organisationName,
    required this.roleId,
    required this.password,
  });

  String firstName;
  String lastName;
  String dob;
  String gender;
  String nationality;
  String residentCountry;
  String email;
  String rollNumber;
  String organisationName;
  List<String> roleId;
  String password;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["dob"],
        gender: json["gender"],
        nationality: json["nationality"],
        residentCountry: json["residentCountry"],
        email: json["email"],
        rollNumber: json["rollNumber"],
        organisationName: json["organisationName"],
        roleId: List<String>.from(json["roleId"].map((x) => x)),
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "gender": gender,
        "nationality": nationality,
        "residentCountry": residentCountry,
        "email": email,
        "rollNumber": rollNumber,
        "organisationName": organisationName,
        "roleId": List<dynamic>.from(roleId.map((x) => x)),
        "password": password,
      };
}
