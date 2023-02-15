import 'assessment_model.dart';

class Datum {
  Datum({
    required this.assessment,
  });

  Assessment assessment;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        assessment: Assessment.fromJson(json["assessment"]),
      );

  Map<String, dynamic> toJson() => {
        "assessment": assessment.toJson(),
      };
}
