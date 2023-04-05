import 'dart:convert';

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
      this.subTopic,
      this.studentClass,
      this.attemptPercentage,
      this.assessmentResults,
      this.androidUrl,
      this.url,
      this.iosUrl,
      required this.guestStudentAllowed});

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
  String? subTopic;
  String? studentClass;
  int? attemptPercentage;
  String? url;
  String? androidUrl;
  String? iosUrl;
  bool guestStudentAllowed;
  List<AssessmentResults>? assessmentResults;

  factory GetResultModel.fromJson(Map<String, dynamic> json) => GetResultModel(
        assessmentId: json["assessment_id"] ?? " ",
        assessmentType: json["assessment_type"] ?? " " ,
        assessmentCode: json["assessment_code"] ?? " ",
        totalScore: json["total_score"] ?? " ",
        totalQuestions: json["total_questions"] ?? " ",
        assessmentEndDate: json["assessment_enddate"] ?? " ",
        assessmentStartDate: json["assessment_startdate"] ?? " ",
        assessmentDuration: json["assessment_duration"] ?? " ",
        subject: json["subject"] ?? " ",
        topic: json["topic"] ?? " ",
        subTopic: json["sub_topic"] ?? " ",
        // url: json["url"] ?? " ",
        // androidUrl: json["android_app"] ?? " ",
        // iosUrl: json["ios_app"] ?? " ",
        studentClass: json["class"] ?? " ",
        attemptPercentage: json["attempt_percentage"] ,
        assessmentResults: json["assessment_results"] == null
            ? []
            : List<AssessmentResults>.from(json["assessment_results"]
                .map((x) => AssessmentResults.fromJson(x))),
        guestStudentAllowed: json["guest_student_allowed"] ?? " ",
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
        "sub_topic": subTopic,
        "class": studentClass,
        "attempt_percentage":attemptPercentage,
        "url": url,
        "android_app": androidUrl,
        "ios_app": iosUrl,
        "assessment_results": assessmentResults,
        "guest_student_allowed": guestStudentAllowed
      };
}

class AssessmentResults {
  AssessmentResults(
      {this.userId,
      this.firstName,
      this.lastName,
      this.rollNumber,
      this.organizationName,
      this.attemptId,
      this.attemptStartDate,
      this.attemptEndDate,
      this.attemptDuration,
      this.attemptScore,
      this.questions, this.attemptPercent});

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

  //factory GetResultModel.fromJson(Map<String, dynamic> json) => GetResultModel(
  factory AssessmentResults.fromJson(Map<String, dynamic> json) =>
      AssessmentResults(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        rollNumber: json["roll_number"],
        organizationName: json["organisation_name"],
        attemptId: json["attempt_id"],
        attemptStartDate: json["attempt_startdate"] ?? 0,
        attemptEndDate: json["attempt_enddate"] ?? 0,
        attemptDuration: json["attempt_duration"] ?? 0,
        attemptScore: json["attempt_score"] ?? 0,
        attemptPercent: json["attempt_percentage"],
        questions: List<Questions>.from(
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
}

class Questions {
  Questions(
      {this.question,
      this.questionType,
      this.selectedChoices,
      this.descriptiveAnswers,
      this.status});

  String? question;
  String? questionType;
  List<dynamic>? selectedChoices;
  String? descriptiveAnswers;
  String? status;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        question: json["question"],
        questionType: json["question_type"],
        selectedChoices: json["selected_choices"],
        descriptiveAnswers: json["descriptive_answer"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "question_type": questionType,
        "selected_choices": selectedChoices,
        "descriptive_answer": descriptiveAnswers,
        "status": status
      };
}
