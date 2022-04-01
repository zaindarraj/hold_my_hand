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
      print(position!.latitude.toString());
      Response response = await post(
        Uri.parse(url + "/set_location.php"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'code': code.toString(),
          'log': position.longitude.toString(),
          'lat': position.latitude.toString(),
          'user_id': userID
        }),
      ).timeout(const Duration(seconds: 10));
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse["code"] == 1) {
          return oK;
        } else {
          return serverError;
        }
      }
    } catch (e) {
      print(e);
      return serverError;
    }
  }

  //sign ups are used to add users/benefectors as well
  static Future<dynamic> signUpUser(String email, String password, String fName,
      String lName, String disablity) async {
    try {
      Response response = await post(
        Uri.parse(url + "/register.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'name': fName + ' ' + lName,
          'user_type': '1',
          'disablity': disablity,
        }),
      ).timeout(const Duration(seconds: 10));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = Map.from(jsonDecode(response.body));
        if (jsonMap["code"] == 1) {
          return jsonMap;
        } else {
          return jsonMap["message"] as String;
        }
      } else {
        return serverError;
      }
    } catch (e) {
      return serverError;
    }
  }

  static Future<dynamic> signUpBenefactor(
      String email, String password, String fName, String lName) async {
    try {
      Response response = await post(
        Uri.parse(url + "/register.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'name': fName + " " + lName,
          'user_type': '2'
        }),
      ).timeout(const Duration(seconds: 9));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = Map.from(jsonDecode(response.body));
        if (jsonMap["code"] == 1) {
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
      Response response =
          await post(Uri.parse(url + "/show_watting_disability_users.php"))
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

  static Future<dynamic> getBenefactorsList() async {
    try {
      Response response =
          await post(Uri.parse(url + "/show_watting_benefactors.php"))
              .timeout(const Duration(seconds: 9));
      print(response.statusCode);
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

  //will change with backend api changes
  static Future<dynamic> approve(String userID, String order) async {
    try {
      Response response = await post(
        Uri.parse(url + "/approve_reject_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'user_id': userID, "order": order}),
      ).timeout(const Duration(seconds: 9));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = Map.from(jsonDecode(response.body));
        if (jsonMap["code"] == 1) {
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
        Uri.parse(url + "/delete_user.php"),
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

  static Future<dynamic> getRequest(int userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/delete_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'user_id': userID}),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonMap = jsonDecode(response.body);
        return jsonMap;
      } else {
        return serverError;
      }
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> setServices(
      int userID, String list, String content) async {
    try {
      Response response = await post(
        Uri.parse(url + "/delete_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_id': userID,
          'services': list,
          'content': content
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return jsonMap["message"];
      } else {
        return serverError;
      }
    } catch (_) {
      return serverError;
    }
  }

  static Future<String> approveRequest(
      int userID, int serviceID, bool approve) async {
    try {
      Response response = await post(
        Uri.parse(url + "/delete_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_id': userID,
          'service_id': serviceID,
          "order": approve ? 1 : 0
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        return map["message"];
      } else {
        return serverError;
      }
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> deleteBenefactor(String userID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/delete_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'user_id': userID}),
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
        Uri.parse(url + "/login.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, dynamic>{'email': email, 'password': password}),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = Map.from(jsonDecode(response.body));
        //account type is user
        if (jsonMap["code"] != -1) {
          return Map<String, dynamic>.from(jsonMap);
        } else {
          print(jsonMap["message"]);
          return jsonMap["message"];
        }
      } else {
        return serverError;
      }
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> sendMessege(
      int senderID, int receiverID, String message) async {
    try {
      Response response = await post(
        Uri.parse(url + "/send_message.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          's_id': senderID.toString(),
          'r_id': receiverID.toString(),
          'content': message
        }),
      );
      if (response.statusCode == 200) {
        final responseMap = json.decode(response.body);

        if (responseMap[0]["code"] != -1) {
          print(responseMap);
          return responseMap;
        }
      } else {
        return serverError;
      }
    } catch (_) {
      return serverError;
    }
  }

  static Future<dynamic> readMessages(int senderID, int receiverID) async {
    try {
      Response response = await post(
        Uri.parse(url + "/read_all_messages.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          's_id': senderID.toString(),
          'r_id': receiverID.toString()
        }),
      ).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final responseMap = json.decode(response.body);

        if (responseMap.runtimeType == List) {
          if (responseMap[0]["code"] != -1) {
            return responseMap;
          }
        } else if (responseMap["code"] == 0) {
          return responseMap;
        }
        return "User not found";
      }
      return serverError;
    } catch (e) {
      print(e);
      return serverError;
    }
  }

  static Future<dynamic> orderFood(
      String userID, String cardID, List<String> order) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'card_id': cardID,
          'order': order.toString()
        }),
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
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

  static Future<dynamic> requestDelivery(
      String userID, String from, String object) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_id': userID,
          'from': from,
          'object': object
        }),
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
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
