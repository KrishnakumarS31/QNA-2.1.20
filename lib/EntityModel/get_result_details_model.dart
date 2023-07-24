import 'dart:convert';

GetResultDetailsModel getResultModelFromJson(String str) =>
    GetResultDetailsModel.fromJson(json.decode(str));

String getResultModelToJson(GetResultDetailsModel data) => json.encode(data.toJson());


class GetResultDetailsModel {
  GetResultDetailsModel(
      {this.assessmentId,
        this.assessmentCode,
        this.assessmentType,
        this.instituteName,
        this.rollNumber,
        this.totalScore,
        this.subject,
        this.topic,
        this.semester,
        this.degree,
        this.assessmentResults,
        this.totalCount,

      });

  dynamic assessmentId;
  String? assessmentCode;
  String? assessmentType;
  String? instituteName;
  String? rollNumber;
  int? totalScore;
  String? subject;
  String? topic;
  String? semester;
  String? degree;
  List<AssessmentResultsDetails>? assessmentResults;
  int? totalCount;

  factory GetResultDetailsModel.fromJson(Map<String, dynamic> json) => GetResultDetailsModel(
    assessmentId: json["assessment_id"] ?? " ",
    assessmentType: json["assessment_type"] ?? " " ,
    assessmentCode: json["assessment_code"] ?? " ",
    instituteName: json["institution_name"] ?? "",
    rollNumber:json["roll_number"] ?? "",
    totalScore: json["total_score"] ?? 0,
    subject: json["subject"] ?? " ",
    topic: json["topic"] ?? " ",
    semester: json["sub_topic"] ?? " ",
    degree: json["class"] ?? " ",
    totalCount: json["total_count"],
    assessmentResults: json["assessment_results"] == null
        ? []
        : List<AssessmentResultsDetails>.from(json["assessment_results"]
        .map((x) => AssessmentResultsDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "assessment_type": assessmentType,
    "assessment_code": assessmentCode,
    "total_score": totalScore,
    "institution_name": instituteName,
    "roll_number": rollNumber,
    "subject": subject,
    "topic": topic,
    "sub_topic": semester,
    "class": degree,
    "total_count": totalCount,
    "assessment_results": assessmentResults,
  };

  @override
  String toString() {
    return 'GetResultDetailsModel {assessmentId: $assessmentId,\n assessmentCode: $assessmentCode,totalCount: $totalCount\n assessmentType: $assessmentType,\n totalScore: $totalScore,\n subject: $subject,\n topic: $topic,\n subTopic: $semester,\n studentClass: $degree, \n roll_number: $rollNumber,\n institution_name: $instituteName,\n assessmentResults: $assessmentResults}';
  }
}






class AssessmentResultsDetails {
  AssessmentResultsDetails(
      {
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
        this.questionsDetails,
        this.attemptPercent});

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
  List<QuestionsDetails>? questionsDetails;

  factory AssessmentResultsDetails.fromJson(Map<String, dynamic> json) =>
      AssessmentResultsDetails(
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
        questionsDetails: json["questions"] == null
            ? [] :
        List<QuestionsDetails>.from(
            json["questions"].map((x) => QuestionsDetails.fromJson(x))),
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
    //"questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'AssessmentResultsDetails{userId: $userId, firstName: $firstName, lastName: $lastName, rollNumber: $rollNumber, organizationName: $organizationName, attemptId: $attemptId, attemptStartDate: $attemptStartDate, attemptEndDate: $attemptEndDate, attemptDuration: $attemptDuration,\n attemptScore: $attemptScore, attemptPercent: $attemptPercent}\n';
  }
}

class QuestionsDetails {
  QuestionsDetails(
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

  factory QuestionsDetails.fromJson(Map<String, dynamic> json) => QuestionsDetails(
      question: json["question"] ?? "",
      questionType: json["question_type"] ?? "",
      selectedChoices: json["selected_choices"] ?? [],
      descriptiveAnswers: json["descriptive_answer"] ?? "",
      marks: json["marks"] ?? 0,
      status: json["status"] ?? ""
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

class QuestionsDetailsResponse{
  QuestionsDetailsResponse({
    this.data,
  });
  List<QuestionsDetails>? data;

  factory QuestionsDetailsResponse.fromJson(Map<String, dynamic> json) =>
      QuestionsDetailsResponse(
        data: List<QuestionsDetails>.from(
            json["data"].map((x) => QuestionsDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'ResultsModelResponse{ data: $data}';
  }
}

