// To parse this JSON data, do
//
//     final staticResponse = staticResponseFromJson(jsonString);

import 'dart:convert';

StaticResponse staticResponseFromJson(String str) =>
    StaticResponse.fromJson(json.decode(str));

String staticResponseToJson(StaticResponse data) => json.encode(data.toJson());

class StaticResponse {
  StaticResponse({
    this.code,
    required this.message,
  });

  int? code;
  String message;

  factory StaticResponse.fromJson(Map<String, dynamic> json) => StaticResponse(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
