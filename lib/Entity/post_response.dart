// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

PostResponse postResponseFromJson(String str) => PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  PostResponse({
    required this.status,
    required this.data,
  });

  Status status;
  Data data;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
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
    required this.userRegister,
  });

  List<UserRegister> userRegister;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userRegister: List<UserRegister>.from(json["user_register"].map((x) => UserRegister.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_register": List<dynamic>.from(userRegister.map((x) => x.toJson())),
  };
}

class UserRegister {
  UserRegister({
    required this.userId,
    required this.createdOn,
  });

  String userId;
  String createdOn;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
    userId: json["userId"],
    createdOn: json["createdOn"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "createdOn": createdOn,
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
