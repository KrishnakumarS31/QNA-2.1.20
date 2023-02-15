// To parse this JSON data, do
//
//     final status = statusFromJson(jsonString);

import 'dart:convert';

Status statusFromJson(String str) => Status.fromJson(json.decode(str));

String statusToJson(Status data) => json.encode(data.toJson());

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
