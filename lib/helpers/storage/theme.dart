import 'package:get_storage/get_storage.dart';

class ThemeStorage {
  final _storage = GetStorage();

  update(bool value) {
    _storage.write('darkmode', value);
  }

  bool get() {
    var value = _storage.read('darkmode');
    if (value == null) {
      _storage.write('darkmode', false);
      return false;
    } else {
      return value;
    }
  }
}
