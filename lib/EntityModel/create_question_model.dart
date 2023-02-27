// To parse this JSON data, do
//
//     final createQuestionModel = createQuestionModelFromJson(jsonString);

import 'dart:convert';

CreateQuestionModel createQuestionModelFromJson(String str) => CreateQuestionModel.fromJson(json.decode(str));

String createQuestionModelToJson(CreateQuestionModel data) => json.encode(data.toJson());

class CreateQuestionModel {
  CreateQuestionModel({
    this.authorId,
    this.questions,
  });

  int? authorId;
  List<Question>? questions;

  factory CreateQuestionModel.fromJson(Map<String, dynamic> json) => CreateQuestionModel(
    authorId: json["author_id"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "author_id": authorId,
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    this.question,
    this.questionType,
    this.advisorText,
    this.advisorUrl,
    this.subject,
    this.topic,
    this.subTopic,
    this.questionClass,
    this.choices,
  });

  String? question;
  String? questionType;
  String? advisorText;
  String? advisorUrl;
  String? subject;
  String? topic;
  String? subTopic;
  String? questionClass;
  List<Choice>? choices;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    question: json["question"],
    questionType: json["question_type"],
    advisorText: json["advisor_text"],
    advisorUrl: json["advisor_url"],
    subject: json["subject"],
    topic: json["topic"],
    subTopic: json["sub_topic"],
    questionClass: json["class"],
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "question_type": questionType,
    "advisor_text": advisorText,
    "advisor_url": advisorUrl,
    "subject": subject,
    "topic": topic,
    "sub_topic": subTopic,
    "class": questionClass,
    "choices": List<dynamic>.from(choices!.map((x) => x.toJson())),
  };
}

class Choice {
  Choice({
    this.choiceText,
    this.rightChoice,
  });

  String? choiceText;
  bool? rightChoice;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    choiceText: json["choice_text"],
    rightChoice: json["right_choice"],
  );

  Map<String, dynamic> toJson() => {
    "choice_text": choiceText,
    "right_choice": rightChoice,
  };
}
