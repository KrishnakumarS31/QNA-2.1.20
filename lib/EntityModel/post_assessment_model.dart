// To parse this JSON data, do
//
//     final postAssessmentModel = postAssessmentModelFromJson(jsonString);

import 'dart:convert';

PostAssessmentModel postAssessmentModelFromJson(String str) => PostAssessmentModel.fromJson(json.decode(str));

String postAssessmentModelToJson(PostAssessmentModel data) => json.encode(data.toJson());

class PostAssessmentModel {
  PostAssessmentModel({
     this.assessmentId,
     this.assessmentCode,
     this.userId,
     this.statusId,
     this.attemptStartdate,
     this.attemptEnddate,
     this.attemptDuration,
     this.attemptScore,
     this.assessmentScoreId,
     required this.assessmentResults,
  });

  int? assessmentId;
  String? assessmentCode;
  int? userId;
  int? statusId;
  int? attemptStartdate;
  int? attemptEnddate;
  int? attemptDuration;
  int? attemptScore;
  int? assessmentScoreId;
  List<AssessmentResult> assessmentResults;

  factory PostAssessmentModel.fromJson(Map<String, dynamic> json) => PostAssessmentModel(
    assessmentId: json["assessment_id"],
    assessmentCode: json["assessment_code"],
    userId: json["user_id"],
    statusId: json["status_id"],
    attemptStartdate: json["attempt_startdate"],
    attemptEnddate: json["attempt_enddate"],
    attemptDuration: json["attempt_duration"],
    attemptScore: json["attempt_score"],
    assessmentScoreId: json["assessment_score_id"],
    assessmentResults: List<AssessmentResult>.from(json["assessment_results"].map((x) => AssessmentResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "assessment_code": assessmentCode,
    "user_id": userId,
    "status_id": statusId,
    "attempt_startdate": attemptStartdate,
    "attempt_enddate": attemptEnddate,
    "attempt_duration": attemptDuration,
    "attempt_score": attemptScore,
    "assessment_score_id": assessmentScoreId,
    "assessment_results": List<dynamic>.from(assessmentResults.map((x) => x.toJson())),
  };
}

class AssessmentResult {
  AssessmentResult({
     this.questionId,
     this.statusId,
     this.questionTypeId,
     this.marks,
     this.selectedQuestionChoice,
     this.descriptiveText,
  });

  int? questionId;
  int? statusId;
  int? questionTypeId;
  int? marks;
  List<int>? selectedQuestionChoice;
  String? descriptiveText;

  factory AssessmentResult.fromJson(Map<String, dynamic> json) => AssessmentResult(
    questionId: json["question_id"],
    statusId: json["status_id"],
    questionTypeId: json["question_type_id"],
    marks: json["marks"],
    selectedQuestionChoice: List<int>.from(json["selected_question_choice"].map((x) => x)),
    descriptiveText: json["descriptive_text"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "status_id": statusId,
    "question_type_id": questionTypeId,
    "marks": marks,
    "selected_question_choice": selectedQuestionChoice==null?[]:List<dynamic>.from(selectedQuestionChoice!.map((x) => x)),
    "descriptive_text": descriptiveText,
  };
}
