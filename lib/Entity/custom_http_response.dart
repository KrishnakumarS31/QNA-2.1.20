// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.status,
    required this.data,
  });

  Status status;
  Data data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    status: Status.fromJson(json["status"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.userProfile,
    required this.roles,
  });

  List<UserProfile> userProfile;
  List<String> roles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userProfile: List<UserProfile>.from(json["user_profile"].map((x) => UserProfile.fromJson(x))),
    roles: List<String>.from(json["roles"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user_profile": List<dynamic>.from(userProfile.map((x) => x.toJson())),
    "roles": List<dynamic>.from(roles.map((x) => x)),
  };
}

class UserProfile {
  UserProfile({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.emailId,
    required this.residentCountry,
    required this.nationality,
    required this.emailIdVerified,
    required this.isActive,
    required this.createdOn,
    required this.reatedBy,
    required this.updatedBy,
    required this.pdatedOn,
  });

  int userId;
  String firstName;
  String lastName;
  String dob;
  String emailId;
  String residentCountry;
  String nationality;
  String emailIdVerified;
  String isActive;
  DateTime createdOn;
  int reatedBy;
  int updatedBy;
  String pdatedOn;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dob: json["dob"],
    emailId: json["email_id"],
    residentCountry: json["residentCountry"],
    nationality: json["nationality"],
    emailIdVerified: json["email_id_verified"],
    isActive: json["is_active"],
    createdOn: DateTime.parse(json["created_on"]),
    reatedBy: json["reated_by"],
    updatedBy: json["updated_by"],
    pdatedOn: json["pdated_on"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "dob": dob,
    "email_id": emailId,
    "residentCountry": residentCountry,
    "nationality": nationality,
    "email_id_verified": emailIdVerified,
    "is_active": isActive,
    "created_on": createdOn.toIso8601String(),
    "reated_by": reatedBy,
    "updated_by": updatedBy,
    "pdated_on": pdatedOn,
  };
}

class Status {
  Status({
    required this.code,
    required this.message,
    required this.type,
    required this.error,
  });

  int code;
  String message;
  String type;
  bool error;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"],
    message: json["message"],
    type: json["type"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "type": type,
    "error": error,
  };
}
