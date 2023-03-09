// To parse this JSON data, do
//
//     final getQuestionModel = getQuestionModelFromJson(jsonString);

import 'dart:convert';
import '../Entity/Teacher/question_entity.dart';

GetQuestionModel getQuestionModelFromJson(String str) => GetQuestionModel.fromJson(json.decode(str));

String getQuestionModelToJson(GetQuestionModel data) => json.encode(data.toJson());

class GetQuestionModel {
  GetQuestionModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Question>? data;

  factory GetQuestionModel.fromJson(Map<String, dynamic> json) => GetQuestionModel(
    code: json["code"],
    message: json["message"],
    data: List<Question>.from(json["data"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data==null?'':List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

