import '../Teacher/choice_entity.dart';


class QuestionResponse {
  QuestionResponse(
      {this.questions,this.total_count});
  List<Question>? questions;
  int? total_count;

  factory QuestionResponse.fromJson(Map<String, dynamic> json) => QuestionResponse(
    questions: json["questions"] == null
        ? []
        : List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    total_count: json["total_count"] ?? 0,

  );

  Map<String, dynamic> toJson() => {
    "questions": questions == null
        ? ''
        : List<dynamic>.from(questions!.map((x) => x.toJson())),
    "total_count": total_count ?? 0
  };

  @override
  String toString() {
    return 'Question{questions: $questions,\n total_count: $total_count,}';
  }
}

class Question {
  Question(
      {this.questionId,
        this.question,
        this.questionType,
        this.advisorText,
        this.advisorUrl,
        this.subject,
        this.topic,
        this.semester,
        this.degreeStudent,
        this.choices,
        this.questionMark});

  dynamic questionId;
  String? question;
  int? questionMark;
  String? questionType;
  String? advisorText;
  String? advisorUrl;
  String? subject;
  String? topic;
  String? semester;
  String? degreeStudent;
  List<Choice>? choices;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"],
    question: json["question"],
    questionType: json["question_type"],
    advisorText: json["advisor_text"],
    advisorUrl: json["advisor_url"],
    subject: json["subject"] ?? '',
    topic: json["topic"] ?? '',
    semester: json["sub_topic"] ?? '',
    degreeStudent: json["class"] ?? '',
    choices: json["choices"] == null
        ? []
        : List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
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
    "sub_topic": semester ?? '',
    "class": degreeStudent ?? '',
    "choices": choices == null
        ? ''
        : List<dynamic>.from(choices!.map((x) => x.toJson())),
    "question_marks": questionMark ?? 0
  };

  @override
  String toString() {
    return 'Question{questionId: $questionId,\n question: $question, questionType: $questionType, advisorText: $advisorText, advisorUrl: $advisorUrl, subject: $subject, topic: $topic, subTopic: $semester, datumClass: $degreeStudent,\n choices: $choices}';
  }
}
