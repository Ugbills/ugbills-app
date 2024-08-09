import 'package:get_storage/get_storage.dart';

class UserStorage {
  final _storage = GetStorage();

  update(String value) {
    _storage.write('user_id', value);
  }

  String get() {
    var value = _storage.read('user_id');
    if (value == null) {
      _storage.write('user_d', "");
      return "";
    } else {
      return value;
    }
  }
}
