

import '../Teacher/choice_entity.dart';

class Question {
  Question({
    this.questionId,
    this.question,
    this.questionType,
    this.advisorText,
    this.advisorUrl,
    this.subject,
    this.topic,
    this.subTopic,
    this.datumClass,
    this.choices,
    this.questionMark
  });

  dynamic questionId;
  String? question;
  int? questionMark;
  String? questionType;
  String? advisorText;
  String? advisorUrl;
  String? subject;
  String? topic;
  String? subTopic;
  String? datumClass;
  List<Choice>? choices;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"],
    question: json["question"],
    questionType: json["question_type"],
    advisorText: json["advisor_text"],
    advisorUrl: json["advisor_url"],
    subject: json["subject"] ?? '',
    topic: json["topic"] ?? '',
    subTopic: json["sub_topic"] ?? '',
    datumClass: json["class"] ?? '',
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      questionMark: json["question_marks"] ?? 0,

  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "question": question,
    "question_type": questionType,
    "advisor_text": advisorText,
    "advisor_url": advisorUrl,
    "subject": subject ?? '',
    "topic": topic ?? '',
    "sub_topic": subTopic ?? '',
    "class": datumClass ?? '',
    "choices": choices==null?'':List<dynamic>.from(choices!.map((x) => x.toJson())),
    "question_marks": questionMark ?? 0
  };

  @override
  String toString() {
    return 'Question{questionId: $questionId,\n question: $question, questionType: $questionType, advisorText: $advisorText, advisorUrl: $advisorUrl, subject: $subject, topic: $topic, subTopic: $subTopic, datumClass: $datumClass,\n choices: $choices}';
  }
}