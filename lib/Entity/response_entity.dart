

import 'assessment_model.dart';

class ResponseEntity {
  int status;
  dynamic data;
  String message;

  ResponseEntity(
      {required this.status,
        required this.data,
        required this.message,
      });

  factory ResponseEntity.fromJson(Map<String, dynamic> data) =>
      ResponseEntity(
        status: data["status"],
        data: data["data"],
        message: data["message"],

      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "message": message,

  };

  @override
  String toString() {
    return 'ResponseEntity{status: $status, data: $data, message: $message}';
  }
}

