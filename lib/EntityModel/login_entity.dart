// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  dynamic data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return 'LoginModel{code: $code, message: $message, data: $data}';
  }
}

class Data {
  Data({this.accessToken, this.userId, this.firstName, this.lastName, this.institutionId});

  String? firstName;
  String? lastName;
  String? accessToken;
  int? userId;
  int? institutionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      accessToken: json["access_token"],
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      institutionId: json["institution_id"]);

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
    "institution_id": institutionId
      };

  @override
  String toString() {
    return 'Data{firstName: $firstName, lastName: $lastName, accessToken: $accessToken, userId: $userId, institutionId: $institutionId}';
  }
}
