

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };

  @override
  String toString() {
    return 'UserDataModel{code: $code, message: $message, data: $data}';
  }
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.countryNationality,
    required this.countryResident,
    required this.email,
    required this.rollNumber,
    required this.organisationName,
    required this.role,
    required this.password,
    required this.createdBy,
    required this.updatedBy,
    required this.isActive,
    required this.emailVerified,
    required this.loginId,
    required this.organizationId
  });

  int id;
  String firstName;
  String lastName;
  int dob;
  String gender;
  String countryNationality;
  String countryResident;
  String email;
  String rollNumber;
  String organisationName;
  List<dynamic> role;
  String password;
  String createdBy;
  String updatedBy;
  bool isActive;
  bool emailVerified;
  String loginId;
  int organizationId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dob: json["dob"],
    gender: json["gender"],
    countryNationality: json["country_nationality"],
    countryResident: json["country_resident"],
    email: json["email"],
    rollNumber: json["roll_number"],
    organizationId: json["organisation_id"] ?? 0,
    organisationName: json["institution_name"] ?? "",
    role: List<dynamic>.from(json["role"].map((x) => x)),
    password: json["password"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    isActive: json["is_active"],
    emailVerified: json["email_verified"],
    loginId: json["login_id"] ?? "0"
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "dob": dob,
    "gender": gender,
    "country_nationality": countryNationality,
    "country_resident": countryResident,
    "email": email,
    "roll_number": rollNumber,
    "organisation_name": organisationName,
    "role": role==null?[]:List<dynamic>.from(role.map((x) => x)),
    "password": password,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "is_active": isActive,
    "email_verified": emailVerified,
    "login_id":loginId,
    "organisation_id": organizationId
  };

  @override
  String toString() {
    return 'Data{id: $id, firstName: $firstName, lastName: $lastName, dob: $dob, gender: $gender, countryNationality: $countryNationality, countryResident: $countryResident, email: $email, rollNumber: $rollNumber, organisationName: $organisationName, role: $role, password: $password, createdBy: $createdBy, updatedBy: $updatedBy, isActive: $isActive, emailVerified: $emailVerified}';
  }
}
