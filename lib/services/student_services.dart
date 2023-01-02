import 'package:http/http.dart' as http;
import 'package:qna_test/DataSource/http_url.dart';

class StudentService {
  static Future<bool> addStudent(body) async {
    var studentRegisterUrl = Uri.parse('${URLS.domainUrl}/api/v1/users');
    // BODY
    // {
    //   "name": "test",
    //   "age": "23"
    // }
    final response = await http.post(studentRegisterUrl, body:
    {
      "firstName": "demo1",
      "lastName": "user1",
      "dob": "01/12/2022",
      "gender": "male",
      "nationality":"India",
      "residentCountry": "United States",
      "email": "demouser1@mail.com",
      "rollNumber": "12345678",
      "organisationName": "abcd",
      "roleId": ["1"],
      "password": "acsdfvb7@0987"
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // static Future<bool> studentLogin(body) async {
  //   var studentRegisterUrl = Uri.parse('${URLS.domainUrl}/api/v1/users');
  //   // BODY
  //   // {
  //   //   "name": "test",
  //   //   "age": "23"
  //   // }
  //   final response = await http.post(studentRegisterUrl, body: {
  //     "email": "demo.qna@viewwiser.com",
  //     "password": "password",
  //   });
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  static Future<bool?> studentLogin(body) async {
    var studentRegisterUrl = Uri.parse('${URLS.domainUrl}/api/v1/users');
    var map = new Map<String, dynamic>();
    map['email'] = 'demo.qna@viewwiser.com';
    map['password'] = 'password';

    final response = await http.post(
      Uri.parse('https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io'),
      body: map,
    );
    print(response.body.length);
  }

}