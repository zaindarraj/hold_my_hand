import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/classes/flutter_secure_storage.dart';
import 'package:hold_my_hand/classes/local_auth.dart';
import 'package:hold_my_hand/consts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
part 'registeration_event.dart';
part 'registeration_state.dart';

class RegisterationBloc extends Bloc<RegisterationEvent, RegisterationState> {
  SecureStorage flutterSecureStorage = SecureStorage();
  LocalAuth localAuthentication = LocalAuth();

  RegisterationBloc() : super(RegisterationInitial()) {
    on<RegisterationEvent>((event, emit) async {
      if (event is SignUp) {
        String response = await API.signUp(event.email, event.password);
        if (response == signedUpResponse) {
          await flutterSecureStorage.setAll(event.email, event.password, "0");
          emit(SignedIn());
        } else {
          emit(ErrorState(message: response));
        }
      }

      if (event is CheckBio) {
        if (await localAuthentication.bioAvailable()) {
          if (!await flutterSecureStorage.storageEmpty()) {
            if (!await flutterSecureStorage.isLoggedOut()) {
              if (await localAuthentication.auth()) {
                emit(Loading());
                Map<String, String> map = await flutterSecureStorage.get();
                String response = await API.signIn(
                    map["email"] as String, map["password"] as String);

                if (response == signedInResponse) {
                  emit(SignedIn());
                } else {
                  emit(ErrorState(message: response));
                }
              }
            }
          }
        }
        if (event is CheckFlutterStorage) {
          emit(Loading());
          if (await flutterSecureStorage.storageEmpty()) {
            emit(RegisterationInitial());
          } else {
            Map<String, String> map = await flutterSecureStorage.get();
            if (!await flutterSecureStorage.isLoggedOut()) {
              String response = await API.signIn(
                  map["email"] as String, map["password"] as String);
              if (response == signedInResponse) {
                emit(SignedIn());
              } else {
                emit(ErrorState(message: response));
              }
            }
          }
        }
      }
    });
  }
}
