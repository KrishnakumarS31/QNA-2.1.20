// To parse this JSON data, do
//
//     final getQuestionModel = getQuestionModelFromJson(jsonString);

import 'dart:convert';
import '../Teacher/question_entity.dart';
ResponseEntity responseEntityFromJson(String str) => ResponseEntity.fromJson(json.decode(str));

String responseEntityToJson(ResponseEntity data) => json.encode(data.toJson());

class ResponseEntity {
  ResponseEntity({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  dynamic data;

  factory ResponseEntity.fromJson(Map<String, dynamic> json) => ResponseEntity(
    code: json["code"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data,
  };
}

