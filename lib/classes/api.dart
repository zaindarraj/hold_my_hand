import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:hold_my_hand/consts.dart';
import 'package:http/http.dart';

class API {
  //send location data
  static Future<dynamic> enableLocation(
      int code, String userID, Position? position) async {
    try {
      Response response = await post(
        Uri.parse(sendLocationUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'code': code.toString(),
          'longtitude':
              position != null ? position.longitude.toString() : "null",
          'latitude': position != null ? position.latitude.toString() : "null",
          'userID': userID
        }),
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse["code"] == 1) {
          return oK;
        } else {
          return serverError;
        }
      }
    } catch (_) {
      return serverError;
    }
  }

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
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = Map.from(jsonDecode(response.body));
        if (jsonMap["code"] == "1") {
          return jsonMap;
        } else {
          return jsonMap["message"] as String;
        }
      } else {
        return serverError;
      }
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
        Map<String, dynamic> jsonMap = Map.from(jsonDecode(response.body));
        if (jsonMap["code"] == "1") {
          return jsonMap;
        } else {
          return jsonMap["message"] as String;
        }
      } else {
        return serverError;
      }
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
    } catch (_) {
      return serverError;
    }
  }

  //will change with backend api changes
  static Future<dynamic> approve(String email, String accountType) async {
    try {
      Response response = await post(
        Uri.parse(approveUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': email, 'account_type': accountType}),
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
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> sendMessege(
      String senderID, String receiverID, String message) async {
    try {
      Response response = await post(
        Uri.parse(sendMessegeUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'senderID': senderID,
          'receiverID': receiverID,
          'message': message
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        return jsonMap;
      }
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> getUserChats(String userID) async {
    try {
      Response response = await post(
        Uri.parse(getUserChatsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userID': userID,
        }),
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> readMessages(
      String senderID, String receiverID) async {
    try {
      Response response = await post(
        Uri.parse(startChattingURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'senderID': senderID, 'receiverID': receiverID}),
      ).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = json.decode(response.body);
        if (responseMap["code"] == "1") {
          return responseMap;
        }
        return "User not found";
      }
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> orderFood(
      String email, String password, String cardID, List<String> order) async {
    try {
      Response response = await post(
        Uri.parse(orderFoodUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'cardID': cardID,
          'order': order.toString()
        }),
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        print(jsonMap);
        if (jsonMap["code"] == "1") {
          return 1;
        } else {
          return "wrong info";
        }
      }
      return serverError;
    } catch (_) {
      return serverError;
    }
  }
}
