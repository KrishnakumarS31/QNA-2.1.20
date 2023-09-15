import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../Components/custom_incorrect_popup.dart';
import '../Entity/Teacher/assessment_settings_model.dart' as AssessmentSettings;
import '../Entity/Teacher/assessment_settings_model.dart';
import '../Entity/Teacher/edit_question_model.dart';
import '../Entity/Teacher/response_entity.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/user_details.dart';
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
    } else {
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

  static editUserDetails(StudentRegistrationModel student, int id,UserDetails userDetails) async {
    LoginModel loginModel = LoginModel(code: 0, message: 'message');

    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse("$editUserProfile/$id"));
    request.body = studentRegistrationModelToJson(student);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();

      loginModel = loginModelFromJson(temp);
    }
    else {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
      return loginModel;
    }
    return loginModel;
  }

  static Future<UserDataModel> getUserData(int? userId,UserDetails userDetails) async {
    UserDataModel userData = UserDataModel();
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    var request = http.Request('GET', Uri.parse('$usersDomain/$userId'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      userData = userDataModelFromJson(temp);
    } else if (response.statusCode == 401) {
      getUserData(userId,userDetails);
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
    } else {}
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
      String oldPassword, String newPassword, int userId,BuildContext context,UserDetails userDetails) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity responses =
    ResponseEntity(code: 0, message: 'Incorrect OTP');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
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
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      updatePassword(oldPassword, newPassword, userId,context,userDetails);
    } else {}

    return responses;
  }

  static postAssessmentRepo(PostAssessmentModel? assessment,
      QuestionPaperModel? questionPaper,UserDetails userDetails) async {
    String? token;
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    if (questionPaper!.data!.accessTokenDetails!.accessToken == null) {
      token = userDetails.token;
      assessment?.userId = assessment.userId;
    } else {
      assessment!.userId = questionPaper.data!.accessTokenDetails!.userId!;
      token = questionPaper.data!.accessTokenDetails!.accessToken!;
    }

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
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      postAssessmentRepo(assessment, questionPaper,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
      return loginModel;
    }
    return loginModel;
  }

  static Future<ResponseEntity> createQuestionTeacher(
      CreateQuestionModel question,UserDetails userDetails) async {
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
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
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      createQuestionTeacher(question,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
    }
    return loginModel;
  }

  static Future<ResponseEntity> createAssessmentTeacher(
      CreateAssessmentModel question,UserDetails userDetails) async {
    if(question.assessmentStartdate==null){
      DateTime date1 = DateTime.now();
      date1 = DateTime(
          date1.year,
          date1.month,
          date1.day,
          date1.hour,
          date1.minute);
      question.assessmentStartdate=date1.microsecondsSinceEpoch;
    }
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(assessmentDomain));
    request.body = createAssessmentModelToJson(question);
    debugPrint(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel =responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      createAssessmentTeacher(question,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
      loginModel =responseEntityFromJson(temp);
    }
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
      int pageLimit, int pageNumber, String search,UserDetails userDetails) async {
    ResponseEntity allAssessment = ResponseEntity();
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    bool isNumeric = (num.tryParse(search) != null);

    String url = isNumeric ? '$assessmentDomain/all/${userDetails.userId}/?page_limit=${10}&page_number=${1}&assessment_code=$search' : '$assessmentDomain/all/${userDetails.userId}/?page_limit=$pageLimit&page_number=$pageNumber&search=$search';
    var request = http.Request(
        'GET',
        Uri.parse(
            url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();

      allAssessment = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      getAllAssessment(pageLimit, pageNumber, search,userDetails);
    } else {

      String value = await response.stream.bytesToString();
    }
    return allAssessment;
  }

  static Future<ResponseEntity> getAllQuestion(
      int pageLimit, int pageNumber, String search,UserDetails userDetails) async {
    ResponseEntity responseEntity = ResponseEntity();
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};

    var request = http.Request(
        'GET',
        Uri.parse(
            '$allQuestionUrl/${userDetails.userId}?page_limit=$pageLimit&page_number=$pageNumber&search=$search'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      responseEntity = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      getAllQuestion(pageLimit, pageNumber, search,userDetails);
    } else {
      String value = await response.stream.bytesToString();
    }
    return responseEntity;
  }

  static Future<LoginModel> deleteQuestion(int questionId,UserDetails userDetails) async {
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    LoginModel loginModel = LoginModel(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '$questionUrl/$questionId?user_id=${userDetails.userId}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      deleteQuestion(questionId,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
      loginModel = loginModelFromJson(temp);
    }
    return loginModel;
  }

  static Future<ResponseEntity> editQuestionTeacher(
      EditQuestionModel question, int questionId,UserDetails userDetails) async {
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT',
        Uri.parse(
            '$questionUrl/$questionId?user_id=${userDetails.userId}'));
    request.body = editQuestionModelToJson(question);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      editQuestionTeacher(question, questionId,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
    }
    return loginModel;
  }

  static Future<ResponseEntity> editAssessmentTeacher(
      CreateAssessmentModel assessment, int assessmentId,UserDetails userDetails) async {
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT',
        Uri.parse(
            '$assessmentDomain/$assessmentId?user_id=${userDetails.userId}'));
    request.body = createAssessmentModelToJson(assessment);
    debugPrint(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      editAssessmentTeacher(assessment, assessmentId,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
    }
    return loginModel;
  }

  static Future<ResponseEntity> editActiveAssessmentTeacher( CreateAssessmentModel assessmentModel,
      AssessmentSettings.AssessmentSettings assessment, int assessmentId,String assessmentType,String assessmentStatus,UserDetails userDetails) async {
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT',
        Uri.parse(
            '$assessmentDomain/$assessmentId?user_id=${userDetails.userId}'));
    int? assessmentStartDate = assessmentModel.assessmentStartdate;
    int? assessmentEndDate = assessmentModel.assessmentEnddate;
    int? assessmentDuration = assessmentModel.assessmentDuration;
    assessment.advisorName=userDetails.firstName;
    assessment.advisorEmail=userDetails.email;
    request.body = assessmentSettingsToJson(assessment);
    String t="{\"assessment_type\": \"$assessmentType\", \"assessment_status\": \"$assessmentStatus\",\"assessment_settings\": ${request.body}, \"assessment_startdate\": $assessmentStartDate,\"assessment_enddate\": $assessmentEndDate,\"assessment_duration\": $assessmentDuration }";
    request.body=t;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      editActiveAssessmentTeacher(assessmentModel,assessment, assessmentId,assessmentType,assessmentStatus,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
    }
    return loginModel;
  }

  static Future<ResponseEntity> makeInactiveAssessmentTeacher(
      AssessmentSettings.AssessmentSettings assessment, int assessmentId,String assessmentType,String assessmentStatus,UserDetails userDetails) async {
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    ResponseEntity loginModel = ResponseEntity(code: 0, message: 'message');
    var headers = {
      'Authorization': 'Bearer ${userDetails.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT',
        Uri.parse(
            '$assessmentDomain/$assessmentId?user_id=${userDetails.userId}'));
    assessment.advisorName=userDetails.firstName;
    assessment.advisorEmail=userDetails.email;
    String h = assessmentSettingsToJson(assessment);
    String t="{\"assessment_type\": \"$assessmentType\", \"assessment_status\": \"$assessmentStatus\", \"assessment_settings\": $h }";
    request.body=t;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      loginModel = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      makeInactiveAssessmentTeacher(assessment, assessmentId,assessmentType,assessmentStatus,userDetails);
    } else {
      String temp = await response.stream.bytesToString();
    }
    return loginModel;
  }

  static Future<ResponseEntity> getSearchAssessment(
      int pageLimit, int pageNumber, String searchVal,UserDetails userDetails) async {
    ResponseEntity allAssessment = ResponseEntity();

    //SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    bool isNumeric = (num.tryParse(searchVal) != null);

    String url = isNumeric ?'$assessmentLooqUrl?page_limit=${10}&page_number=${1}&assessment_code=$searchVal' :'$assessmentLooqUrl?page_limit=$pageLimit&page_number=$pageNumber&search=$searchVal&user_id=${userDetails.userId}';
    var request = http.Request(
        'GET',
        Uri.parse(
            url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      allAssessment = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      getSearchAssessment(pageLimit, pageNumber, searchVal,userDetails);
    } else {}
    return allAssessment;
  }

  static Future<ResponseEntity> getAssessmentHeader(String assessmentCode,UserDetails userDetails) async {
    ResponseEntity allAssessment = ResponseEntity();
    //SharedPreferences loginData = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$domainName/api/v1/assessment-details?code=$assessmentCode'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String value = await response.stream.bytesToString();
    allAssessment = responseEntityFromJson(value);
    return allAssessment;
  }

  static Future<ResponseEntity> getSearchQuestion(
      int pageLimit, int pageNumber, String searchVal,UserDetails userDetails) async {
    ResponseEntity allAssessment = ResponseEntity();
    //SharedPreferences loginData = await SharedPreferences.getInstance();

    var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$assessmentDomain/questions-looq?page_limit=$pageLimit&page_number=$pageNumber&search=$searchVal'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      allAssessment = responseEntityFromJson(value);
    } else if (response.statusCode == 401) {
      String? email = userDetails.email;
      String? pass = userDetails.password;
      LoginModel loginModel =
      await logInUser(email!, pass!, userDetails.role);
      getSearchQuestion(pageLimit, pageNumber, searchVal,userDetails);
    } else {
    }
    return allAssessment;
  }

  static Future<ResponseEntity> getSearchAssessmentForStudLooq(
      int pageLimit, int pageNumber, String searchVal,int? userId) async {
    ResponseEntity allAssessment = ResponseEntity();
    pageLimit = 10;
    pageNumber = 1;
    SharedPreferences loginData = await SharedPreferences.getInstance();

    var headers = {'Authorization': 'Bearer ${loginData.getString('token')}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$assessmentLooqUrl?page_limit=$pageLimit&page_number=$pageNumber&search=$searchVal&user_id=$userId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      allAssessment = responseEntityFromJson(value);
    }
    else if (response.statusCode == 401) {
      String? email = loginData.getString('email');
      String? pass = loginData.getString('password');
      LoginModel loginModel = await logInUser(email!, pass!,"student");
      getSearchAssessmentForStudLooq(pageLimit, pageNumber, searchVal,userId);
    } else {}
    return allAssessment;
  }

  static Future<ResponseEntity> getResult(
      int? userId, int pageLimit, int pageNumber,UserDetails userDetails) async {
    ResponseEntity resultData = ResponseEntity(code: 0, message: 'message');
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};

    var request = http.Request(
        'GET',
        Uri.parse('$resultsUrl/${userDetails.userId}?page_limit=$pageLimit&page_number=$pageNumber'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      resultData = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {}
    return resultData;
  }

  static Future<ResponseEntity> getResultDetails(
      int assessmentId,int pageLimit, int pageNumber, String attemptStatus) async {
    ResponseEntity resultData = ResponseEntity(code: 0, message: 'message');
    // var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    var request = http.Request(
        'GET', Uri.parse('$resultDetails/$assessmentId?page_limit=$pageLimit&page_number=$pageNumber&attempt_status=$attemptStatus'));
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      resultData = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {}
    return resultData;
  }

  static Future<ResponseEntity> getQuestionDetails(
      int attemptId) async {
    ResponseEntity resultData = ResponseEntity(code: 0, message: 'message');
    // var headers = {'Authorization': 'Bearer ${userDetails.token}'};

    var request = http.Request(
        'GET', Uri.parse('$questionDetails?attempt_id=$attemptId'));
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      resultData = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {}
    return resultData;
  }

  static Future<StaticResponse> sendEmailOtp(String email,UserDetails userDetails) async {
    StaticResponse responses =
    StaticResponse(code: 0, message: 'Incorrect Email');
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    // var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PUT', Uri.parse(editEmailOtpUrl));
    request.body = json.encode({"user_id":userDetails.userId,"new_email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {}
    return responses;
  }

  static Future<StaticResponse> changeEmail(String email,UserDetails userDetails,String otp) async {
    StaticResponse responses =
    StaticResponse(code: 0, message: 'Incorrect Email');
    var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    // var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PUT', Uri.parse(editEmailUrl));
    request.body = json.encode({"user_id":userDetails.userId,"new_email": email,"otp":otp});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      responses = staticResponseFromJson(temp);
    } else {}
    return responses;
  }

  static Future<ResponseEntity> getInstitutionNames(
      String id) async {
    ResponseEntity resultData = ResponseEntity(code: 0, message: 'message');
    // var headers = {'Authorization': 'Bearer ${userDetails.token}'};
    var request = http.Request(
        'GET', Uri.parse('$getOrganizationNamesUrl?organisation_code=$id'));
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String temp = await response.stream.bytesToString();
      resultData = responseEntityFromJson(temp);
    } else if (response.statusCode == 401) {}
    return resultData;
  }
}
