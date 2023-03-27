import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Entity/Teacher/edit_question_model.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/question_paper_model.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../EntityModel/create_question_model.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/post_assessment_model.dart';
import '../EntityModel/static_response.dart';
import '../EntityModel/student_registration_model.dart';
import '../EntityModel/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'http_url.dart';

class QnaRepo {
  static logInUser(String email, String password, String? role) async {
    LoginModel loginModel = LoginModel();

    SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(loginInUserUrl));
    request.body =
        json.encode({"email": email, "password": password, "role": role});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String temp = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      loginModel = loginModelFromJson(temp);
      loginData.setString('token', loginModel.data.accessToken);
    }
    else {
      loginModel = loginModelFromJson(temp);
    }
    return loginModel;
  }

  static registerUserDetails(StudentRegistrationModel student) async {
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(usersDomain));
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
    SharedPreferences loginData = await SharedPreferences.getInstance();
    UserDataModel userData = UserDataModel();
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request('GET', Uri.parse('$usersDomain/$userId'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      userData = userDataModelFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      getUserData(userId);
    }
    return userData;
  }

  static Future<StaticResponse> sendOtp(String email) async {
    StaticResponse responses =
        StaticResponse(code: 0, message: 'Incorrect Email');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(sendOtpUrl));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {}
    return responses;
  }

  static Future<StaticResponse> verifyOtp(String email, String otp) async {
    StaticResponse responses = StaticResponse(message: '');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(verifyOtpUrl));
    request.body = json.encode({"email": email, "otp": otp});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {}
    return responses;
  }

  static Future<StaticResponse> validateOtp(String email, String otp) async {
    StaticResponse responses = StaticResponse(message: '');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(validateOtpUrl));
    request.body = json.encode({"email": email, "otp": otp});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode != null) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {
    }
    return responses;
  }

  static Future<StaticResponse> updatePasswordOtp(
      String email, String otp, String password) async {
    StaticResponse responses = StaticResponse(message: '');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PUT', Uri.parse(sendOtpUrl));
    request.body =
        json.encode({"email": email, "otp": otp, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode != null) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {}
    return responses;
  }

  static Future<ResponseEntity> updatePassword(
      String oldPassword, String newPassword, int userId) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity responses =
        ResponseEntity(code: 0, message: 'Incorrect OTP');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('$updatePasswordUrl/$userId'));
    request.body =
        json.encode({"old_password": oldPassword, "new_password": newPassword});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      updatePassword(oldPassword, newPassword, userId);
    } else {}

    return responses;
  }

  static postAssessmentRepo(PostAssessmentModel? assessment,
      QuestionPaperModel? questionPaper) async {
    String? token;
    SharedPreferences loginData = await SharedPreferences.getInstance();

    if (questionPaper!.data!.accessTokenDetails!.accessToken == null) {
      token = loginData.getString('token');
    } else {
      assessment!.userId = questionPaper.data!.accessTokenDetails!.userId!;
      token = questionPaper.data!.accessTokenDetails!.accessToken!;
    }
    assessment?.userId = loginData.getInt('userId');
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(resultUrl));
    request.body = postAssessmentModelToJson(assessment!);
    log(request.body);

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      postAssessmentRepo(assessment, questionPaper);
    } else {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
      return loginModel;
    }
    return loginModel;
  }

  static Future<ResponseEntity> createQuestionTeacher(
      CreateQuestionModel question) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(questionUrl));
    request.body = createQuestionModelToJson(question);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      createQuestionTeacher(question);
    } else {}
    return loginModel;
  }

  static Future<ResponseEntity> createAssessmentTeacher(
      CreateAssessmentModel question) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(assessmentDomain));
    request.body = createAssessmentModelToJson(question);
    debugPrint(request.body);
    log(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      createAssessmentTeacher(question);
    } else {}
    return loginModel;
  }

  static Future<QuestionPaperModel> getQuestionPaperGuest(
      String assessmentId, String name) async {
    QuestionPaperModel questionPaperModel;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('$assessmentDomain/guest?code=$assessmentId'));
    request.body = json.encode({"first_name": name});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    String value = await response.stream.bytesToString();
    questionPaperModel = questionPaperModelFromJson(value);
    return questionPaperModel;
  }

  static Future<ResponseEntity> getAllAssessment(
      int pageLimit, int pageNumber) async {
    ResponseEntity allAssessment = ResponseEntity();
    SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$assessmentDomain/all/${loginData.getInt('userId')}/?page_limit=$pageLimit&page_number=$pageNumber'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      allAssessment = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      getAllAssessment(pageLimit, pageNumber);
    } else {}
    return allAssessment;
  }

  static Future<ResponseEntity> getAllQuestion(
      int pageLimit, int pageNumber) async {
    ResponseEntity responseEntity = ResponseEntity();
    SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$allQuestionUrl/${loginData.getInt('userId')}?page_limit=$pageLimit&page_number=$pageNumber'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      responseEntity = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      getAllQuestion(pageLimit, pageNumber);
    } else {}
    return responseEntity;
  }

  static Future<LoginModel> deleteQuestion(int questionId) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '$questionUrl/$questionId?user_id=${loginData.getInt('userId')}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      deleteQuestion(questionId);
    } else {}
    return loginModel;
  }

  static Future<ResponseEntity> editQuestionTeacher(
      EditQuestionModel question, int questionId) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT',
        Uri.parse(
            '$questionUrl/$questionId?user_id=${loginData.getInt('userId')}'));
    request.body = editQuestionModelToJson(question);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      editQuestionTeacher(question, questionId);
    } else {}
    return loginModel;
  }

  static Future<ResponseEntity> editAssessmentTeacher(
      CreateAssessmentModel assessment, int assessmentId) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${loginData.getString('token')}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT',
        Uri.parse(
            '$assessmentDomain/$assessmentId?user_id=${loginData.getInt('userId')}'));
    request.body = createAssessmentModelToJson(assessment);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      editAssessmentTeacher(assessment, assessmentId);
    } else {}
    return loginModel;
  }

  static Future<ResponseEntity> getResult(
      int? userId, int pageLimit, int pageNumber) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity resultData = ResponseEntity(code: 0, message: 'message');
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$resultsUrl/${loginData.getInt('userId')}?page_limit=$pageLimit&page_number=$pageNumber'));
    //${loginData.getInt('userId')}
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      resultData = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {}
    return resultData;
  }

  static Future<ResponseEntity> getSearchAssessment(
      int pageLimit, int pageNumber, String searchVal) async {
    ResponseEntity allAssessment = ResponseEntity();
    SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$assessmentLooqUrl?page_limit=$pageLimit&page_number=$pageNumber&search=$searchVal'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      allAssessment = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      getSearchAssessment(pageLimit, pageNumber, searchVal);
    } else {}
    return allAssessment;
  }

  static Future<ResponseEntity> getSearchQuestion(
      int pageLimit, int pageNumber, String searchVal) async {
    ResponseEntity allAssessment = ResponseEntity();
    SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://dev.qnatest.com/api/v1/assessment/questions-looq?page_limit=$pageLimit&page_number=$pageNumber&search=$searchVal'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      allAssessment = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel =
          await logInUser(email!, pass!, loginData.getString('role'));
      getSearchQuestion(pageLimit, pageNumber, searchVal);
    } else {}
    return allAssessment;
  }
}
