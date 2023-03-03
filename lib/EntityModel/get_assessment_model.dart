// To parse this JSON data, do
//
//     final getAssessmentModel = getAssessmentModelFromJson(jsonString);

import 'dart:convert';

GetAssessmentModel getAssessmentModelFromJson(String str) => GetAssessmentModel.fromJson(json.decode(str));

String getAssessmentModelToJson(GetAssessmentModel data) => json.encode(data.toJson());

class GetAssessmentModel {
  GetAssessmentModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Datum>? data;

  factory GetAssessmentModel.fromJson(Map<String, dynamic> json) => GetAssessmentModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.assessmentId,
    this.assessmentType,
    this.totalScore,
    this.assessmentDuration,
    this.subject,
    this.topic,
    this.subTopic,
    this.datumClass,
    this.assessmentScoreMessage,
    this.assessmentSettings,
    this.questions,
  });

  int? assessmentId;
  String? assessmentType;
  int? totalScore;
  int? assessmentDuration;
  String? subject;
  String? topic;
  String? subTopic;
  String? datumClass;
  dynamic assessmentScoreMessage;
  AssessmentSettings? assessmentSettings;
  List<Question>? questions;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    assessmentId: json["assessment_id"],
    assessmentType: json["assessment_type"],
    totalScore: json["total_score"],
    assessmentDuration: json["assessment_duration"],
    subject: json["subject"],
    topic: json["topic"],
    subTopic: json["sub_topic"],
    datumClass: json["class"],
    assessmentScoreMessage: json["assessment_score_message"],
    assessmentSettings: AssessmentSettings.fromJson(json["assessment_settings"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "assessment_type": assessmentType,
    "total_score": totalScore,
    "assessment_duration": assessmentDuration,
    "subject": subject,
    "topic": topic,
    "sub_topic": subTopic,
    "class": datumClass,
    "assessment_score_message": assessmentScoreMessage,
    "assessment_settings": assessmentSettings?.toJson(),
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class AssessmentSettings {
  AssessmentSettings({
    this.showSolvedAnswerSheetInAdvisor,
    this.showAdvisorName,
    this.showAdvisorEmail,
  });

  bool? showSolvedAnswerSheetInAdvisor;
  bool? showAdvisorName;
  bool? showAdvisorEmail;

  factory AssessmentSettings.fromJson(Map<String, dynamic> json) => AssessmentSettings(
    showSolvedAnswerSheetInAdvisor: json["show_solved_answer_sheet_in_advisor"],
    showAdvisorName: json["show_advisor_name"],
    showAdvisorEmail: json["show_advisor_email"],
  );

  Map<String, dynamic> toJson() => {
    "show_solved_answer_sheet_in_advisor": showSolvedAnswerSheetInAdvisor,
    "show_advisor_name": showAdvisorName,
    "show_advisor_email": showAdvisorEmail,
  };
}

class Question {
  Question({
    this.questionId,
    this.questionMarks,
    this.questionTypeId,
    this.questionType,
    this.question,
    this.advisorText,
    this.advisorUrl,
    this.choices,
    this.choicesAnswer,
  });

  int? questionId;
  int? questionMarks;
  int? questionTypeId;
  String? questionType;
  String? question;
  String? advisorText;
  String? advisorUrl;
  List<Choice>? choices;
  List<Choice>? choicesAnswer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"],
    questionMarks: json["question_marks"],
    questionTypeId: json["question_type_id"],
    questionType: json["question_type"],
    question: json["question"],
    advisorText: json["advisor_text"],
    advisorUrl: json["advisor_url"],
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    choicesAnswer: List<Choice>.from(json["choices_answer"].map((x) => Choice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "question_marks": questionMarks,
    "question_type_id": questionTypeId,
    "question_type": questionType,
    "question": question,
    "advisor_text": advisorText,
    "advisor_url": advisorUrl,
    "choices": List<dynamic>.from(choices!.map((x) => x.toJson())),
    "choices_answer": List<dynamic>.from(choicesAnswer!.map((x) => x.toJson())),
  };
}

class Choice {
  Choice({
    this.choiceId,
    this.choiceText,
  });

  int? choiceId;
  String? choiceText;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    choiceId: json["choice_id"],
    choiceText: json["choice_text"],
  );

  Map<String, dynamic> toJson() => {
    "choice_id": choiceId,
    "choice_text": choiceText,
  };
}
