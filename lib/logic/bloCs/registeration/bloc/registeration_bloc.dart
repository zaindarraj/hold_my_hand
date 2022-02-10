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
      } else if (event is SignInAdmin) {
        emit(Loading());
        await flutterSecureStorage.setAll(event.email, event.password, "0");
        emit(SignedIn(accountType: "admin"));
      } else if (event is SignUp) {
        emit(Loading());
        String? response;

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

        if (response == oK) {
          await flutterSecureStorage.setAll(event.email, event.password, "0");
          emit(SignedIn());
        } else {
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
                  emit(SignedIn(accountType: "admin"));
                } else {
                  dynamic response = await API.signIn(
                      map["email"] as String, map["password"] as String);

                  if (response is Map) {
                    emit(SignedIn(accountType: response["accountType"]));
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
                emit(SignedIn(accountType: "admin"));
              }
            } else {
              dynamic response = await API.signIn(
                  map["email"] as String, map["password"] as String);

              if (response is Map) {
                emit(SignedIn(accountType: response["accountType"]));
              } else {
                emit(ErrorState(message: response));
              }
            }
          } else {
            emit(RegisterationInitial());
          }
        }
      } else if (event is SignIn) {
        dynamic response = await API.signIn(event.email, event.password);
        if (response is String) {
        } else {
          await flutterSecureStorage.setAll(event.email, event.password, "0");
          emit(SignedIn(accountType: response["accountType"]));
        }
      }
    });
  }
}
