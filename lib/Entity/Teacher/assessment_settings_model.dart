import 'dart:convert';
AssessmentSettings assessmentSettingsFromJson(String str) =>
    AssessmentSettings.fromJson(json.decode(str));

String assessmentSettingsToJson(AssessmentSettings data) =>
    json.encode(data.toJson());

class AssessmentSettings {
  AssessmentSettings({
    this.allowedNumberOfTestRetries,
    this.avalabilityForPractice,
    this.numberOfDaysAfterTestAvailableForPractice,
    this.allowGuestStudent,
    this.showSolvedAnswerSheetInAdvisor,
    this.showAdvisorName,
    this.showAdvisorEmail,
    this.notAvailable,
    this.showAnswerSheetDuringPractice,
    this.advisorName,
    this.advisorEmail,
  });

  int? allowedNumberOfTestRetries;
  bool? avalabilityForPractice;
  int? numberOfDaysAfterTestAvailableForPractice;
  bool? allowGuestStudent;
  bool? showSolvedAnswerSheetInAdvisor;
  bool? showAdvisorName;
  bool? showAdvisorEmail;
  bool? notAvailable;
  bool? showAnswerSheetDuringPractice;
  String? advisorName;
  String? advisorEmail;

  factory AssessmentSettings.fromJson(Map<String, dynamic> json) =>
      AssessmentSettings(
        allowedNumberOfTestRetries: json["allowed_number_of_test_retries"] ?? 0,
        avalabilityForPractice: json["avalability_for_practice"] ?? false,
        numberOfDaysAfterTestAvailableForPractice: json["number_of_days_after_test_available_for_practice"] ?? 0,
        allowGuestStudent: json["allow_guest_student"] ?? false,
        showSolvedAnswerSheetInAdvisor: json["show_solved_answer_sheet_in_advisor"] ?? false,
        showAdvisorName: json["show_advisor_name"] ?? false,
        showAdvisorEmail: json["show_advisor_email"] ?? false,
        notAvailable: json["not_available"] ?? false,
        showAnswerSheetDuringPractice: json["show_answer_sheet_during_practice"] ?? false,
        advisorName: json["advisor_name"]??'',
        advisorEmail: json["advisor_email"]??'',
      );

  Map<String, dynamic> toJson() => {
    "allowed_number_of_test_retries": allowedNumberOfTestRetries ?? 0,
    "avalability_for_practice": avalabilityForPractice ?? false,
    "number_of_days_after_test_available_for_practice": numberOfDaysAfterTestAvailableForPractice ?? 0,
    "allow_guest_student": allowGuestStudent ?? false,
    "show_solved_answer_sheet_in_advisor": showSolvedAnswerSheetInAdvisor ?? false,
    "show_advisor_name": showAdvisorName ?? false,
    "show_advisor_email": showAdvisorEmail ?? false,
    "not_available": notAvailable ?? false,
    "show_answer_sheet_during_practice": showAnswerSheetDuringPractice ?? false,
    "advisor_name": advisorName??'',
    "advisor_email": advisorEmail??'',
  };

  @override
  String toString() {
    return 'AssessmentSettings{\n allowedNumberOfTestRetries: $allowedNumberOfTestRetries, avalabilityForPractice: $avalabilityForPractice, numberOfDaysAfterTestAvailableForPractice: $numberOfDaysAfterTestAvailableForPractice,\n  allowGuestStudent: $allowGuestStudent, showSolvedAnswerSheetInAdvisor: $showSolvedAnswerSheetInAdvisor,\n  showAdvisorName: $showAdvisorName, showAdvisorEmail: $showAdvisorEmail, notAvailable: $notAvailable,\n  showAnswerSheetDuringPractice: $showAnswerSheetDuringPractice}';
  }
}