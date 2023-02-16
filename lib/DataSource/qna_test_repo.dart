import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Entity/DataModel.dart';
import '../Entity/custom_http_response.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/response_entity.dart';
import '../Entity/student.dart';
import '../EntityModel/GetQuestionBankModel.dart';

class QnaTestRepo {
  //Map<String,String> headers = {'Content-Type':'application/json','authorization':'Bearer 9764048494'};
  final msg =
      jsonEncode({"email": "demo.qna@viewwiser.com", "password": "password"});
  late QuestionPaperModel questionPaperModel;

  static Future<Response> getData() async {
    const String url =
        'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users';
    final response = await http.get(Uri.parse(url));
    //print(response.body.toString());
    String res = response.body.toString().substring(0, response.body.length);
    Response userDetails = responseFromJson(res);
    //print(userDetails.data.userProfile[0].firstName);
    return userDetails;
  }

  static postUserDetails(Student student) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users'));
    request.body = studentToJson(student);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static putUserDetails() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users'));
    request.body = json.encode({
      "user_id": 1,
      "residentCountry": "United States",
      "email": "user1.123@itc.com",
      "rollNumber": "A0987654",
      "organisationName": "abcde"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static logInUser(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users/login'));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  static updatePassword(String oldPassword, String newPassword) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/password'));
    request.body =
        json.encode({"old_password": oldPassword, "new_password": newPassword});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  static sendOtp() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/password'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static updatePasswordOtp(String email, String otp, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/password'));
    request.body =
        json.encode({"email": email, "otp": otp, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  static logOut() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users?action=logout'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<QuestionPaperModel> getQuestionPaper(assessmentId) async {
    print("Insisde Question Paper thing");
    QuestionPaperModel questionPaperModel;
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://dev.qnatest.com/api/v1/assessment?code=$assessmentId'));
    http.StreamedResponse response = await request.send();
    //print(response.statusCode);
    //if (response.statusCode == 200) {
    String value = await response.stream.bytesToString();

    questionPaperModel = questionPaperModelFromJson(value);

    return questionPaperModel;
    //}
    // else {
    //   print(response.reasonPhrase);
    // }
    //return questionPaperModel;
  }

  static Future<ResponseEntity> getOQuestionPaper() async {
    ResponseEntity questionPaperModel;
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/assessment?assessment_id=98765432'));
    http.StreamedResponse response = await request.send();
    String value = await response.stream.bytesToString();
    questionPaperModel = ResponseEntity.fromJson(json.decode(value));
    print("vjbkfdvfb");
    Datum assessment =
        Datum.fromJson(json.decode(questionPaperModel.data.toString()));
    print(assessment.assessment.toString());
    return questionPaperModel;
  }

  static verifyOtp(String email, String otp) async {
    print(otp);
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/otp?email=$email&otp=$otp'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  static Future<int> createQuestion() async {
    int statusCode = 500;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/questions'));
    request.body = json.encode({
      "user_id": 111,
      "questions": [
        {
          "subject": "Maths",
          "topic": "Calculus",
          "sub_topic": "Chapter 12.2",
          "class": "Class XII",
          "question_type": "mcq",
          "question_marks": 1,
          "question": "values between 5 to 25 ?",
          "choices": [
            {"choice_text": "3", "right_choice": false},
            {"choice_text": "10", "right_choice": true},
            {"choice_text": "20", "right_choice": true},
            {"choice_text": "40", "right_choice": false}
          ],
          "choices_answer": ["10", "20"],
          "advisor_text": "Read section 5.5  …. And then ……",
          "advisor_url": "https://www.w3schools.com/"
        },
        {
          "subject": "Maths",
          "topic": "Calculus",
          "sub_topic": "Chapter 12.3",
          "class": "Class XII",
          "question_type": "mcq",
          "question_marks": 1,
          "question": "10+20 = ?",
          "choices": [
            {"choice_text": "30", "right_choice": true},
            {"choice_text": "10", "right_choice": false},
            {"choice_text": "20", "right_choice": false},
            {"choice_text": "40", "right_choice": false}
          ],
          "choices_answer": ["30"],
          "advisor_text": "Read section 5.5  …. And then ……",
          "advisor_url": "https://www.w3schools.com/"
        },
        {
          "subject": "Maths",
          "topic": "Calculus",
          "sub_topic": "Chapter 12.4",
          "class": "Class XII",
          "question_type": "survey",
          "question_marks": 0,
          "question":
              "Which activities in the classroom do you enjoy the most?",
          "choices": [
            {"choice_text": "Fast Facts"},
            {"choice_text": "Memory"},
            {"choice_text": "Treasure Hunt"}
          ]
        },
        {
          "subject": "Maths",
          "topic": "Calculus",
          "sub_topic": "Chapter 12.5",
          "class": "Class XII",
          "question_type": "survey",
          "question_marks": 0,
          "question":
              "Given a chance, what is one change that you would like to see?",
          "choices": [
            {"choice_text": "Teaching method"},
            {"choice_text": "Time taken to complete a chapter"},
            {"choice_text": "Extracurricular activities"},
            {"choice_text": "give time to study"}
          ]
        },
        {
          "subject": "Maths",
          "topic": "Calculus",
          "sub_topic": "Chapter 12.6",
          "class": "Class XII",
          "question_type": "descriptive",
          "question_marks": 0,
          "question": "How will you prepare your classroom for your first day?",
          "advisor_text": "Read section 5.5  …. And then ……",
          "advisor_url": "https://www.w3schools.com/"
        },
        {
          "subject": "Maths",
          "topic": "Calculus",
          "sub_topic": "Chapter 12.7",
          "class": "Class XII",
          "question_type": "descriptive",
          "question_marks": 0,
          "question":
              "How do you prepare your lesson plan and what do you include?",
          "advisor_text": "Read section 5.5  …. And then ……",
          "advisor_url": "https://www.w3schools.com/"
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return response.statusCode;
    } else {
      print(response.reasonPhrase);
    }
    return statusCode;
  }

  static Future<GetQuestionBankModel> getQuestionBankMock() async {
    GetQuestionBankModel questionBank=GetQuestionBankModel(status: 500, message: 'null');
    var request = http.Request('GET', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/questions'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      questionBank = getQuestionBankModelFromJson(value);
    }
    else {
      print(response.reasonPhrase);
    }
    return questionBank;
  }

}
