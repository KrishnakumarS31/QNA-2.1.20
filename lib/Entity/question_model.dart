// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

// Question questionFromJson(String str) => Question.fromJson(json.decode(str));
//
// String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    required this.id,
    required this.questionType,
    required this.mark,
    required this.question,
    required this.options,
    required this.selectedOptions,
  });

  int id;
  String questionType;
  int mark;
  String question;
  List<String> options;
  int selectedOptions;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
      questionType: json["questionType"],
    mark: json["mark"],
    question: json["question"],
    options: List<String>.from(json["options"].map((x) => x)),
      selectedOptions: json['selectedOptions']==null?0:json['selectedOptions']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionType": questionType,
    "mark": mark,
    "question": question,
    "options": List<dynamic>.from(options.map((x) => x)),
    "selectedOptions": selectedOptions
  };
}
