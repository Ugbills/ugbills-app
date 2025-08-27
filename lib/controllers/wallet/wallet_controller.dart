// ignore_for_file: avoid_build_context_in_providers
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/screens/user/pay/fund/coupon/coupon_completed.dart';

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
        endpoint: Endpoints.redeemCoupon,
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
}
