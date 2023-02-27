import 'dart:convert';
import 'package:http/http.dart' as http;

import '../EntityModel/create_question_model.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/post_assessment_model.dart';
import '../EntityModel/static_response.dart';
import '../EntityModel/student_registration_model.dart';
import '../EntityModel/user_data_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
class QnaRepo {
  static logInUser(String email, String password) async {
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    SharedPreferences loginData=await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://dev.qnatest.com/api/v1/users/login'));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
      //print(temp);
      loginData.setString('token', loginModel.data.accessToken);
    } else {
      print(response.reasonPhrase);
    }
    return loginModel;
  }

  static registerUserDetails(StudentRegistrationModel student) async {
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('https://dev.qnatest.com/api/v1/users'));
    request.body = studentRegistrationModelToJson(student);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
    } else {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
      return loginModel;
    }
    return loginModel;
  }

  static Future<UserDataModel> getUserData(int? userId) async {
    SharedPreferences loginData=await SharedPreferences.getInstance();
    UserDataModel userData = UserDataModel(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}'
    };
    var request = http.Request(
        'GET', Uri.parse('https://dev.qnatest.com/api/v1/users/$userId'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      userData = userDataModelFromJson(temp);
    }
    else if(response.statusCode == 401){
      String? email=loginData.getString('email');
      String? pass=loginData.getString('password');
      LoginModel loginModel=await logInUser(email!, pass!);
      getUserData(userId);
    }
    return userData;
  }

  static Future<StaticResponse> sendOtp(String email) async {
    StaticResponse responses =
        StaticResponse(code: 0, message: 'Incorrect Email');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://dev.qnatest.com/api/v1/users/forgot-password'));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {
      print(response.reasonPhrase);
    }
    return responses;
  }

  static Future<StaticResponse> verifyOtp(String email, String otp) async {
    StaticResponse responses =
        StaticResponse(code: 0, message: 'Incorrect OTP');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://18.215.198.141:8080/api/v1/otp'));
    request.body = json.encode({"email": email, "otp": otp});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {
      print(response.reasonPhrase);
    }
    return responses;
  }

  static Future<StaticResponse> updatePasswordOtp(
      String email, String otp, String password) async {
    StaticResponse responses =
        StaticResponse(code: 0, message: 'Incorrect OTP');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse('http://18.215.198.141:8080/api/v1/forgot-password'));
    request.body =
        json.encode({"email": email, "otp": otp, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {
      print(response.reasonPhrase);
    }

    return responses;
  }

  static Future<StaticResponse> updatePassword(
      String oldPassword, String newPassword, int userId) async {
    StaticResponse responses =
        StaticResponse(code: 0, message: 'Incorrect OTP');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse('http://18.215.198.141:8080/api/v1/password/$userId'));
    request.body =
        json.encode({"old_password": oldPassword, "new_password": newPassword});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {
      print(response.reasonPhrase);
    }

    return responses;
  }

  static postAssessmentRepo(PostAssessmentModel? assessment) async {
    SharedPreferences loginData=await SharedPreferences.getInstance();
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dev.qnatest.com/api/v1/assessment/result'));
    request.body = postAssessmentModelToJson(assessment!);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
    }
    else if(response.statusCode == 401){
      String? email=loginData.getString('email');
      String? pass=loginData.getString('password');
      LoginModel loginModel=await logInUser(email!, pass!);
      postAssessmentRepo(assessment);
    }
    else {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
      return loginModel;
    }
    return loginModel;
  }

  static Future<LoginModel> createQuestionTeacher(CreateQuestionModel question) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRob3JpemVkIjp0cnVlLCJleHAiOjE2NzcwODEwNTcsInJvbGUiOiJzdHVkZW50IiwidXNlcl9pZCI6MTF9.UkIi7sCyOryLj73ZB79FOzKFx_k3lGXeGbxVU4kj8Rc',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dev.qnatest.com/api/v1/assessment/questions'));
    request.body = createQuestionModelToJson(question);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    return loginModel;
  }
}
