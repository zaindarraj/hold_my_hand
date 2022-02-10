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
      if (jsonMap["message"] == oK) {
        return oK;
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
      if (jsonMap["message"] == oK) {
        return oK;
      } else {
        return jsonMap["message"] as String;
      }
    } else {
      return serverError;
    }
  }

  //approving users
  static Future<dynamic> getUsersList() async {
    Response response =
        await post(Uri.parse(usersListUrl)).timeout(const Duration(seconds: 9));

    dynamic jsonDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonDecoded.runtimeType == List<dynamic>) {
        List<dynamic> list = jsonDecoded;
        return list.map((e) => Map.from(e)).toList();
      } else {
        return "no users";
      }
    }
    return serverError;
  }

  static Future<dynamic> getBenefectorList() async {
    Response response = await post(Uri.parse(benefectorListUrl))
        .timeout(const Duration(seconds: 9));

    dynamic jsonDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonDecoded.runtimeType == List<dynamic>) {
        List<dynamic> list = jsonDecoded;
        return list.map((e) => Map.from(e)).toList();
      } else {
        return "no users";
      }
    }
    return serverError;
  }

  static Future<dynamic> approveUser(String email) async {
    Response response = await post(
      Uri.parse(approveUserUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email}),
    );
    if (response.statusCode == 200) {
      Map<String, String> jsonMap = Map.from(jsonDecode(response.body));
      if (jsonMap["message"] == oK) {
        return oK;
      } else {
        return jsonMap["message"] as String;
      }
    } else {
      return serverError;
    }
  }

  static Future<String> deleteUser(String email) async {
    Response response = await post(
      Uri.parse(deleteUserUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email}),
    );
    if (response.statusCode == 200) {
      Map<String, String> jsonMap = Map.from(jsonDecode(response.body));

      if (jsonMap["message"] == oK) {
        return oK;
      } else {
        return jsonMap["message"] as String;
      }
    }
    return serverError;
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
      print(response.body);
      Map<String, String> jsonMap = Map.from(jsonDecode(response.body));

      if (jsonMap["message"] == oK) {
        return jsonMap;
      } else {
        return jsonMap["message"] as String;
      }
    } else {
      return serverError;
    }
  }
}
