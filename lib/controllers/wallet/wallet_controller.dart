// ignore_for_file: avoid_build_context_in_providers
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart' as WebEndpoints;
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/fund/coupon/coupon_completed.dart';
import 'package:ugbills/services/http_service.dart';

part 'wallet_controller.g.dart';

final ApiRepository api = ApiRepository();

@riverpod
class WalletController extends _$WalletController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

  //redeem coupon

  Future<void> redeemCoupon(
      {required String code, required BuildContext context}) async {
    await api.handleRequest(
        endpoint: WebEndpoints.Endpoints.redeemCoupon,
        auth: true,
        requestType: RequestType.post,
        data: {
          'coupon': code,
        },
        onSuccess: (data) async {
          print(data);
          Go.to(CouponCompleted(
            message: data["message"],
          ));
        },
        onError: (message) async {
          errorSnack(context, message);

          log(message);
        });
  }

  // Log deposit request using mobile API
  Future<void> logDeposit({
    required double amount,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;

      var tokenStorage = TokenStorage();
      var httpService = HttpService();
      var token = await tokenStorage.getToken();

      var response = await httpService.postRequest(
        MobileEndpoints.deposit,
        headers: {"ZEEL-SECURE-KEY": token},
        data: {"amount": amount},
      );

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        successSnack(
            context, data["msg"] ?? "Deposit request logged successfully");

        Go.to(CouponCompleted(
          message: data["msg"] ??
              "Your deposit request has been successfully logged.",
        ));
      }
    } on DioException catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;

      if (e.response?.data != null) {
        var errorData = jsonDecode(e.response!.data);
        errorSnack(context, errorData["message"] ?? "Deposit request failed");
      } else {
        errorSnack(context, "Network error occurred");
      }

      log('Deposit error: ${e.toString()}');
    }
  }
}
