import '../DataSource/qna_test_repo.dart';
import '../Entity/custom_http_response.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/response_entity.dart';
import '../Entity/student.dart';

class QnaService{

  static Future<Response> getUserDataService()async {
    return await QnaTestRepo.getData();
  }

  static postUserDetailsService(Student student) async{
    return await QnaTestRepo.postUserDetails(student);
  }

  static putUserDetailsService(Student student) async{
    return await QnaTestRepo.putUserDetails();
  }

  static logInUser(String email,String password) async{
    return await QnaTestRepo.logInUser(email, password);
  }

  static updatePassword(String oldPassword,String newPassword) async{
    return await QnaTestRepo.updatePassword(oldPassword, newPassword);
  }

  static sendOtp() async{
    return await QnaTestRepo.sendOtp();
  }

  static updatePasswordOtp(String email,String otp,String password) async{
    return await QnaTestRepo.updatePasswordOtp(email, otp, password);
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

  static verifyOtp(String email,String otp) async{
    return await QnaTestRepo.verifyOtp(email,otp);
  }
}