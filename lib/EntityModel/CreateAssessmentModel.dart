// To parse this JSON data, do
//
//     final createAssessmentModel = createAssessmentModelFromJson(jsonString);

import 'dart:convert';
import '../Entity/Teacher/assessment_settings_model.dart';
import '../Entity/Teacher/question_entity.dart' as Questions;

CreateAssessmentModel createAssessmentModelFromJson(String str) =>
    CreateAssessmentModel.fromJson(json.decode(str));

String createAssessmentModelToJson(CreateAssessmentModel data) =>
    json.encode(data.toJson());

class CreateAssessmentModel {
  CreateAssessmentModel(
      {this.assessmentId,
      this.userId,
        this.assessmentCode,
      this.assessmentType,
      this.assessmentStatus,
      this.totalScore,
      this.totalQuestions,
      this.assessmentStartdate,
      this.assessmentEnddate,
      this.assessmentDuration,
      this.subject,
      this.topic,
      this.subTopic,
        this.institutionId,
      this.createAssessmentModelClass,
      this.assessmentSettings,
      required this.questions,
      this.removeQuestions,
      this.addQuestion});

  int? assessmentId;
  int? userId;
  String? assessmentCode;
  String? assessmentType;
  String? assessmentStatus;
  int? totalScore;
  int? totalQuestions;
  int? assessmentStartdate;
  int? assessmentEnddate;
  int? assessmentDuration;
  String? subject;
  String? topic;
  String? subTopic;
  String? createAssessmentModelClass;
  AssessmentSettings? assessmentSettings;
  List<Question>? questions;
  List<Questions.Question>? addQuestion;
  List<int>? removeQuestions = [];
  int? institutionId;

  factory CreateAssessmentModel.fromJson(Map<String, dynamic> json) =>
      CreateAssessmentModel(
        assessmentId: json["assessment_id"] ?? 0,
        assessmentCode: json["assessment_code"] ?? '',
        userId: json["user_id"],
        assessmentType: json["assessment_type"],
        assessmentStatus: json["assessment_status"],
        totalScore: json["total_score"],
        totalQuestions: json["total_questions"],
        assessmentStartdate: json["assessment_startdate"],
        assessmentEnddate: json["assessment_enddate"],
        assessmentDuration: json["assessment_duration"],
        subject: json["subject"],
        topic: json["topic"],
        subTopic: json["sub_topic"],
        createAssessmentModelClass: json["class"],
        institutionId: json["institution_id"] ?? 0,
        assessmentSettings:
            AssessmentSettings.fromJson(json["assessment_settings"]),
        questions: json["questions"]==null?null:List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        removeQuestions: List<int>.from(json["remove_questions"].map((x) => x)),
        addQuestion: List<Questions.Question>.from(
            json["add_questions"].map((x) => Questions.Question.fromJson(x))),

      );

  Map<String, dynamic> toJson() => {
        "assessment_id": assessmentId ?? 0,
    "assessment_code": assessmentCode ?? '',
        "user_id": userId,
        "assessment_type": assessmentType,
        "assessment_status": assessmentStatus,
        "total_score": totalScore,
        "total_questions": totalQuestions,
        "assessment_startdate": assessmentStartdate,
        "assessment_enddate": assessmentEnddate,
        "assessment_duration": assessmentDuration,
        "subject": subject,
        "topic": topic,
        "sub_topic": subTopic,
        "class": createAssessmentModelClass,
        "institution_id":institutionId,
        "assessment_settings": assessmentSettings?.toJson(),
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
        "remove_questions": (removeQuestions == null) | (removeQuestions == [])
            ? null
            : List<dynamic>.from(removeQuestions!.map((x) => x)),
        "add_questions": addQuestion == null
            ? null
            : List<dynamic>.from(addQuestion!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'CreateAssessmentModel{assessmentId: $assessmentId, userId: $userId, assessmentType: $assessmentType, assessmentStatus: $assessmentStatus, totalScore: $totalScore, totalQuestions: $totalQuestions, assessmentStartdate: $assessmentStartdate, assessmentEnddate: $assessmentEnddate,\n assessmentDuration: $assessmentDuration, subject: $subject, topic: $topic, subTopic: $subTopic, createAssessmentModelClass: $createAssessmentModelClass,\n assessmentSettings: $assessmentSettings,\n questions: $questions,\n addQuestion: $addQuestion, removeQuestions: $removeQuestions, institutionId: $institutionId}';
  }
}



class Question {
  Question({
    this.questionId,
    this.questionMarks,
  });

  int? questionId;
  int? questionMarks;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["question_id"],
        questionMarks: json["question_marks"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question_marks": questionMarks,
      };

  @override
  String toString() {
    return 'Question{questionId: $questionId, questionMarks: $questionMarks}';
  }
}
