import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/storage/user.dart';

final biometricsProvider = StateProvider.autoDispose<bool>((ref) {
  return UserStorage().getBiometrics();
});
