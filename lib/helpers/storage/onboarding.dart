import 'package:get_storage/get_storage.dart';

class OnboardingStorage {
  final _storage = GetStorage();

  update(bool value) {
    _storage.write('has_onboarded', value);
  }

  bool get() {
    var value = _storage.read('has_onboarded');
    if (value == null) {
      _storage.write('has_onboarded', false);
      return false;
    } else {
      return value;
    }
  }
}
