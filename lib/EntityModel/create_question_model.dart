// To parse this JSON data, do
//
//     final createQuestionModel = createQuestionModelFromJson(jsonString);

import 'dart:convert';

import '../Entity/Teacher/question_entity.dart';

CreateQuestionModel createQuestionModelFromJson(String str) =>
    CreateQuestionModel.fromJson(json.decode(str));

String createQuestionModelToJson(CreateQuestionModel data) =>
    json.encode(data.toJson());

class CreateQuestionModel {
  CreateQuestionModel({
    this.authorId,
    this.questions,
  });

  int? authorId;
  List<Question>? questions;

  factory CreateQuestionModel.fromJson(Map<String, dynamic> json) =>
      CreateQuestionModel(
        authorId: json["author_id"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "author_id": authorId,
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'CreateQuestionModel{authorId: $authorId, questions: ${questions.toString()}}';
  }
}
