import 'dart:async';
import 'dart:convert';

import 'package:hold_my_hand/consts.dart';
import 'package:http/http.dart';

class API {
  //sign ups are used to add users/benefectors as well
  static Future<dynamic> signUpUser(String email, String password, String fName,
      String lName, String disablity) async {
    try {
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
      ).timeout(const Duration(seconds: 9));
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
    } on TimeoutException catch (_) {
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> signUpBenefector(
      String email, String password, String fName, String lName) async {
    try {
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
      ).timeout(const Duration(seconds: 9));
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
    } on TimeoutException catch (_) {
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  //approving users
  static Future<dynamic> getUsersList() async {
    try {
      Response response = await post(Uri.parse(usersListUrl))
          .timeout(const Duration(seconds: 9));

      dynamic jsonDecoded = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonDecoded.runtimeType == List<dynamic>) {
          List<dynamic> list = jsonDecoded;
          return list.map((e) => Map.from(e)).toList();
        } else {
          return noUsers;
        }
      }
      return serverError;
    } on TimeoutException catch (_) {
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> getBenefectorList() async {
    try {
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
    } on TimeoutException catch (_) {
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> approveUser(String email) async {
    try {
      Response response = await post(
        Uri.parse(approveUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}),
      ).timeout(const Duration(seconds: 9));
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
    } on TimeoutException catch (_) {
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> deleteUser(String email) async {
    try {
      Response response = await post(
        Uri.parse(deleteUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}),
      ).timeout(const Duration(seconds: 9));
      if (response.statusCode == 200) {
        Map<String, String> jsonMap = Map.from(jsonDecode(response.body));

        if (jsonMap["message"] == oK) {
          return oK;
        } else {
          return jsonMap["message"] as String;
        }
      }
      return serverError;
    } on TimeoutException catch (_) {
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> deleteBenefector(String email) async {
    try {
      Response response = await post(
        Uri.parse(deleteUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}),
      ).timeout(const Duration(seconds: 9));
      if (response.statusCode == 200) {
        Map<String, String> jsonMap = Map.from(jsonDecode(response.body));

        if (jsonMap["message"] == oK) {
          return oK;
        } else {
          return jsonMap["message"] as String;
        }
      }
      return serverError;
    } on TimeoutException catch (_) {
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> signIn(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse(signInUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = Map.from(jsonDecode(response.body));

        //account type is user
        if (jsonMap["code"] != "-1") {
          return jsonMap;
        } else {
          return jsonMap["messege"];
        }
      } else {
        return serverError;
      }
    } catch (e) {
      return serverError;
    }
  }
}
