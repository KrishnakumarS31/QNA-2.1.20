// To parse this JSON data, do
//
//     final getAssessmentModel = getAssessmentModelFromJson(jsonString);

import 'dart:convert';

import 'package:qna_test/Entity/Teacher/question_entity.dart';

import 'dart:convert';

GetAssessmentModel getAssessmentModelFromJson(String str) =>
    GetAssessmentModel.fromJson(json.decode(str));

String getAssessmentModelToJson(GetAssessmentModel data) =>
    json.encode(data.toJson());

class GetAssessmentModel {
  GetAssessmentModel({
    this.assessmentId,
    this.assessmentType,
    this.assessmentCode,
    this.totalScore,
    this.assessmentDuration,
    this.assessmentStatus,
    this.subject,
    this.topic,
    this.subTopic,
    this.getAssessmentModelClass,
    this.assessmentScoreMessage,
    this.assessmentSettings,
    this.questions,
  });

  int? assessmentId;
  String? assessmentType;
  String? assessmentCode;
  int? totalScore;
  int? assessmentDuration;
  String? assessmentStatus;
  String? subject;
  String? topic;
  String? subTopic;
  String? getAssessmentModelClass;
  dynamic assessmentScoreMessage;
  AssessmentSettings? assessmentSettings;
  List<Question>? questions;

  factory GetAssessmentModel.fromJson(Map<String, dynamic> json) =>
      GetAssessmentModel(
        assessmentId: json["assessment_id"],
        assessmentType: json["assessment_type"],
        assessmentCode: json["assessment_code"],
        totalScore: json["total_score"],
        assessmentDuration: json["assessment_duration"],
        assessmentStatus: json["assessment_status"],
        subject: json["subject"],
        topic: json["topic"],
        subTopic: json["sub_topic"],
        getAssessmentModelClass: json["class"],
        assessmentScoreMessage: json["assessment_score_message"],
        assessmentSettings:
            AssessmentSettings.fromJson(json["assessment_settings"]),
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assessment_id": assessmentId,
        "assessment_type": assessmentType,
        "assessment_code": assessmentCode,
        "total_score": totalScore,
        "assessment_duration": assessmentDuration,
        "assessment_status": assessmentStatus,
        "subject": subject,
        "topic": topic,
        "sub_topic": subTopic,
        "class": getAssessmentModelClass,
        "assessment_score_message": assessmentScoreMessage,
        "assessment_settings":
            assessmentSettings == null ? '' : assessmentSettings!.toJson(),
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'GetAssessmentModel{assessmentId: $assessmentId, assessmentType: $assessmentType, assessmentCode: $assessmentCode, totalScore: $totalScore, assessmentDuration: $assessmentDuration, assessmentStatus: $assessmentStatus, subject: $subject, topic: $topic, subTopic: $subTopic, getAssessmentModelClass: $getAssessmentModelClass, assessmentScoreMessage: $assessmentScoreMessage, assessmentSettings: $assessmentSettings, questions: $questions}';
  }
}

class AssessmentSettings {
  AssessmentSettings({
    this.showSolvedAnswerSheetInAdvisor,
    this.showAdvisorName,
    this.showAdvisorEmail,
    this.notAvailable
  });

  bool? showSolvedAnswerSheetInAdvisor;
  bool? showAdvisorName;
  bool? showAdvisorEmail;
  bool? notAvailable;

  factory AssessmentSettings.fromJson(Map<String, dynamic> json) =>
      AssessmentSettings(
        showSolvedAnswerSheetInAdvisor:
            json["show_solved_answer_sheet_in_advisor"],
        showAdvisorName: json["show_advisor_name"],
        showAdvisorEmail: json["show_advisor_email"],
        notAvailable: json["notAvailable"],

      );

  Map<String, dynamic> toJson() => {
        "show_solved_answer_sheet_in_advisor": showSolvedAnswerSheetInAdvisor,
        "show_advisor_name": showAdvisorName,
        "show_advisor_email": showAdvisorEmail,
        "notAvailable":notAvailable
      };
}
