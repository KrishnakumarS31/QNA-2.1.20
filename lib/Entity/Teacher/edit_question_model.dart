// To parse this JSON data, do
//
//     final editQuestionModel = editQuestionModelFromJson(jsonString);

import 'dart:convert';

EditQuestionModel editQuestionModelFromJson(String str) =>
    EditQuestionModel.fromJson(json.decode(str));

String editQuestionModelToJson(EditQuestionModel data) =>
    json.encode(data.toJson());

class EditQuestionModel {
  EditQuestionModel({
    this.questionType,
    this.question,
    this.subject,
    this.topic,
    this.subTopic,
    this.editQuestionModelClass,
    this.advisorText,
    this.advisorUrl,
    this.editChoices,
    this.addChoices,
    this.removeChoices,
  });

  String? question;
  String? questionType;
  String? subject;
  String? topic;
  String? subTopic;
  String? editQuestionModelClass;
  String? advisorText;
  String? advisorUrl;
  List<EditChoice>? editChoices;
  List<AddChoice>? addChoices;
  List<int>? removeChoices;

  factory EditQuestionModel.fromJson(Map<String, dynamic> json) =>
      EditQuestionModel(
        question: json["question"],
        questionType: json["question_type"],
        subject: json["subject"],
        topic: json["topic"],
        subTopic: json["sub_topic"],
        editQuestionModelClass: json["class"],
        advisorText: json["advisor_text"],
        advisorUrl: json["advisor_url"],
        editChoices: List<EditChoice>.from(
            json["edit_choices"].map((x) => EditChoice.fromJson(x))),
        addChoices: List<AddChoice>.from(
            json["add_choices"].map((x) => AddChoice.fromJson(x))),
        removeChoices: List<int>.from(json["remove_choices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "question_type": questionType,
        "subject": subject,
        "topic": topic,
        "sub_topic": subTopic,
        "class": editQuestionModelClass,
        "advisor_text": advisorText,
        "advisor_url": advisorUrl,
        "edit_choices": editChoices == null
            ? []
            : List<dynamic>.from(editChoices!.map((x) => x.toJson())),
        "add_choices": addChoices == null
            ? []
            : List<dynamic>.from(addChoices!.map((x) => x.toJson())),
        "remove_choices": removeChoices == null
            ? []
            : List<dynamic>.from(removeChoices!.map((x) => x)),
      };

  @override
  String toString() {
    return 'EditQuestionModel{question: $question, subject: $subject, topic: $topic, subTopic: $subTopic, editQuestionModelClass: $editQuestionModelClass, advisorText: $advisorText, advisorUrl: $advisorUrl, editChoices: $editChoices, addChoices: $addChoices, removeChoices: $removeChoices}';
  }
}

class AddChoice {
  AddChoice({
    this.questionId,
    this.choiceText,
    this.rightChoice,
  });

  int? questionId;
  String? choiceText;
  bool? rightChoice;

  factory AddChoice.fromJson(Map<String, dynamic> json) => AddChoice(
        questionId: json["question_id"],
        choiceText: json["choice_text"],
        rightChoice: json["right_choice"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "choice_text": choiceText,
        "right_choice": rightChoice,
      };
}

class EditChoice {
  EditChoice({
    this.choiceId,
    this.choiceText,
    this.rightChoice,
  });

  int? choiceId;
  String? choiceText;
  bool? rightChoice;

  factory EditChoice.fromJson(Map<String, dynamic> json) => EditChoice(
        choiceId: json["choice_id"],
        choiceText: json["choice_text"],
        rightChoice: json["right_choice"],
      );

  Map<String, dynamic> toJson() => {
        "choice_id": choiceId,
        "choice_text": choiceText,
        "right_choice": rightChoice,
      };

  @override
  String toString() {
    return 'EditChoice{choiceId: $choiceId, choiceText: $choiceText, rightChoice: $rightChoice}';
  }
}
