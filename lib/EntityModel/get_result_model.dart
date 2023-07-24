import 'dart:convert';
import '../Entity/Teacher/assessment_settings_model.dart';

class ResultsModelResponse{
  ResultsModelResponse({
    this.totalCount,
    this.data,
  });
  int? totalCount;
  List<GetResultModel>? data;

  factory ResultsModelResponse.fromJson(Map<String, dynamic> json) =>
      ResultsModelResponse(
        totalCount: json["total_count"],
        data: List<GetResultModel>.from(
            json["data"].map((x) => GetResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'ResultsModelResponse{totalCount: $totalCount, data: $data}';
  }
}



GetResultModel getResultModelFromJson(String str) =>
    GetResultModel.fromJson(json.decode(str));

String getResultModelToJson(GetResultModel data) => json.encode(data.toJson());

class GetResultModel {
  GetResultModel(
      {this.assessmentId,
        this.assessmentCode,
        this.assessmentType,
        this.totalScore,
        this.totalQuestions,
        this.assessmentStartDate,
        this.assessmentEndDate,
        this.assessmentDuration,
        this.subject,
        this.topic,
        this.semester,
        this.degree,
        this.totalAttempts,
        this.totalCompletedAttempts,
        this.totalInprogressAttempts,
        this.assessmentSettings,
        this.assessmentResults,
        this.assessmentStatus
      });

  dynamic assessmentId;
  String? assessmentCode;
  String? assessmentType;
  int? totalScore;
  int? totalQuestions;
  int? assessmentStartDate;
  int? assessmentEndDate;
  int? assessmentDuration;
  String? subject;
  String? topic;
  String? semester;
  String? degree;
  int? totalAttempts;
  int? totalInprogressAttempts;
  int? totalCompletedAttempts;
  AssessmentSettings? assessmentSettings;
  List<AssessmentResults>? assessmentResults;
  String? assessmentStatus;

  factory GetResultModel.fromJson(Map<String, dynamic> json) => GetResultModel(
    assessmentId: json["assessment_id"] ?? " ",
    assessmentType: json["assessment_type"] ?? " " ,
    assessmentCode: json["assessment_code"] ?? " ",
    totalScore: json["total_score"] ?? 0,
    totalQuestions: json["total_questions"] ?? " ",
    assessmentEndDate: json["assessment_enddate"] ?? " ",
    assessmentStartDate: json["assessment_startdate"] ?? " ",
    assessmentDuration: json["assessment_duration"] ?? " ",
    subject: json["subject"] ?? " ",
    topic: json["topic"] ?? " ",
    semester: json["sub_topic"] ?? " ",
    totalAttempts:json["total_attempts"] ?? 0,
    totalCompletedAttempts: json["total_completed_attempts"] ?? 0,
    totalInprogressAttempts: json["total_inprogress_attempts"] ?? 0,
    degree: json["class"] ?? " ",
    assessmentResults: json["assessment_results"] == null
        ? []
        : List<AssessmentResults>.from(json["assessment_results"]
        .map((x) => AssessmentResults.fromJson(x))),
    assessmentSettings: AssessmentSettings.fromJson(json["assessment_settings"]),
    assessmentStatus: json["assessment_status"] ?? " ",
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "assessment_type": assessmentType,
    "assessment_code": assessmentCode,
    "total_score": totalScore,
    "total_questions": totalQuestions,
    "assessment_duration": assessmentDuration,
    "assessment_enddate": assessmentEndDate,
    "assessment_startdate": assessmentStartDate,
    "subject": subject,
    "topic": topic,
    "sub_topic": semester,
    "class": degree,
    "total_attempts":totalAttempts,
    "total_completed_attempts":totalCompletedAttempts,
    "total_inprogress_attempts":totalInprogressAttempts,
    "assessment_settings":
    assessmentSettings == null ? '' : assessmentSettings!.toJson(),
    "assessment_results": assessmentResults,
    "assessment_status":assessmentStatus
  };

  @override
  String toString() {
    return 'GetResultModel{assessmentId: $assessmentId, assessmentResults: $assessmentResults, assessmentCode: $assessmentCode, assessmentType: $assessmentType, totalScore: $totalScore, totalQuestions: $totalQuestions, assessmentStartDate: $assessmentStartDate, assessmentEndDate: $assessmentEndDate, assessmentDuration: $assessmentDuration, subject: $subject, topic: $topic, subTopic: $semester, studentClass: $degree, totalAttempts: $totalAttempts, totalInprogressAttempts: $totalInprogressAttempts, totalCompletedAttempts: $totalCompletedAttempts,assessmentSettings: $assessmentSettings,assessment_status: $assessmentStatus}';
  }
}






class AssessmentResults {
  AssessmentResults(
      {
        this.attemptType,
        this.userId,
        this.firstName,
        this.lastName,
        this.rollNumber,
        this.organizationName,
        this.attemptId,
        this.attemptStartDate,
        this.attemptEndDate,
        this.attemptDuration,
        this.attemptScore,
        this.questions,
        this.attemptPercent});

  String? attemptType;
  int? userId;
  String? firstName;
  String? lastName;
  String? rollNumber;
  String? organizationName;
  int? attemptId;
  int? attemptStartDate;
  int? attemptEndDate;
  int? attemptDuration;
  int? attemptScore;
  int? attemptPercent;
  List<Questions>? questions;

  factory AssessmentResults.fromJson(Map<String, dynamic> json) =>
      AssessmentResults(
        userId: json["user_id"] ?? 0,
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        rollNumber: json["roll_number"] ?? "",
        organizationName: json["organisation_name"] ?? "",
        attemptId: json["attempt_id"] ?? 0,
        attemptStartDate: json["attempt_startdate"] ?? 0,
        attemptEndDate: json["attempt_enddate"] ?? 0,
        attemptDuration: json["attempt_duration"] ?? 0,
        attemptScore: json["attempt_score"] ?? 0,
        attemptPercent: json["attempt_percentage"],
        questions: json["questions"] == null
            ? [] :
        List<Questions>.from(
            json["questions"].map((x) => Questions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "roll_number": rollNumber,
    "organisation_name": organizationName,
    "attempt_id": attemptId,
    "attempt_startdate": attemptStartDate,
    "attempt_enddate": attemptEndDate,
    "attempt_duration": attemptDuration,
    "attempt_score": attemptScore,
    "attempt_percentage": attemptPercent,
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'AssessmentResults{userId: $userId, firstName: $firstName, lastName: $lastName, rollNumber: $rollNumber, organizationName: $organizationName, attemptId: $attemptId, attemptStartDate: $attemptStartDate, attemptEndDate: $attemptEndDate, attemptDuration: $attemptDuration,\n attemptScore: $attemptScore, attemptPercent: $attemptPercent,\n questions: $questions}\n';
  }
}

class Questions {
  Questions(
      {this.question,
        this.questionType,
        this.selectedChoices,
        this.descriptiveAnswers,
        this.marks,
        this.status});

  String? question;
  String? questionType;
  List<dynamic>? selectedChoices;
  String? descriptiveAnswers;
  String? status;
  int? marks;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
      question: json["question"] ?? "",
      questionType: json["question_type"] ?? "",
      selectedChoices: json["selected_choices"] ?? [" "],
      descriptiveAnswers: json["descriptive_answer"] ?? "",
      status: json["status"] ?? "",
      marks: json["marks"] ?? 0
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "question_type": questionType,
    "selected_choices": selectedChoices,
    "descriptive_answer": descriptiveAnswers,
    "status": status,
    "marks":marks
  };
}
