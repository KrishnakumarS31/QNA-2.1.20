import 'choice_model.dart';

class Question {
  Question({
    required this.questionId,
    required this.questionMarks,
    required this.questionType,
    required this.question,
    required this.choices,
    required this.rightChoice,
    required this.advisorText,
    required this.advisorUrl,
  });

  String questionId;
  int questionMarks;
  String questionType;
  String question;
  List<Choice> choices;
  List<int> rightChoice;
  String advisorText;
  String advisorUrl;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["question_id"],
    questionMarks: json["question_marks"] == null ? null : json["question_marks"],
    questionType: json["question_type"],
    question: json["question"],
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    rightChoice: json["right_choice"] == null ? [] : List<int>.from(json["right_choice"].map((x) => x)),
    advisorText: json["advisor_text"] == null ? null : json["advisor_text"],
    advisorUrl: json["advisor_url"] == null ? null : json["advisor_url"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "question_marks": questionMarks == null ? null : questionMarks,
    "question_type": questionType,
    "question": question,
    "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
    "right_choice": rightChoice == null ? null : List<dynamic>.from(rightChoice.map((x) => x)),
    "advisor_text": advisorText == null ? null : advisorText,
    "advisor_url": advisorUrl == null ? null : advisorUrl,
  };
}