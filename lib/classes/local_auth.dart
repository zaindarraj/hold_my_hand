import 'package:local_auth/local_auth.dart';

class LocalAuth {
  LocalAuthentication localAuthentication = LocalAuthentication();

  Future<bool> bioAvailable() async {
    if (await localAuthentication.isDeviceSupported()) {
      if (await localAuthentication.canCheckBiometrics) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> auth() async {
    return await localAuthentication.authenticate(
        localizedReason: "Authenticate to sign in", biometricOnly: true);
  }
}
