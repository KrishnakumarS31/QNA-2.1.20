// To parse this JSON data, do
//
//     final questionPaperModel = questionPaperModelFromJson(jsonString);

import 'dart:convert';

QuestionPaperModel questionPaperModelFromJson(String str) =>
    QuestionPaperModel.fromJson(json.decode(str));

String questionPaperModelToJson(QuestionPaperModel data) =>
    json.encode(data.toJson());

class QuestionPaperModel {
  QuestionPaperModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) =>
      QuestionPaperModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

// class Data {
//   Data({
//      this.user_id,
//      this.assessment,
//   });
//   int? user_id;
//   Assessment? assessment;
//
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//
//     user_id: json["user_id"],
//         assessment: Assessment.fromJson(json["assessment"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "user_id": user_id,
//         "assessment": assessment!.toJson(),
//       };
// }

//old code
// class Data {
//   Data({
//     this.user_id,
//     this.assessment,
//   });
//   int? user_id;
//   Assessment? assessment;
//
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//
//     user_id: json["user_id"],
//     assessment: Assessment.fromJson(json["assessment"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user_id": user_id,
//     "assessment": assessment!.toJson(),
//   };
// }

//new Lines Added Remove If u want
class Data {
  Data(
      {required this.assessment_type_id,
      required this.assessment_duration,
      required this.subject,
      required this.grade,
      required this.topic,
      required this.assessment_score_message,
      required this.assessment_settings,
      required this.questions,
      required this.sub_topic});
  String assessment_type_id;
  dynamic assessment_duration;
  String subject;
  String topic;
  String sub_topic;
  String grade;
  List<AssessmentScoreMessage> assessment_score_message;
  List<AssessmentSettings> assessment_settings;
  List<Question> questions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        assessment_type_id: json["assessment_type_id"],
        assessment_duration: json["assessment_duration"],
        subject: json["subject"],
        topic: json["topic"],
        sub_topic: json["sub_topic"],
        grade: json["class"],
        assessment_score_message: List<AssessmentScoreMessage>.from(
            json["assessment_score_message"]
                .map((x) => AssessmentScoreMessage.fromJson(x))),
        assessment_settings: List<AssessmentSettings>.from(
            json["assessment_settings"]
                .map((x) => AssessmentSettings.fromJson(x))),
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assessment_type_id": assessment_type_id,
        "assessment_duration": assessment_duration,
        "subject": subject,
        "topic": topic,
        "sub_topic": sub_topic,
        "grade": grade,
        "assessment_settings":
            List<dynamic>.from(assessment_settings.map((x) => x.toJson())),
        "assessment_score_message":
            List<dynamic>.from(assessment_score_message.map((x) => x.toJson())),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

//new code

class AssessmentScoreMessage {
  AssessmentScoreMessage({
    required this.assessmentScoreId,
    required this.assessment_score_status,
    required this.assessment_percent,
  });
  int assessmentScoreId;
  String assessment_score_status;
  dynamic assessment_percent;

  factory AssessmentScoreMessage.fromJson(Map<String, dynamic> json) =>
      AssessmentScoreMessage(
        assessmentScoreId: json["assessment_score_id"],
        assessment_score_status: json["assessment_score_status"],
        assessment_percent: json["assessment_percent"],
      );

  Map<String, dynamic> toJson() => {
        "assessment_score_id": assessmentScoreId,
        "assessment_score_status": assessment_score_status,
        "assessment_percent": assessment_percent,
      };
}

class AssessmentSettings {
  AssessmentSettings({
    required this.show_solved_answer_sheet_in_advisor,
    required this.show_advisor_email,
    required this.show_advisor_name,
  });

  bool show_solved_answer_sheet_in_advisor;
  bool show_advisor_name;
  bool show_advisor_email;

  factory AssessmentSettings.fromJson(Map<String, dynamic> json) =>
      AssessmentSettings(
          show_solved_answer_sheet_in_advisor:
              json["show_solved_answer_sheet_in_advisor"],
          show_advisor_name: json["show_advisor_name"],
          show_advisor_email: json["show_advisor_email"]);

  Map<String, dynamic> toJson() => {
        "show_solved_answer_sheet_in_advisor":
            show_solved_answer_sheet_in_advisor,
        "show_advisor_name": show_advisor_name,
        "show_advisor_email": show_advisor_email
      };
}

class Assessment {
  Assessment({
    required this.assessmentCode,
    required this.assessmentType,
    required this.assessmentDuration,
    required this.subject,
    required this.topic,
    required this.subtopic,
    required this.studentClass,
    required this.questions,
  });

  String assessmentCode;
  String assessmentType;
  int assessmentDuration;
  String subject;
  String topic;
  String subtopic;
  String studentClass;
  List<Question> questions;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        assessmentCode: json["assessment_code"],
        assessmentType: json["assessment_type"],
        assessmentDuration: json["assessment_duration"],
        subject: json["subject"],
        topic: json["topic"],
        subtopic: json["sub_topic"],
        studentClass: json["class"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assessment_code": assessmentCode,
        "assessment_type": assessmentType,
        "assessment_duration": assessmentDuration,
        "subject": subject,
        "topic": topic,
        "sub_topic": subtopic,
        "class": studentClass,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.questionId,
    required this.questionMarks,
    required this.questionTypeId,
    required this.questionType,
    required this.question,
    required this.choices,
    required this.choices_answer,
    required this.advisorText,
    required this.advisorUrl,
  });

  int questionId;
  int questionMarks;
  String questionType;
  int questionTypeId;
  String question;
  List<Choice> choices;
  List<Choice> choices_answer;
  String advisorText;
  String advisorUrl;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["question_id"],
        questionMarks: json["question_marks"] ?? 0,
        questionTypeId: json["question_type_id"],
        questionType: json["question_type"],
        question: json["question"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        choices_answer: json["choices_answer"] == null
            ? []
            : List<Choice>.from(
                json["choices_answer"].map((x) => Choice.fromJson(x))),
        advisorText: json["advisor_text"] ?? '',
        advisorUrl: json["advisor_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question_marks": questionMarks,
        "question_type_id": questionTypeId,
        "question_type": questionType,
        "question": question,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "choices_answer": choices_answer == null
            ? null
            : List<dynamic>.from(choices_answer.map((x) => x)),
        "advisor_text": advisorText,
        "advisor_url": advisorUrl,
      };
}

class Choice {
  Choice({
    required this.choiceId,
    required this.choiceText,
  });

  int choiceId;
  String choiceText;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        choiceId: json["choice_id"],
        choiceText: json["choice_text"],
      );

  Map<String, dynamic> toJson() => {
        "choice_id": choiceId,
        "choice_text": choiceText,
      };
}

//new code
class ChoiceAnswer {
  ChoiceAnswer({
    required this.choiceId,
    required this.choiceText,
  });

  dynamic choiceId;
  String choiceText;

  factory ChoiceAnswer.fromJson(Map<String, dynamic> json) => ChoiceAnswer(
        choiceId: json["choice_id"],
        choiceText: json["choice_text"],
      );

  Map<String, dynamic> toJson() => {
        "choice_id": choiceId,
        "choice_text": choiceText,
      };
}

//
// {
// "status": 200,
// "message": "",
// "data": {
// "assessment": {
// "assessment_code": "98765432",
// "assessment_type": "test",
// "assessment_duration": 30,
// "subject": "Maths",
// "topic": "Calculus",
// "sub_topic": "Chapter 12.2",
// "class": "Class XII",
// "questions": [
// {
// "question_id": 1,
// "question_code": "AB123451",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "Suppose a firm is producing a level of output such that MR>MC. What should firm do to maximise its profits?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "30"
// },
// {
// "choice_id": 2,
// "choice_text": "10"
// },
// {
// "choice_id": 3,
// "choice_text": "20"
// },
// {
// "choice_id": 4,
// "choice_text": "40"
// }
// ],
// "choices_answer": [
// 2,
// 3
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 2,
// "question_code": "AB123452",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "10+20 = ?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "30"
// },
// {
// "choice_id": 2,
// "choice_text": "10"
// },
// {
// "choice_id": 3,
// "choice_text": "20"
// },
// {
// "choice_id": 4,
// "choice_text": "40"
// }
// ],
// "choices_answer": [
// 1
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 3,
// "question_code": "AB123453",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "100+200 = ?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "100"
// },
// {
// "choice_id": 2,
// "choice_text": "150"
// },
// {
// "choice_id": 3,
// "choice_text": "300"
// },
// {
// "choice_id": 4,
// "choice_text": "400"
// }
// ],
// "choices_answer": [
// 3
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 4,
// "question_code": "AB123454",
// "question_marks": 10,
// "question_type": "mcq",
// "question": " A firm encounter its “shutdown point” when:",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "ATC equals price at the profit-maximising level of output"
// },
// {
// "choice_id": 2,
// "choice_text": "AVC equals price at the profit-maximising level of output"
// },
// {
// "choice_id": 3,
// "choice_text": "AFC equals price at the profit-maximising level of output"
// },
// {
// "choice_id": 4,
// "choice_text": "MC equals price at the profit-maximising level of output"
// },
// {
// "choice_id": 5,
// "choice_text": "MC equals price at the profit-maximising level of input"
// }
// ],
// "choices_answer": [
// 3
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 5,
// "question_code": "AB123455",
// "question_marks": 10,
// "question_type": "mcq",
// "question": " 1+2+?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "1"
// },
// {
// "choice_id": 2,
// "choice_text": "2"
// },
// {
// "choice_id": 3,
// "choice_text": "3"
// },
// {
// "choice_id": 4,
// "choice_text": "4"
// },
// {
// "choice_id": 5,
// "choice_text": "5"
// }
// ],
// "choices_answer": [
// 3
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 6,
// "question_code": "AB123456",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "50-20=?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "45"
// },
// {
// "choice_id": 2,
// "choice_text": "40"
// },
// {
// "choice_id": 3,
// "choice_text": "35"
// },
// {
// "choice_id": 4,
// "choice_text": "30"
// },
// {
// "choice_id": 5,
// "choice_text": "25"
// }
// ],
// "choices_answer": [
// 4
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 7,
// "question_code": "AB123457",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "500+100=?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "550"
// },
// {
// "choice_id": 2,
// "choice_text": "600"
// },
// {
// "choice_id": 3,
// "choice_text": "650"
// },
// {
// "choice_id": 4,
// "choice_text": "700"
// },
// {
// "choice_id": 5,
// "choice_text": "750"
// }
// ],
// "choices_answer": [
// 2
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 8,
// "question_code": "AB123458",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "100+100+500=?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "200"
// },
// {
// "choice_id": 2,
// "choice_text": "400"
// },
// {
// "choice_id": 3,
// "choice_text": "700"
// },
// {
// "choice_id": 4,
// "choice_text": "900"
// },
// {
// "choice_id": 5,
// "choice_text": "1200"
// },
// {
// "choice_id": 6,
// "choice_text": "1500"
// }
// ],
// "choices_answer": [
// 3
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 9,
// "question_code": "AB123459",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "5400-200=?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "4200"
// },
// {
// "choice_id": 2,
// "choice_text": "4500"
// },
// {
// "choice_id": 3,
// "choice_text": "5300"
// },
// {
// "choice_id": 4,
// "choice_text": "5200"
// },
// {
// "choice_id": 5,
// "choice_text": "5400"
// }
// ],
// "choices_answer": [
// 4
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 10,
// "question_code": "AB1234510",
// "question_marks": 10,
// "question_type": "mcq",
// "question": "10+10+10+20=?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "10"
// },
// {
// "choice_id": 2,
// "choice_text": "20"
// },
// {
// "choice_id": 3,
// "choice_text": "30"
// },
// {
// "choice_id": 4,
// "choice_text": "40"
// },
// {
// "choice_id": 5,
// "choice_text": "50"
// }
// ],
// "choices_answer": [
// 5
// ],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 11,
// "question_code": "AB1234511",
// "question_type": "survey",
// "question": "Which activities in the classroom do you enjoy the most?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "Fast Facts"
// },
// {
// "choice_id": 2,
// "choice_text": "Memory"
// },
// {
// "choice_id": 3,
// "choice_text": "Treasure Hunt"
// }
// ],
// "choices_answer": []
// },
// {
// "question_id": 12,
// "question_code": "AB1234512",
// "question_type": "survey",
// "question": "Given a chance, what is one change that you would like to see?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "Teaching method"
// },
// {
// "choice_id": 2,
// "choice_text": "Time taken to complete a chapter"
// },
// {
// "choice_id": 3,
// "choice_text": "Extracurricular activities"
// },
// {
// "choice_id": 4,
// "choice_text": "give time to study"
// }
// ],
// "choices_answer": []
// },
// {
// "question_id": 13,
// "question_code": "AB1234513",
// "question_type": "survey",
// "question": "Do you have supportive classmates?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "Yes, extremely supportive"
// },
// {
// "choice_id": 2,
// "choice_text": "No, extremely unsupportive"
// },
// {
// "choice_id": 3,
// "choice_text": "They are neither supportive nor unsupportive"
// }
// ],
// "choices_answer": []
// },
// {
// "question_id": 14,
// "question_code": "AB1234514",
// "question_type": "survey",
// "question": "What motivates you to learn more?",
// "choices": [
// {
// "choice_id": 1,
// "choice_text": "Asking a lot of questions to the teacher"
// },
// {
// "choice_id": 2,
// "choice_text": "Completing various assignments"
// },
// {
// "choice_id": 3,
// "choice_text": "Sports and other extracurricular activities"
// }
// ],
// "choices_answer": []
// },
// {
// "question_id": 15,
// "question_code": "AB1234515",
// "question_marks": 0,
// "question_type": "descriptive",
// "question": "What motivates you to learn more?",
// "choices": [],
// "choices_answer": [],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 16,
// "question_code": "AB1234516",
// "question_marks": 0,
// "question_type": "descriptive",
// "question": "Do you have supportive classmates?",
// "choices": [],
// "choices_answer": [],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 17,
// "question_code": "AB1234517",
// "question_marks": 0,
// "question_type": "descriptive",
// "question": "What personality traits do teachers need to have?",
// "choices": [],
// "choices_answer": [],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 18,
// "question_code": "AB1234518",
// "question_marks": 0,
// "question_type": "descriptive",
// "question": "How will you prepare your classroom for your first day?",
// "choices": [],
// "choices_answer": [],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 19,
// "question_code": "AB1234519",
// "question_marks": 0,
// "question_type": "descriptive",
// "question": "How do you prepare your lesson plan and what do you include?",
// "choices": [],
// "choices_answer": [],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// },
// {
// "question_id": 20,
// "question_code": "AB1234520",
// "question_marks": 0,
// "question_type": "descriptive",
// "question": "How will you integrate the use of technology in your classroom?",
// "choices": [],
// "choices_answer": [],
// "advisor_text": "Read section 5.5  …. And then ……",
// "advisor_url": "https://www.w3schools.com/"
// }
// ]
// }
// }
// }
