// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  bool? login;
  String? email;
  String? password;
  String? role;
  String? firstName;
  String? lastName;
  String? token;
  int? userId;

  UserDetails({
    this.login,
    this.email,
    this.password,
    this.role,
    this.firstName,
    this.lastName,
    this.token,
    this.userId,
  });

  UserDetails copyWith({
    bool? login,
    String? email,
    String? password,
    String? role,
    String? firstName,
    String? lastName,
    String? token,
    int? userId,
  }) =>
      UserDetails(
        login: login ?? this.login,
        email: email ?? this.email,
        password: password ?? this.password,
        role: role ?? this.role,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        token: token ?? this.token,
        userId: userId ?? this.userId,
      );

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    login: json["login"],
    email: json["email"],
    password: json["password"],
    role: json["role"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    token: json["token"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "email": email,
    "password": password,
    "role": role,
    "firstName": firstName,
    "lastName": lastName,
    "token": token,
    "userId": userId,
  };

  @override
  String toString() {
    return 'UserDetails{login: $login, email: $email, password: $password, role: $role, firstName: $firstName, lastName: $lastName, token: $token, userId: $userId}';
  }
}
