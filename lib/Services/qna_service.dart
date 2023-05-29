import 'package:flutter/cupertino.dart';
import 'package:qna_test/EntityModel/user_data_model.dart';
import '../Entity/Teacher/edit_question_model.dart';
import '../Entity/user_details.dart';
import '../EntityModel/CreateAssessmentModel.dart';
import '../DataSource/qna_repo.dart';
import '../DataSource/qna_test_repo.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/Teacher/response_entity.dart';
import '../EntityModel/create_question_model.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/post_assessment_model.dart';
import '../EntityModel/static_response.dart';
import '../EntityModel/student_registration_model.dart';
import '../Entity/Teacher/assessment_settings_model.dart' as AssessmentSettings;
class QnaService {
  static Future<UserDataModel> getUserDataService(int? userId,UserDetails userDetails) async {
    return await QnaRepo.getUserData(userId,userDetails);
  }

  static Future<LoginModel> logInUser(
      String email, String password, String role) async {
    return await QnaRepo.logInUser(email, password, role);
  }

  static Future<StaticResponse> sendOtp(String email) async {
    return await QnaRepo.sendOtp(email);
  }

  static Future<StaticResponse> verifyOtp(String email, String otp) async {
    return await QnaRepo.verifyOtp(email, otp);
  }

  static Future<StaticResponse> validateOtp(String email, String otp) async {
    return await QnaRepo.validateOtp(email, otp);
  }

  static Future<StaticResponse> updatePasswordOtp(
      String email, String otp, String password) async {
    return await QnaRepo.updatePasswordOtp(email, otp, password);
  }

  static Future<ResponseEntity> updatePassword(
      String oldPassword, String newPassword, int userId,BuildContext context,UserDetails userDetails) async {
    return await QnaRepo.updatePassword(oldPassword, newPassword, userId,context,userDetails);
  }

  static Future<LoginModel> postUserDetailsService(
      StudentRegistrationModel student) async {
    return await QnaRepo.registerUserDetails(student);
  }

  static Future<QuestionPaperModel> getQuestion(
      {required String assessmentId}) async {
    return await QnaTestRepo.getQuestionPaper(assessmentId);
  }

  static Future<QuestionPaperModel> getQuestionsForPublishedAssessmentsPage(
      {required String assessmentId}) async {
    return await QnaTestRepo.getQuestionPaperForPublishedAssessmentsPage(
        assessmentId);
  }

  static Future<LoginModel> postAssessmentService(
      PostAssessmentModel? assessment,
      QuestionPaperModel? questionPaper,UserDetails userDetails) async {
    return await QnaRepo.postAssessmentRepo(assessment, questionPaper,userDetails);
  }

  static Future<ResponseEntity> createQuestionTeacherService(
      CreateQuestionModel question,UserDetails userDetails) async {
    return await QnaRepo.createQuestionTeacher(question,userDetails);
  }

  static Future<ResponseEntity> createAssessmentTeacherService(
      CreateAssessmentModel question,UserDetails userDetails) async {
    return await QnaRepo.createAssessmentTeacher(question,userDetails);
  }

  static Future<QuestionPaperModel> getQuestionGuest(
      String assessmentId, String name) async {
    return await QnaRepo.getQuestionPaperGuest(assessmentId, name);
  }

  static Future<ResponseEntity> getAllAssessment(
      int pageLimit, int pageNumber, String search,UserDetails userDetails) async {
    return await QnaRepo.getAllAssessment(pageLimit, pageNumber, search,userDetails);
  }

  static Future<ResponseEntity> getQuestionBankService(
      int pageLimit, int pageNumber, String search,UserDetails userDetails) async {
    return await QnaRepo.getAllQuestion(pageLimit, pageNumber, search,userDetails);
  }

  static Future<LoginModel> deleteQuestion(int questionId,UserDetails userDetails) async {
    return await QnaRepo.deleteQuestion(questionId,userDetails);
  }

  static Future<ResponseEntity> editQuestionTeacherService(
      EditQuestionModel question, int questionId,UserDetails userDetails) async {
    return await QnaRepo.editQuestionTeacher(question, questionId,userDetails);
  }

  static Future<ResponseEntity> editAssessmentTeacherService(
      CreateAssessmentModel assessment, int assessmentId,UserDetails userDetails) async {
    return await QnaRepo.editAssessmentTeacher(assessment, assessmentId,userDetails);
  }

  static Future<ResponseEntity> editActiveAssessmentTeacherService( CreateAssessmentModel assessmentModel,
      AssessmentSettings.AssessmentSettings assessment, int assessmentId,String assessmentType,String assessmentStatus,UserDetails userDetails) async {
    return await QnaRepo.editActiveAssessmentTeacher(assessmentModel,assessment, assessmentId,assessmentType,assessmentStatus,userDetails);
  }

  static Future<ResponseEntity> makeInactiveAssessmentTeacherService(
      AssessmentSettings.AssessmentSettings assessment, int assessmentId,String assessmentType,String assessmentStatus,UserDetails userDetails) async {
    return await QnaRepo.makeInactiveAssessmentTeacher(assessment, assessmentId, assessmentType, assessmentStatus,userDetails);
  }

  static Future<ResponseEntity> getResultDataService(
      int? userId, int pageLimit, int pageNumber,UserDetails userDetails) async {
    return await QnaRepo.getResult(userId, pageLimit, pageNumber,userDetails);
  }

  static Future<ResponseEntity> getSearchAssessment(
      int pageLimit, int pageNumber, String searchVal,UserDetails userDetails) async {
    return await QnaRepo.getSearchAssessment(pageLimit, pageNumber, searchVal,userDetails);
  }

  static Future<ResponseEntity> getSearchQuestion(
      int pageLimit, int pageNumber, String searchVal,UserDetails userDetails) async {
    return await QnaRepo.getSearchQuestion(pageLimit, pageNumber, searchVal,userDetails);
  }
}
