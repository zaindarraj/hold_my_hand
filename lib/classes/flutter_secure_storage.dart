import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:http/http.dart';

class SecureStorage {
  late Map<String, String> map;
  AndroidOptions aOptions = const AndroidOptions(
      encryptedSharedPreferences: true, resetOnError: true);
  late FlutterSecureStorage flutterSecureStorage;
  SecureStorage() {
    flutterSecureStorage = FlutterSecureStorage(aOptions: aOptions);
  }

  Future<void> setAll(String email, String password, String state) async {
    await flutterSecureStorage.write(key: "email", value: email);
    await flutterSecureStorage.write(key: "password", value: password);
    await flutterSecureStorage.write(key: "isLoggedOut", value: state);
  }
 Future<void> setState(String state) async {
    await flutterSecureStorage.write(key: "isLoggedOut", value: state);
  }

   Future<void> setEmail(String email) async {
    await flutterSecureStorage.write(key: "email", value: email);
    
  }
   Future<void> setPassword(String password) async {
    await flutterSecureStorage.write(key: "password", value: password);
  }

  Future<bool> storageEmpty() async {
    map = await flutterSecureStorage.readAll();
    if (map.isEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> isLoggedOut() async {
    map = await flutterSecureStorage.readAll();
    if (map["isLoggedOut"] == "0") {
      return false;
    } else {
      return true;
    }
  }

  

  Future<Map<String, String>> get() async {
    map = await flutterSecureStorage.readAll();
    return map;
  }
}
