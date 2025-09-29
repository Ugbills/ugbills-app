// ignore_for_file: avoid_build_context_in_providers, use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart' hide Endpoints;
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/controllers/auth/auth_helper.dart';
import 'package:ugbills/controllers/transfer/transfer_controller.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/tv/tv_transaction_details.dart';
import 'package:ugbills/screens/widgets/sent.dart';

part 'tv_controller.g.dart';

final ApiRepository api = ApiRepository();

@riverpod
class TvController extends _$TvController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

  Future<CustomerInfoModel?> validateName(
      {required String customerId,
      required String productID,
      required WidgetRef ref}) async {
    try {
      ref.read(isValidatingProvider.notifier).state = true;

      var token = await tokenStorage.getToken();
      var response = await httpService.getRequest(Endpoints.cableValidate,
          headers: {
            'X-Forwarded-For': '1234',
            'Y-decryption-key': '1234',
            "ZEEL-SECURE-KEY": token
          },
          queryParameters: {
            "product_id": productID,
            "iuc_number": customerId,
          },
          responseType: ResponseType.plain);

      ref.read(isValidatingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        log(response.data.toString());

        var data = jsonDecode(response.data);

        var info = CustomerInfoModel.fromJson(data["data"]);

        return info;
      }
    } on DioException catch (e) {
      ref.read(isValidatingProvider.notifier).state = false;
      log(e.toString());
      throw Exception(e);
    }
    return null;
  }

// buy method - updated for mobile API
  Future buy({
    required String customerId,
    required String productID,
    required String planId,
    required String pin,
    required String cableName,
    required String amount,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;

      var token = await tokenStorage.getToken();
      var response =
          await httpService.postRequest(MobileEndpoints.cable, headers: {
        "ZEEL-SECURE-KEY": token
      }, data: {
        "pin": pin,
        "product_code": productID,
        "variation_code": planId,
        "smartcard": customerId
      });

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        await refreshUser(ref: ref);
        log(response.data.toString());

        var data = jsonDecode(response.data);

        Go.to(SentSuccessfully(
          title: "Cable Subscription Successful",
          body: data["msg"]?.toString() ??
              "Cable subscription completed successfully",
          nextPage: TvTransactionDetails(
            tvLogo: ZeelSvg.cable,
            amount: returnAmount(double.parse(amount).toInt()),
            transactionID:
                data["transaction"]?["reference"]?.toString().toUpperCase() ??
                    '',
            dateAndTime: formartDateTime(DateTime.now().toString()),
            smartcardNumber: customerId,
            serviceProvider: cableName.toUpperCase(),
            plan: "Cable Subscription",
            fee: "0.00",
          ),
        ));
      }
    } on DioException catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;

      if (e.response?.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["errors"][0] ?? data["msg"] ?? "Purchase failed");
        errorSnack(
            context, data["errors"][0] ?? data["msg"] ?? "Purchase failed");
      } else {
        errorSnack(context, "Failed to purchase cable subscription");
      }
      log(e.toString());
      throw Exception(e);
    }
    return null;
  }
}

class CustomerInfoModel {
  String? name;

  CustomerInfoModel({this.name});

  CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
