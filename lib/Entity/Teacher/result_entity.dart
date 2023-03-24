class Result {
  Result(
      {this.assessmentId,
      this.assessmentType,
      this.totalScore,
      this.assessmentDuration,
      this.subject,
      this.topic,
      this.subTopic,
      this.studentClass,
      this.assessmentScoreMessage,
      this.assessmentSettings,
      this.questions});

  dynamic assessmentId;
  String? assessmentType;
  int? totalScore;
  int? assessmentDuration;
  String? subject;
  String? topic;
  String? subTopic;
  String? studentClass;
  String? assessmentScoreMessage;
  AssessmentSettings? assessmentSettings;
  List<Questions>? questions;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        assessmentId: json["assessment_id"],
        assessmentType: json["assessment_type"],
        totalScore: json["total_score"] ?? 0,
        assessmentDuration: json["assessment_duration"] ?? 0,
        subject: json["subject"] ?? '',
        topic: json["topic"] ?? '',
        subTopic: json["sub_topic"] ?? '',
        studentClass: json["class"] ?? '',
        assessmentScoreMessage: json["assessment_score_message"] ?? '',
        assessmentSettings: json["assessment_settings"] ?? '',
        questions: List<Questions>.from(
            json["questions"].map((x) => Questions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "question_id": assessmentId,
        "assessment_type": assessmentType,
        "total_score": totalScore ?? 0,
        "assessment_duration": assessmentDuration ?? 0,
        "subject": subject ?? '',
        "topic": topic ?? '',
        "sub_topic": subTopic ?? '',
        "class": studentClass ?? '',
        "assessment_score_message": assessmentScoreMessage,
        "questions": questions == null
            ? ''
            : List<dynamic>.from(questions!.map((x) => x.toJson()))
      };

  @override
  String toString() {
    return 'Result{assessment_id: $assessmentId, assessment_type: $assessmentType, total_score: $totalScore,assessment_duration: $assessmentDuration, assessment_score_message: $assessmentScoreMessage, questions: $questions, subject: $subject, topic: $topic, subTopic: $subTopic, class: $studentClass}';
  }
}

class Questions {
  Questions(
      {this.questionId,
      this.questionMarks,
      this.questionTypeId,
      this.questionType,
      this.question,
      this.advisorText,
      this.advisorUrl,
      this.choices});

  dynamic questionId;
  int? questionMarks;
  int? questionTypeId;
  String? questionType;
  String? question;
  String? advisorText;
  String? advisorUrl;
  List<Choice>? choices;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        questionId: json["question_id"],
        questionMarks: json["question_marks"],
        questionTypeId: json["question_type_id"],
        questionType: json["question_type"],
        question: json["questions"],
        advisorText: json["advisor_text"],
        advisorUrl: json["advisor_url"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question_marks": questionMarks,
        "question_type_id": questionTypeId,
        "question_type": questionType,
        "questions": question,
        "advisor_text": advisorText,
        "advisor_url": advisorUrl,
        "choices": choices == null
            ? ''
            : List<dynamic>.from(choices!.map((x) => x.toJson())),
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

  factory AssessmentSettings.fromJson(Map<String, dynamic> json) =>
      AssessmentSettings(
        showSolvedAnswerSheetInAdvisor:
            json["show_solved_answer_sheet_in_advisor"],
        showAdvisorName: json["show_advisor_name"],
        showAdvisorEmail: json["show_advisor_email"],
      );

  Map<String, dynamic> toJson() => {
        "show_solved_answer_sheet_in_advisor": showSolvedAnswerSheetInAdvisor,
        "show_advisor_name": showAdvisorName,
        "show_advisor_email": showAdvisorEmail,
      };
}

class Choice {
  Choice({
    this.choiceId,
    this.choiceText,
    this.rightChoice,
  });

  dynamic choiceId;
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
