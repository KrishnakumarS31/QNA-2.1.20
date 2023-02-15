// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  String userId;
  String accessToken;
  String refreshToken;
  String expiresAt;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        userId: json["userId"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        expiresAt: json["expiresAt"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "expiresAt": expiresAt,
      };
}
