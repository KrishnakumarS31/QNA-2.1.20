// To parse this JSON data, do
//
//     final demoSubmitAnswer = demoSubmitAnswerFromJson(jsonString);

import 'dart:convert';

DemoSubmitAnswer? demoSubmitAnswerFromJson(String str) => DemoSubmitAnswer.fromJson(json.decode(str));

String demoSubmitAnswerToJson(DemoSubmitAnswer? data) => json.encode(data!.toJson());

class DemoSubmitAnswer {
  DemoSubmitAnswer({
    this.userId,
    this.attemptId,
    this.assessmentCode,
    this.rollNumber,
    this.attemptStart,
    this.attemptEnd,
    this.attemptDuration,
    this.attemptScore,
    this.tupeOfStudent,
    this.assessmentResultHeader,
    this.assessmentResultDetail,
  });

  int? userId;
  int? attemptId;
  String? assessmentCode;
  String? rollNumber;
  int? attemptStart;
  int? attemptEnd;
  int? attemptDuration;
  int? attemptScore;
  String? tupeOfStudent;
  List<AssessmentResultHeader?>? assessmentResultHeader;
  List<AssessmentResultDetail?>? assessmentResultDetail;

  factory DemoSubmitAnswer.fromJson(Map<String, dynamic> json) => DemoSubmitAnswer(
    userId: json["user_id"],
    attemptId: json["attempt_id"],
    assessmentCode: json["assessment_code"],
    rollNumber: json["rollNumber"],
    attemptStart: json["attempt_start"],
    attemptEnd: json["attempt_end"],
    attemptDuration: json["attempt_duration"],
    attemptScore: json["attempt_score"],
    tupeOfStudent: json["tupe_of_student"],
    assessmentResultHeader: json["assessment_result_header"] == null ? [] : List<AssessmentResultHeader?>.from(json["assessment_result_header"]!.map((x) => AssessmentResultHeader.fromJson(x))),
    assessmentResultDetail: json["assessment_result_detail"] == null ? [] : List<AssessmentResultDetail?>.from(json["assessment_result_detail"]!.map((x) => AssessmentResultDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "attempt_id": attemptId,
    "assessment_code": assessmentCode,
    "rollNumber": rollNumber,
    "attempt_start": attemptStart,
    "attempt_end": attemptEnd,
    "attempt_duration": attemptDuration,
    "attempt_score": attemptScore,
    "tupe_of_student": tupeOfStudent,
    "assessment_result_header": assessmentResultHeader == null ? [] : List<dynamic>.from(assessmentResultHeader!.map((x) => x!.toJson())),
    "assessment_result_detail": assessmentResultDetail == null ? [] : List<dynamic>.from(assessmentResultDetail!.map((x) => x!.toJson())),
  };
}

class AssessmentResultDetail {
  AssessmentResultDetail({
    this.questionId,
    this.selectedQuestionChoiceId,
    this.descriptiveText,
  });

  int? questionId;
  List<int?>? selectedQuestionChoiceId;
  List<String?>? descriptiveText;

  factory AssessmentResultDetail.fromJson(Map<String, dynamic> json) => AssessmentResultDetail(
    questionId: json["question_id"],
    selectedQuestionChoiceId: json["selected_question_choice_id"] == null ? [] : List<int?>.from(json["selected_question_choice_id"]!.map((x) => x)),
    descriptiveText: json["descriptive_text"] == null ? [] : json["descriptive_text"] == null ? [] : List<String?>.from(json["descriptive_text"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "selected_question_choice_id": selectedQuestionChoiceId == null ? [] : List<dynamic>.from(selectedQuestionChoiceId!.map((x) => x)),
    "descriptive_text": descriptiveText == null ? [] : descriptiveText == null ? [] : List<dynamic>.from(descriptiveText!.map((x) => x)),
  };
}

class AssessmentResultHeader {
  AssessmentResultHeader({
    this.questionId,
    this.statusId,
    this.questionTypeId,
    this.marks,
  });

  int? questionId;
  int? statusId;
  QuestionTypeId? questionTypeId;
  int? marks;

  factory AssessmentResultHeader.fromJson(Map<String, dynamic> json) => AssessmentResultHeader(
    questionId: json["question_id"],
    statusId: json["status_id"],
    questionTypeId: questionTypeIdValues!.map[json["question_type_id"]],
    marks: json["marks"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "status_id": statusId,
    "question_type_id": questionTypeIdValues.reverse![questionTypeId],
    "marks": marks,
  };
}

enum QuestionTypeId { MCQ, SURVEY, DESCRIPTIVE }

final questionTypeIdValues = EnumValues({
  "descriptive": QuestionTypeId.DESCRIPTIVE,
  "mcq": QuestionTypeId.MCQ,
  "survey": QuestionTypeId.SURVEY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
