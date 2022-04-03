import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

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

  static Future<List<Map<String, dynamic>>?> getNearbyUsers(
      String benID) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': benID,
        }),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonList = jsonDecode(response.body);
        return jsonList;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<String> addCenter(String center) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'center': center,
        }),
      );
      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        if (jsonMap["code"] == "1") {
          return "Center added succefully.";
        }
      }
      return "Center not added, please try again.";
    } catch (_) {
      return "Center not added, please try again.";
    }
  }

  static Future<String> deleteCener(String centerID) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'id': centerID}),
      );
      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        if (jsonMap["code"] == "1") {
          return "Center deleted succefully.";
        }
      }
      return "Center not deleted, please try again.";
    } catch (_) {
      return "Center not deleted, please try again.";
    }
  }

  static Future<void> approveRequest(String benID, String ID) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'benID': benID, 'serviceID': ID}),
      );
    } catch (_) {}
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

        if (jsonMap["code"] == "1") {
          return oK;
        } else {
          return serverError;
        }
      }
      return serverError;
    } catch (_) {
      return serverError;
    }
  }

  static Future<String> medicalAdvice(String userID, String injury) async {
    try {
      Response response = await post(
        Uri.parse(url + "/delete_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': userID,
          'injury': injury,
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

  static Future<String> bookAppointment(
      String userID, String appointment, String date) async {
    try {
      Response response = await post(
        Uri.parse(url + "/delete_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': userID,
          'appointment': appointment,
          'date': date
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

  static Future<List<Map<String, dynamic>> ?> getCenters() async {
    try {
      Response response = await post(
        Uri.parse(url + "/delete_user.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{}),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonList = jsonDecode(response.body);
        return jsonList;
      } else {
        return null;
      }
    } catch (_) {
      return null;
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
      String userID, String cardID, String order) async {
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
