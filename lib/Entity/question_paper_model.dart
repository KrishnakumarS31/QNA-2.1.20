// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

QuestionPaperModel questionPaperModelFromJson(String str) => QuestionPaperModel.fromJson(json.decode(str));

String questionPaperModelToJson(QuestionPaperModel data) => json.encode(data.toJson());

class QuestionPaperModel {
  QuestionPaperModel({
    this.code,
    this.message,
    this.data,
  });


  int? code;
  String? message;
  Data? data;

  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) => QuestionPaperModel(
    code: json["code"],
    message: json["message"],
    data: json["data"]==null?Data():Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };

  @override
  String toString() {
    return 'QuestionPaperModel{code: $code, message: $message, data: $data}';
  }
}

class Data {
  Data({
    this.assessmentId,
    this.assessmentType,
    this.totalScore,
    this.assessmentDuration,
    this.subject,
    this.topic,
    this.subTopic,
    this.dataClass,
    this.assessmentScoreMessage,
    this.assessmentSettings,
    this.questions,
    this.accessTokenDetails,
  });

  int? assessmentId;
  String? assessmentType;
  int? totalScore;
  int? assessmentDuration;
  String? subject;
  String? topic;
  String? subTopic;
  String? dataClass;
  List<AssessmentScoreMessage>? assessmentScoreMessage;
  AssessmentSettings? assessmentSettings;
  List<Question>? questions;
  AccessTokenDetails? accessTokenDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    assessmentId: json["assessment_id"],
    assessmentType: json["assessment_type"],
    totalScore: json["total_score"],
    assessmentDuration: json["assessment_duration"],
    subject: json["subject"],
    topic: json["topic"],
    subTopic: json["sub_topic"],
    dataClass: json["class"],
    assessmentScoreMessage: List<AssessmentScoreMessage>.from(json["assessment_score_message"].map((x) => AssessmentScoreMessage.fromJson(x))),
    assessmentSettings: AssessmentSettings.fromJson(json["assessment_settings"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    accessTokenDetails: json["access_token_details"]==null?AccessTokenDetails():AccessTokenDetails.fromJson(json["access_token_details"]),
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "assessment_type": assessmentType,
    "total_score": totalScore,
    "assessment_duration": assessmentDuration,
    "subject": subject,
    "topic": topic,
    "sub_topic": subTopic,
    "class": dataClass,
    "assessment_score_message": List<dynamic>.from(assessmentScoreMessage!.map((x) => x.toJson())),
    "assessment_settings": assessmentSettings!.toJson(),
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
    "access_token_details": accessTokenDetails?.toJson(),
  };
}

class AccessTokenDetails {
  AccessTokenDetails({
    this.accessToken,
    this.userId,
  });

  String? accessToken;
  int? userId;

  factory AccessTokenDetails.fromJson(Map<String, dynamic> json) => AccessTokenDetails(
    accessToken: json["access_token"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "user_id": userId,
  };
}

class AssessmentScoreMessage {
  AssessmentScoreMessage({
    required this.assessmentScoreId,
    required this.assessmentScoreStatus,
    required this.assessmentPercent,
  });

  int assessmentScoreId;
  String assessmentScoreStatus;
  int assessmentPercent;

  factory AssessmentScoreMessage.fromJson(Map<String, dynamic> json) => AssessmentScoreMessage(
    assessmentScoreId: json["assessment_score_id"],
    assessmentScoreStatus: json["assessment_score_status"],
    assessmentPercent: json["assessment_percent"],
  );

  Map<String, dynamic> toJson() => {
    "assessment_score_id": assessmentScoreId,
    "assessment_score_status": assessmentScoreStatus,
    "assessment_percent": assessmentPercent,
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
  });

  int? questionId;
  int? questionMarks;
  int? questionTypeId;
  String? questionType;
  String? question;
  String? advisorText;
  String? advisorUrl;
  List<Choice>? choices;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"],
    questionMarks: json["question_marks"],
    questionTypeId: json["question_type_id"],
    questionType: json["question_type"],
    question: json["question"],
    advisorText: json["advisor_text"],
    advisorUrl: json["advisor_url"],
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
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
  };
}

class Choice {
  Choice({
    this.choiceId,
    this.choiceText,
    this.rightChoice,
  });

  int? choiceId;
  String? choiceText;
  bool? rightChoice;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    choiceId: json["choice_id"],
    choiceText: json["choice_text"],
    rightChoice: json["right_choice"],
  );

  Map<String, dynamic> toJson() => {
    "choice_id": choiceId,
    "choice_text": choiceText,
    "right_choice": rightChoice,
  };
}
