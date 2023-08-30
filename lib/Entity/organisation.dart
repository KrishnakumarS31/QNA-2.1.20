
class OrganisationResponse {
  OrganisationResponse(
      {this.institutions});
  List<Institution>? institutions;

  factory OrganisationResponse.fromJson(Map<String, dynamic> json) => OrganisationResponse(
    institutions: json["institutions"] == null
        ? []
        : List<Institution>.from(json["institutions"].map((x) => Institution.fromJson(x))),

  );

  // Map<String, dynamic> toJson() => {
  //   "questions": questions == null
  //       ? ''
  //       : List<dynamic>.from(questions!.map((x) => x.toJson())),
  //   "total_count": total_count ?? 0
  // };
  //
  // @override
  // String toString() {
  //   return 'Question{questions: $questions,\n total_count: $total_count,}';
  // }
}

class Institution {
  Institution(
      {required this.institutionId,
        required this.organisationName,
        required this.institutionName,
        required this.campusId,
        required this.campusName,
        required this.addressLine1,
        required this.addressLine2,
        required this.city,
        required this.state,
        required this.country,
        required this.pinZip});

  int institutionId;
  String organisationName;
  String institutionName;
  int campusId;
  String campusName;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  String pinZip;

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
    institutionId: json["institution_id"],
    organisationName: json["organisation_name"],
    institutionName: json["institution_name"],
    campusId: json["campus_id"],
    campusName: json["campus_name"],
    addressLine1: json["address_line1"] ?? '',
    addressLine2: json["address_line2"] ?? '',
    city: json["city"] ?? '',
    state: json["state"] ?? '',
    country: json["country"],
    pinZip: json["pin_zip"],
  );

  // Map<String, dynamic> toJson() => {
  //   "question_id": questionId,
  //   "question": question,
  //   "question_type": questionType,
  //   "advisor_text": advisorText,
  //   "advisor_url": advisorUrl,
  //   "subject": subject ?? '',
  //   "topic": topic ?? '',
  //   "sub_topic": semester ?? '',
  //   "class": degreeStudent ?? '',
  //   "choices": choices == null
  //       ? ''
  //       : List<dynamic>.from(choices!.map((x) => x.toJson())),
  //   "question_marks": questionMark ?? 0
  // };

  // @override
  // String toString() {
  //   return 'Question{questionId: $questionId,\n question: $question, questionType: $questionType, advisorText: $advisorText, advisorUrl: $advisorUrl, subject: $subject, topic: $topic, subTopic: $semester, datumClass: $degreeStudent,\n choices: $choices}';
  // }
}
