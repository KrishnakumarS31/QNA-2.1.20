// To parse this JSON data, do
//
//     final demoQuestionModel = demoQuestionModelFromJson(jsonString);

import 'dart:convert';

DemoQuestionModel? demoQuestionModelFromJson(String str) =>
    DemoQuestionModel.fromJson(json.decode(str));

String demoQuestionModelToJson(DemoQuestionModel? data) =>
    json.encode(data!.toJson());

class DemoQuestionModel {
  DemoQuestionModel({
    required this.id,
    required this.questionType,
    required this.subject,
    required this.topic,
    required this.subTopic,
    required this.studentClass,
    required this.question,
    this.choices,
    this.correctChoice,
    this.advice,
    this.url,
  });

  dynamic id;
  String questionType;
  String subject;
  String topic;
  String subTopic;
  String studentClass;
  String question;
  List<String?>? choices;
  List<int?>? correctChoice;
  String? advice;
  String? url;

  factory DemoQuestionModel.fromJson(Map<String, dynamic> json) =>
      DemoQuestionModel(
        id: json["id"],
        questionType: json["questionType"],
        subject: json["subject"],
        topic: json["topic"],
        subTopic: json["subTopic"],
        studentClass: json["studentClass"],
        question: json["question"],
        choices: json["choices"] == null
            ? []
            : List<String?>.from(json["choices"]!.map((x) => x)),
        correctChoice: json["correctChoice"] == null
            ? []
            : List<int?>.from(json["correctChoice"]!.map((x) => x)),
        advice: json["advice"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questionType": questionType,
        "subject": subject,
        "topic": topic,
        "subTopic": subTopic,
        "studentClass": studentClass,
        "question": question,
        "choices":
            choices == null ? [] : List<dynamic>.from(choices!.map((x) => x)),
        "correctChoice": correctChoice == null
            ? []
            : List<dynamic>.from(correctChoice!.map((x) => x)),
        "advice": advice,
        "url": url,
      };
}
