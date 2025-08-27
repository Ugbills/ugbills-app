import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  static Future<bool> authenticateUser() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();

    //status of authentication.
    bool isAuthenticated = false;
    //check if device supports biometrics authentication.
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    //check if user has enabled biometrics.
    //check
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(
                useErrorDialogs: true, biometricOnly: true, stickyAuth: true));
      } on PlatformException catch (e) {
        log(e.toString());
      }
    }
    return isAuthenticated;
  }
}
