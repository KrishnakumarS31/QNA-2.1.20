class Choice {
  Choice({
    this.questionChoiceId,
    this.choiceText,
    this.rightChoice,
  });

  dynamic questionChoiceId;
  String? choiceText;
  bool? rightChoice;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        questionChoiceId: json["question_choice_id"],
        choiceText: json["choice_text"],
        rightChoice: json["right_choice"],
      );

  Map<String, dynamic> toJson() => {
        "question_choice_id": questionChoiceId,
        "choice_text": choiceText,
        "right_choice": rightChoice,
      };

  @override
  String toString() {
    return 'Choice{questionChoiceId: $questionChoiceId, choiceText: $choiceText, rightChoice: $rightChoice}';
  }
}
