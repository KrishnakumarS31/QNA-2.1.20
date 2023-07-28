

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
  int? institutionId;

  UserDetails({
    this.login,
    this.email,
    this.password,
    this.role,
    this.firstName,
    this.lastName,
    this.token,
    this.userId,
    this.institutionId
  });

  UserDetails copyWith({
    bool? login,
    String? email,
    String? password,
    String? role,
    String? firstName,
    String? lastName,
    String? token,
    int? institutionId,
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
        institutionId: institutionId ?? this.institutionId,
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
    institutionId: json["institutionId"]
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
    "institutionId":institutionId
  };

  @override
  String toString() {
    return 'UserDetails{login: $login, email: $email, password: $password, role: $role, firstName: $firstName, lastName: $lastName, token: $token, userId: $userId,institutionId: $institutionId}';
  }
}
