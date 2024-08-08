import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/repository/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository = AuthRepository();

  Future<void> login(
      {required String email,
      required String password,
      required WidgetRef ref,
      required BuildContext context,
      required GlobalKey<FormState> formkey}) async {
    if (formkey.currentState!.validate()) {
      await _authRepository.login(email, password, ref, context);
    }
  }

  Future<void> forgotPassword(
      {required String email,
      required WidgetRef ref,
      required GlobalKey<FormState> formkey,
      required BuildContext context}) async {
    if (formkey.currentState!.validate()) {
      await _authRepository.forgotPassword(email, ref, context);
    }
  }
}
