import 'package:qna_test/Entity/Teacher/question_entity.dart';

class Assessment {
  Assessment({
    required this.assessmentCode,
    required this.assessmentType,
    required this.assessmentDuration,
    required this.questions,
  });

  String assessmentCode;
  String assessmentType;
  int assessmentDuration;
  List<Question> questions;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        assessmentCode: json["assessment_code"],
        assessmentType: json["assessment_type"],
        assessmentDuration: json["assessment_duration"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assessment_code": assessmentCode,
        "assessment_type": assessmentType,
        "assessment_duration": assessmentDuration,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
