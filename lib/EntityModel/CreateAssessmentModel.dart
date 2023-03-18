// To parse this JSON data, do
//
//     final createAssessmentModel = createAssessmentModelFromJson(jsonString);

import 'dart:convert';
import '../Entity/Teacher/question_entity.dart' as Questions;

CreateAssessmentModel createAssessmentModelFromJson(String str) => CreateAssessmentModel.fromJson(json.decode(str));

String createAssessmentModelToJson(CreateAssessmentModel data) => json.encode(data.toJson());

class CreateAssessmentModel {
  CreateAssessmentModel({
    this.assessmentId,
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
    this.removeQuestions,
    this.addQuestion
  });

  int? assessmentId;
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
  List<Question>? questions;
  List<Questions.Question>? addQuestion;
  List<int>? removeQuestions=[];

  factory CreateAssessmentModel.fromJson(Map<String, dynamic> json) => CreateAssessmentModel(
    assessmentId: json["assessment_id"] ?? 0,
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
    removeQuestions: List<int>.from(json["remove_questions"].map((x) => x)),
    addQuestion: List<Questions.Question>.from(json["add_questions"].map((x) => Questions.Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId ?? 0,
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
    "remove_questions": (removeQuestions==null)|(removeQuestions==[])?null:List<dynamic>.from(removeQuestions!.map((x) => x)),
    "add_questions": addQuestion==null?null:List<dynamic>.from(addQuestion!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'CreateAssessmentModel{assessmentId: $assessmentId,\n userId: $userId,\n assessmentType: $assessmentType,\n assessmentStatus: $assessmentStatus,\n totalScore: $totalScore,\n totalQuestions: $totalQuestions,\n assessmentStartdate: $assessmentStartdate,\n assessmentEnddate: $assessmentEnddate,\n assessmentDuration: $assessmentDuration,\n subject: $subject,\n topic: $topic,\n subTopic: $subTopic,\n createAssessmentModelClass: $createAssessmentModelClass,\n assessmentSettings: $assessmentSettings,\n questions: $questions,\n addQuestion: $addQuestion,\n removeQuestions: $removeQuestions}';
  }
}

class AssessmentSettings {
  AssessmentSettings({
    this.allowedNumberOfTestRetries,
    this.avalabilityForPractice,
    this.allowGuestStudent,
    this.showSolvedAnswerSheetInAdvisor,
    this.showSolvedAnswerSheetDuringPractice,
    this.showAdvisorName,
    this.showAdvisorEmail,
    this.notAvailable,
  });

  int? allowedNumberOfTestRetries;
  bool? avalabilityForPractice;
  bool? allowGuestStudent;
  bool? showSolvedAnswerSheetInAdvisor;
  bool? showSolvedAnswerSheetDuringPractice;
  bool? showAdvisorName;
  bool? showAdvisorEmail;
  bool? notAvailable;

  factory AssessmentSettings.fromJson(Map<String, dynamic> json) => AssessmentSettings(
    allowedNumberOfTestRetries: json["allowed_number_of_test_retries"],
    avalabilityForPractice: json["avalability_for_practice"],
    allowGuestStudent: json["allow_guest_student"],
    showSolvedAnswerSheetInAdvisor: json["show_solved_answer_sheet_in_advisor"],
    showSolvedAnswerSheetDuringPractice: json[""],
    showAdvisorName: json["show_advisor_name"],
    showAdvisorEmail: json["show_advisor_email"],
    notAvailable: json["not_available"],
  );

  Map<String, dynamic> toJson() => {
    "allowed_number_of_test_retries": allowedNumberOfTestRetries,
    "avalability_for_practice": avalabilityForPractice,
    "allow_guest_student": allowGuestStudent,
    "show_solved_answer_sheet_in_advisor": showSolvedAnswerSheetInAdvisor,
    "":showSolvedAnswerSheetDuringPractice,
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

  @override
  String toString() {
    return 'Question{questionId: $questionId, questionMarks: $questionMarks}';
  }
}
