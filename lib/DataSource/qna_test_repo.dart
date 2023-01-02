import '../Entity/custom_http_response.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class QnaTestRepo{

   static Future<Response> getData() async {
      const String url = 'https://ba347605-fbd9-441c-b76a-66d01960da1d.mock.pstmn.io/api/v1/users';
      final response = await http.get(Uri.parse(url));
      //print(response.body.toString());
      String res= response.body.toString().substring(0, response.body.length);
      Response userDetails=responseFromJson(res);
      return userDetails;
  }
}

