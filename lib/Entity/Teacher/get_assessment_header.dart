import 'dart:convert';

GetAssessmentHeaderModel getAssessmentHeaderModelFromJson(String str) =>
    GetAssessmentHeaderModel.fromJson(json.decode(str));

String getAssessmentHeaderModelToJson(GetAssessmentHeaderModel data) =>
    json.encode(data.toJson());

class GetAssessmentHeaderModel {
  GetAssessmentHeaderModel({
     this.assessmentStartdate,
    this.subject,
    this.topic,
    this.subTopic,
    this.getAssessmentModelClass,
    this.allowGuestStudentTrue,
  });

  int? assessmentStartdate;
  String? subject;
  String? topic;
  String? subTopic;
  String? getAssessmentModelClass;
  bool? allowGuestStudentTrue;

  factory GetAssessmentHeaderModel.fromJson(Map<String, dynamic> json) =>
      GetAssessmentHeaderModel(
        assessmentStartdate: json["assessment_start_date"] ?? 0,
        subject: json["subject"] ?? " ",
        topic: json["topic"] ?? " ",
        subTopic: json["sub_topic"] ?? " ",
        getAssessmentModelClass: json["class"] ?? " ",
        allowGuestStudentTrue: json["allow_guest_student"] ?? " "

      );

  Map<String, dynamic> toJson() => {
    "assessment_start_date": assessmentStartdate,
    "subject": subject,
    "topic": topic,
    "sub_topic": subTopic,
    "class": getAssessmentModelClass,
    "allow_guest_student": allowGuestStudentTrue,
  };

  @override
  String toString() {
    return 'GetAssessmentHeaderModel{ subject: $subject, topic: $topic, subTopic: $subTopic, getAssessmentModelClass: $getAssessmentModelClass, assessmentStartDate: $assessmentStartdate, allowGuestStudent: $allowGuestStudentTrue}';
  }
}


