import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/storage/theme.dart';

final themeModeProvider = StateProvider.autoDispose<ThemeMode>((ref) {
  if (ThemeStorage().get()) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
});
