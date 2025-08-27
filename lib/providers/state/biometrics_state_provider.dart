import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/helpers/storage/user.dart';

final biometricsProvider = StateProvider.autoDispose<bool>((ref) {
  return UserStorage().getBiometrics();
});
