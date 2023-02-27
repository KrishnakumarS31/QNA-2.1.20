
import 'package:qna_test/EntityModel/user_data_model.dart';

import '../DataSource/qna_repo.dart';
import '../DataSource/qna_test_repo.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/response_entity.dart';
import '../Entity/student.dart';
import '../EntityModel/GetQuestionBankModel.dart';
import '../EntityModel/create_question_model.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/post_assessment_model.dart';
import '../EntityModel/static_response.dart';
import '../EntityModel/student_registration_model.dart';

class QnaService{

  static Future<UserDataModel> getUserDataService(int? userId)async {
    return await QnaRepo.getUserData(userId);
  }

  static Future<LoginModel> logInUser(String email,String password) async{
    return await QnaRepo.logInUser(email, password);
  }

  static Future<StaticResponse> sendOtp(String email) async{
    return await QnaRepo.sendOtp(email);
  }

  static Future<StaticResponse> verifyOtp(String email,String otp) async{
    return await QnaRepo.verifyOtp(email,otp);
  }

  static Future<StaticResponse> updatePasswordOtp(String email,String otp,String password) async{
    return await QnaRepo.updatePasswordOtp(email, otp, password);
  }

  static Future<StaticResponse> updatePassword(String oldPassword,String newPassword,int userId) async{
    return await QnaRepo.updatePassword(oldPassword, newPassword,userId);
  }

  static Future<LoginModel> postUserDetailsService(StudentRegistrationModel student) async{
    return await QnaRepo.registerUserDetails(student);
  }
  static Future<QuestionPaperModel> getQuestion( {required String assessmentId}) async{
    return await QnaTestRepo.getQuestionPaper(assessmentId);
  }

  static Future<LoginModel> postAssessmentService(PostAssessmentModel? assessment) async {
    return await QnaRepo.postAssessmentRepo(assessment);
  }



  static putUserDetailsService(Student student) async{
    return await QnaTestRepo.putUserDetails();
  }

   static logOut() async{
    return await QnaTestRepo.logOut();
  }

  static createQuestionService() async{
    return await QnaTestRepo.createQuestion();
  }

  static Future<GetQuestionBankModel> getQuestionBankMockService() async {
    return await QnaTestRepo.getQuestionBankMock();
  }

  static createAssessmentService() async{
    return await QnaRepo.createAssessment();
  }

  static Future<LoginModel> createQuestionTeacherService(CreateQuestionModel question) async {
    return await QnaRepo.createQuestionTeacher(question);
  }


}