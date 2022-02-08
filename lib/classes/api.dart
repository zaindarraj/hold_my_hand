import 'dart:convert';

import 'package:hold_my_hand/consts.dart';
import 'package:http/http.dart';


class API {


  //sign ups are used to add users/benefectors as well
  static Future<String> signUpUser(String email, String password, String fName,
      String lName, String disablity) async {
    Response response = await post(
      Uri.parse(signUpUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'fname': fName,
        'lname': lName,
        'accountType': 'disabled',
        'disablity': disablity
      }),
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

  static Future<String> signUpBenefector(
      String email, String password, String fName, String lName) async {
    Response response = await post(
      Uri.parse(signUpUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'fname': fName,
        'lname': lName,
        'accountType': 'benefector'
      }),
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

  static Future<String> deleteUser(String email, String password) async {
    Response response = await post(
      Uri.parse(deleteUserUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email}),
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

  static Future<dynamic> signIn(String email, String password) async {
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
        return jsonMap;
      } else {
        return jsonMap["message"] as String;
      }
    } else {
      return serverError;
    }
  }
}
