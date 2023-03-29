import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Entity/question_paper_model.dart';
import '../EntityModel/login_entity.dart';
import 'http_url.dart';

class QnaTestRepo {
  //Map<String,String> headers = {'Content-Type':'application/json','authorization':'Bearer 9764048494'};
  final msg =
      jsonEncode({"email": "demo.qna@viewwiser.com", "password": "password"});
  late QuestionPaperModel questionPaperModel;

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

  static Future<QuestionPaperModel> getQuestionPaper(assessmentId) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    QuestionPaperModel questionPaperModel;
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$assessmentDomain?code=$assessmentId&user_id=${loginData.getInt('userId')}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String value = await response.stream.bytesToString();
    questionPaperModel = questionPaperModelFromJson(value);
    if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel = await logInUser(email!, pass!);
      getQuestionPaper(assessmentId);
    }

    return questionPaperModel;
    //}
    // else {
    //   print(response.reasonPhrase);
    // }
    //return questionPaperModel;
  }

  static Future<QuestionPaperModel> getQuestionPaperForPublishedAssessmentsPage(
      assessmentId) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    QuestionPaperModel questionPaperModel;
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$assessmentDomain?code=$assessmentId&user_id=${loginData.getInt('userId')}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String value = await response.stream.bytesToString();
    questionPaperModel = questionPaperModelFromJson(value);
    print(response.statusCode);
    if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel = await logInUser(email!, pass!);
      getQuestionPaper(assessmentId);
    }

    return questionPaperModel;
    //}
    // else {
    //   print(response.reasonPhrase);
    // }
    //return questionPaperModel;
  }
}
