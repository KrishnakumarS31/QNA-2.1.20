import 'dart:convert';



import 'package:http/http.dart' as http;

import '../Entity/DataModel.dart';
import '../Entity/custom_http_response.dart';
import '../Entity/question_paper_model.dart';
import '../Entity/response_entity.dart';
import '../Entity/student.dart';
class QnaTestRepo{
  //Map<String,String> headers = {'Content-Type':'application/json','authorization':'Bearer 9764048494'};
  final msg = jsonEncode({"email": "demo.qna@viewwiser.com", "password": "password"});
  late QuestionPaperModel questionPaperModel;


   static Future<Response> getData() async {
      const String url = 'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users';
      final response = await http.get(Uri.parse(url));
      //print(response.body.toString());
      String res= response.body.toString().substring(0, response.body.length);
      Response userDetails=responseFromJson(res);
      //print(userDetails.data.userProfile[0].firstName);
      return userDetails;
  }

   static postUserDetails(Student student) async {
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('POST', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users'));
     request.body = studentToJson(student);
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
       print(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }
   }

   static putUserDetails() async{
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('PUT', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users'));
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
     }
     else {
       print(response.reasonPhrase);
     }
   }

   static logInUser(String email,String password) async{
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('POST', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users/login'));
     request.body = json.encode({
       "email": email,
       "password": password
     });
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
       print(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }
     return response.statusCode;
   }

   static updatePassword(String oldPassword,String newPassword) async{
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('PUT', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/password'));
     request.body = json.encode({
       "old_password": oldPassword,
       "new_password": newPassword
     });
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
       print(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }
     return response.statusCode;
   }

   static sendOtp() async{
     var request = http.Request('GET', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/password'));
     http.StreamedResponse response = await request.send();
     if (response.statusCode == 200) {
       print(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }
   }

   static updatePasswordOtp(String email,String otp,String password) async{
     var headers = {
       'Content-Type': 'application/json'
     };
     var request = http.Request('PUT', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/password'));
     request.body = json.encode({
       "email": email,
       "otp": otp,
       "password": password
     });
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
       print(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }
     return response.statusCode;
   }

   static logOut() async{
     var request = http.Request('GET', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users?action=logout'));
     http.StreamedResponse response = await request.send();
     if (response.statusCode == 200) {
       print(await response.stream.bytesToString());
     }
     else {
       print(response.reasonPhrase);
     }
   }

  static Future<QuestionPaperModel> getQuestionPaper(assessmentId) async{
    QuestionPaperModel questionPaperModel;
    print(assessmentId);
    var request = http.Request('GET', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/assessment?assessment_id=$assessmentId'));
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    //if (response.statusCode == 200) {
      String value=await response.stream.bytesToString();

      questionPaperModel =questionPaperModelFromJson(value);

      return questionPaperModel;
    //}
    // else {
    //   print(response.reasonPhrase);
    // }
    //return questionPaperModel;
  }

  static Future<ResponseEntity> getOQuestionPaper() async{
    ResponseEntity questionPaperModel;
    var request = http.Request('GET', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/assessment?assessment_id=98765432'));
    http.StreamedResponse response = await request.send();
    String value=await response.stream.bytesToString();
    questionPaperModel =ResponseEntity.fromJson(json.decode(value));
    print("vjbkfdvfb");
    Datum assessment=Datum.fromJson(json.decode(questionPaperModel.data.toString()));
    print(assessment.assessment.toString());
    return questionPaperModel;
  }

  static verifyOtp(String email,String otp) async{
     print(otp);
    var request = http.Request('POST', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/otp?email=$email&otp=$otp'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }



}

