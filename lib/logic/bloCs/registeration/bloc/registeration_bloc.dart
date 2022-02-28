import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/classes/flutter_secure_storage.dart';
import 'package:hold_my_hand/classes/local_auth.dart';

import '../../../../consts.dart';
part 'registeration_state.dart';
part 'registeration_event.dart';

class RegisterationBloc extends Bloc<RegisterationEvent, RegisterationState> {
  SecureStorage flutterSecureStorage = SecureStorage();
  LocalAuth localAuthentication = LocalAuth();

  RegisterationBloc() : super(RegisterationInitial()) {
    on<RegisterationEvent>((event, emit) async {
      if (event is SignOut) {
        await flutterSecureStorage.setState("1");
        emit(RegisterationInitial());
      } else if (event is SignInAdmin) {
        emit(Loading());
        await flutterSecureStorage.setAll(event.email, event.password, "0");
        emit(Admin());
      } else if (event is SignUp) {
        emit(Loading());
        dynamic response;
        if (event.accountType == 'disabled person') {
          response = await API.signUpUser(event.email, event.password,
              event.fName, event.lName, event.disabilityType as String);
        } else {
          response = await API.signUpBenefector(
            event.email,
            event.password,
            event.fName,
            event.lName,
          );
        }
        if(response.runtimeType != String){
          await flutterSecureStorage.setAll(event.email, event.password, "0");
          emit(User(data: response["data"]));
        }
         else {
          emit(ErrorState(message: response));
        }
      } else if (event is CheckBio) {
        if (!await flutterSecureStorage.storageEmpty()) {
          if (await flutterSecureStorage.isLoggedOut()) {
            if (await localAuthentication.bioAvailable()) {
              if (await localAuthentication.auth()) {
                emit(Loading());
                Map<String, String> map = await flutterSecureStorage.get();
                if (map["email"] == adminEmail &&
                    map["password"] == adminPassword) {
                  flutterSecureStorage.setState("0");
                  emit(Admin());
                } else {
                  dynamic response = await API.signIn(
                      map["email"] as String, map["password"] as String);

                  if (response is Map) {
                    Map<String, dynamic> data = response["data"];
                    await flutterSecureStorage.setAll(
                        data["email"], data["password"], "0");
                    String accountType = response["code"];
                    if (accountType == "1") {
                      emit(User(data: response["data"]));
                    } else if (accountType == "2") {
                      emit(Benefector(data: response["data"]));
                    }
                  } else {
                    emit(ErrorState(message: response));
                  }
                }
              }
            }
          }
        }
      } else if (event is CheckFlutterStorage) {
        emit(Loading());
        if (await flutterSecureStorage.storageEmpty()) {
          emit(RegisterationInitial());
        } else {
          Map<String, String> map = await flutterSecureStorage.get();
          if (!await flutterSecureStorage.isLoggedOut()) {
            if (map["email"] == adminEmail &&
                map["password"] == adminPassword) {
              if (map["isLoggedOut"] == "0") {
                emit(Admin());
              }
            } else {
              dynamic response = await API.signIn(
                  map["email"] as String, map["password"] as String);

              if (response is Map) {
                await flutterSecureStorage.setState("0");
                String accountType = response["code"];
                if (accountType == "1") {
                  emit(User(data: response["data"]));
                } else if (accountType == "2") {
                  emit(Benefector(data: response["data"]));
                }
              } else {
                emit(ErrorState(message: response));
              }
            }
          } else {
            emit(RegisterationInitial());
          }
        }
      } else if (event is SignIn) {
        emit(Loading());
        dynamic response = await API.signIn(event.email, event.password);
        if (response is String) {
          emit(ErrorState(message: response));
        } else {
          await flutterSecureStorage.setAll(event.email, event.password, "0");
          String accountType = response["code"];
          if (accountType == "1") {
            emit(User(data: response["data"]));
          } else if (accountType == "2") {
            emit(Benefector(data: response["data"]));
          }
        }
      }
    });
  }
}
