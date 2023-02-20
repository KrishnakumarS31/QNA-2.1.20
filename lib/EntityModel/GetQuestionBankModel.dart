// To parse this JSON data, do
//
//     final getQuestionBankModel = getQuestionBankModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

GetQuestionBankModel getQuestionBankModelFromJson(String str) => GetQuestionBankModel.fromJson(json.decode(str));

String getQuestionBankModelToJson(GetQuestionBankModel data) => json.encode(data.toJson());

class GetQuestionBankModel {
  GetQuestionBankModel({
    required this.status,
    required this.message,
    this.data,
  });

  int status;
  String message;
  Data? data;

  factory GetQuestionBankModel.fromJson(Map<String, dynamic> json) => GetQuestionBankModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.questions,
  });

  List<Question> questions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Question {
  Question({
     this.questionId,
     this.userId,
     this.questionTypeId,
     this.questionType,
     this.questionMarks,
     this.subject,
     this.topic,
     this.subTopic,
     this.questionClass,
     this.question,
     this.choices,
    this.choicesAnswer,
    this.advisorText,
    this.advisorUrl,
  });

  int? questionId;
  int? userId;
  int? questionTypeId;
  String? questionType;
  int? questionMarks;
  String? subject;
  String? topic;
  String? subTopic;
  String? questionClass;
  String? question;
  List<Choice>? choices;
  List<Choice>? choicesAnswer;
  String? advisorText;
  String? advisorUrl;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"],
    userId: json["user_id"],
    questionTypeId: json["question_type_id"],
    questionType: json["question_type"],
    questionMarks: json["question_marks"],
    subject: json["subject"],
    topic: json["topic"],
    subTopic: json["sub_topic"],
    questionClass: json["class"],
    question: json["question"],
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    choicesAnswer: json["choices_answer"] == null ? [] : List<Choice>.from(json["choices_answer"]!.map((x) => Choice.fromJson(x))),
    advisorText: json["advisor_text"],
    advisorUrl: json["advisor_url"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "user_id": userId,
    "question_type_id": questionTypeId,
    "question_type": questionType,
    "question_marks": questionMarks,
    "subject": subject,
    "topic": topic,
    "sub_topic": subTopic,
    "class": questionClass,
    "question": question,
    "choices": List<dynamic>.from(choices!.map((x) => x.toJson())),
    "choices_answer": choicesAnswer == null ? [] : List<dynamic>.from(choicesAnswer!.map((x) => x.toJson())),
    "advisor_text": advisorText,
    "advisor_url": advisorUrl,
  };
}

@immutable
class Choice {
  Choice({
    required this.choiceId,
    required this.choiceText,
  });

  int choiceId;
  String choiceText;

  @override
  bool operator ==(covariant Choice other){
    if(identical(this, other)) return true;
    return other.runtimeType==Choice && other.choiceId==choiceId && other.choiceText==choiceText;
  }

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    choiceId: json["choice_id"],
    choiceText: json["choice_text"],
  );

  Map<String, dynamic> toJson() => {
    "choice_id": choiceId,
    "choice_text": choiceText,
  };

  @override
  // TODO: implement hashCode
  int get hashCode => choiceId.hashCode ^ choiceText.hashCode;

}
