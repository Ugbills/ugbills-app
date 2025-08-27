import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final isValidatingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
