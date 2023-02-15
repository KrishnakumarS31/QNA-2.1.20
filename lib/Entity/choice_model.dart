class Choice {
  Choice({
    required this.choiceId,
    required this.choiceText,
    required this.rightChoice,
  });

  String choiceId;
  String choiceText;
  bool rightChoice;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        choiceId: json["choice_id"],
        choiceText: json["choice_text"],
        rightChoice: json["right_choice"] == null ? null : json["right_choice"],
      );

  Map<String, dynamic> toJson() => {
        "choice_id": choiceId,
        "choice_text": choiceText,
        "right_choice": rightChoice == null ? null : rightChoice,
      };
}
