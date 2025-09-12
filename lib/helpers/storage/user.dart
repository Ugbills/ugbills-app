import 'package:get_storage/get_storage.dart';

class UserStorage {
  final _storage = GetStorage();

  update(String value) {
    _storage.write('user_id', value);
  }

  updateEmail(String value) {
    _storage.write('email', value);
  }

  String getEmail() {
    var value = _storage.read('email');
    if (value == null) {
      _storage.write('email', "");
      return "";
    } else {
      return value;
    }
  }

  updatePin(String value) {
    _storage.write('pin', value);
  }

  String getPin() {
    var value = _storage.read('pin');
    if (value == null) {
      _storage.write('pin', "");
      return "";
    } else {
      return value;
    }
  }

  updateBiometrics(bool value) {
    _storage.write('biometrics', value);
  }

  bool getBiometrics() {
    var value = _storage.read('biometrics');
    if (value == null) {
      _storage.write('biometrics', false);
      return false;
    } else {
      return value;
    }
  }

  String get() {
    var value = _storage.read('user_id');
    if (value == null) {
      _storage.write('user_id', "");
      return "";
    } else {
      return value;
    }
  }
}
