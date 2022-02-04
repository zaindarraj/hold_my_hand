import 'dart:convert';

import 'package:hold_my_hand/consts.dart';
import 'package:http/http.dart';

class API {
  static Future<String> signUp(String email, String password) async {
    Response response = await post(
      Uri.parse(signUpUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      Map<String, String> jsonMap = Map.from(jsonDecode(response.body));
      if (jsonMap["message"] == signedUpResponse) {

        return signedUpResponse;
      } else {
        return jsonMap["message"] as String;
      }
    } else {
      return serverError;
    }
  }

  static Future<String> signIn(String email, String password) async {
    Response response = await post(
      Uri.parse(signInUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      Map<String, String> jsonMap = Map.from(jsonDecode(response.body));

      if (jsonMap["message"] == signedInResponse) {
        return signedInResponse;
      } else {
        return jsonMap["message"] as String;
      }
    } else {
      return serverError;
    }
  }
}
