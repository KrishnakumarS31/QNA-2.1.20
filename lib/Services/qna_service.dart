import 'package:qna_test/EntityModel/user_data_model.dart';
import '../Entity/Teacher/edit_question_model.dart';
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

class QnaService {
  static Future<UserDataModel> getUserDataService(int? userId) async {
    return await QnaRepo.getUserData(userId);
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
      String oldPassword, String newPassword, int userId) async {
    return await QnaRepo.updatePassword(oldPassword, newPassword, userId);
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
      QuestionPaperModel? questionPaper) async {
    return await QnaRepo.postAssessmentRepo(assessment, questionPaper);
  }

  static Future<ResponseEntity> createQuestionTeacherService(
      CreateQuestionModel question) async {
    return await QnaRepo.createQuestionTeacher(question);
  }

  static Future<ResponseEntity> createAssessmentTeacherService(
      CreateAssessmentModel question) async {
    return await QnaRepo.createAssessmentTeacher(question);
  }

  static Future<QuestionPaperModel> getQuestionGuest(
      String assessmentId, String name) async {
    return await QnaRepo.getQuestionPaperGuest(assessmentId, name);
  }

  static Future<ResponseEntity> getAllAssessment(
      int pageLimit, int pageNumber) async {
    return await QnaRepo.getAllAssessment(pageLimit, pageNumber);
  }

  static Future<ResponseEntity> getQuestionBankService(
      int pageLimit, int pageNumber,String search) async {
    return await QnaRepo.getAllQuestion(pageLimit, pageNumber,search);
  }

  static Future<LoginModel> deleteQuestion(int questionId) async {
    return await QnaRepo.deleteQuestion(questionId);
  }

  static Future<ResponseEntity> editQuestionTeacherService(
      EditQuestionModel question, int questionId) async {
    return await QnaRepo.editQuestionTeacher(question, questionId);
  }

  static Future<ResponseEntity> editAssessmentTeacherService(
      CreateAssessmentModel assessment, int assessmentId) async {
    return await QnaRepo.editAssessmentTeacher(assessment, assessmentId);
  }

  static Future<ResponseEntity> getResultDataService(
      int? userId, int pageLimit, int pageNumber) async {
    return await QnaRepo.getResult(userId, pageLimit, pageNumber);
  }

  static Future<ResponseEntity> getSearchAssessment(
      int pageLimit, int pageNumber, String searchVal) async {
    return await QnaRepo.getSearchAssessment(pageLimit, pageNumber, searchVal);
  }

  static Future<ResponseEntity> getSearchQuestion(
      int pageLimit, int pageNumber, String searchVal) async {
    return await QnaRepo.getSearchQuestion(pageLimit, pageNumber, searchVal);
  }
}
