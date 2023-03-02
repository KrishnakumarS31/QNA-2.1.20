// To parse this JSON data, do
//
//     final createAssessmentModel = createAssessmentModelFromJson(jsonString);

import 'dart:convert';

CreateAssessmentModel createAssessmentModelFromJson(String str) => CreateAssessmentModel.fromJson(json.decode(str));

String createAssessmentModelToJson(CreateAssessmentModel data) => json.encode(data.toJson());

class CreateAssessmentModel {
  CreateAssessmentModel({
    this.userId,
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
    this.createAssessmentModelClass,
    this.assessmentSettings,
    required this.questions,
  });

  int? userId;
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
  List<Question> questions;

  factory CreateAssessmentModel.fromJson(Map<String, dynamic> json) => CreateAssessmentModel(
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
    assessmentSettings: AssessmentSettings.fromJson(json["assessment_settings"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
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
    "assessment_settings": assessmentSettings?.toJson(),
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'CreateAssessmentModel{userId: $userId, assessmentType: $assessmentType, assessmentStatus: $assessmentStatus, totalScore: $totalScore, totalQuestions: $totalQuestions, assessmentStartdate: $assessmentStartdate, assessmentEnddate: $assessmentEnddate, assessmentDuration: $assessmentDuration, subject: $subject, topic: $topic, subTopic: $subTopic, createAssessmentModelClass: $createAssessmentModelClass, assessmentSettings: $assessmentSettings, questions: $questions}';
  }
}

class AssessmentSettings {
  AssessmentSettings({
    this.allowedNumberOfTestRetries,
    this.avalabilityForPractice,
    this.allowGuestStudent,
    this.showSolvedAnswerSheetInAdvisor,
    this.showAdvisorName,
    this.showAdvisorEmail,
    this.notAvailable,
  });

  int? allowedNumberOfTestRetries;
  bool? avalabilityForPractice;
  bool? allowGuestStudent;
  bool? showSolvedAnswerSheetInAdvisor;
  bool? showAdvisorName;
  bool? showAdvisorEmail;
  bool? notAvailable;

  factory AssessmentSettings.fromJson(Map<String, dynamic> json) => AssessmentSettings(
    allowedNumberOfTestRetries: json["allowed_number_of_test_retries"],
    avalabilityForPractice: json["avalability_for_practice"],
    allowGuestStudent: json["allow_guest_student"],
    showSolvedAnswerSheetInAdvisor: json["show_solved_answer_sheet_in_advisor"],
    showAdvisorName: json["show_advisor_name"],
    showAdvisorEmail: json["show_advisor_email"],
    notAvailable: json["not_available"],
  );

  Map<String, dynamic> toJson() => {
    "allowed_number_of_test_retries": allowedNumberOfTestRetries,
    "avalability_for_practice": avalabilityForPractice,
    "allow_guest_student": allowGuestStudent,
    "show_solved_answer_sheet_in_advisor": showSolvedAnswerSheetInAdvisor,
    "show_advisor_name": showAdvisorName,
    "show_advisor_email": showAdvisorEmail,
    "not_available": notAvailable,
  };
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
}
