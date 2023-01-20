import 'package:qna_test/EntityModel/user_data_model.dart';

import '../DataSource/qna_repo.dart';
import '../DataSource/qna_test_repo.dart';
import '../Entity/custom_http_response.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/response_entity.dart';
import '../Entity/student.dart';
import '../EntityModel/login_entity.dart';
import '../EntityModel/static_response.dart';

class QnaService{

  static Future<UserDataModel> getUserDataService(int userId)async {
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





  static postUserDetailsService(Student student) async{
    return await QnaTestRepo.postUserDetails(student);
  }

  static putUserDetailsService(Student student) async{
    return await QnaTestRepo.putUserDetails();
  }

   static logOut() async{
    return await QnaTestRepo.logOut();
  }

  static Future<QuestionPaperModel> getQuestion() async{
    return await QnaTestRepo.getQuestionPaper();
  }

  static Future<ResponseEntity> getOQuestion() async{
    return await QnaTestRepo.getOQuestionPaper();
  }


}