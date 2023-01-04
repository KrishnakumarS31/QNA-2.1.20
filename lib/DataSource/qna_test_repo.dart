import 'dart:convert';


import '../Entity/custom_http_response.dart';

import 'package:http/http.dart' as http;

import '../Entity/student.dart';
class QnaTestRepo{
  //Map<String,String> headers = {'Content-Type':'application/json','authorization':'Bearer 9764048494'};
  final msg = jsonEncode({"email": "demo.qna@viewwiser.com", "password": "password"});

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
     var request = http.Request('POST', Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users'));
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
     return response.statusCode.toString();
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

}

