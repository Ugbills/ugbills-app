// ignore_for_file: avoid_build_context_in_providers
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zeelpay/repository/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null); // Initial state
  }

  final AuthRepository _authRepository = AuthRepository();

  Future<String?> login(
      {required String email,
      required String password,
      required WidgetRef ref,
      required GlobalKey<FormState> formkey,
      required BuildContext context}) async {
    if (formkey.currentState!.validate()) {
      return await _authRepository.login(email, password, ref, context);
    }
    return null;
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
