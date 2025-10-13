// ignore_for_file: use_build_context_synchronously, avoid_build_context_in_providers

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/controllers/auth/auth_helper.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/helpers/common/icon_helper.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/data/data_transaction_details.dart';
import 'package:ugbills/screens/widgets/sent.dart';
import 'package:ugbills/services/http_service.dart';

part 'sme_data_controller.g.dart';

var tokenStorage = TokenStorage();

var httpService = HttpService();

@riverpod
class SMEDataController extends _$SMEDataController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

  // buy method - updated for mobile API
  Future buy({
    required BuildContext context,
    required String phoneNumber,
    required String planId,
    required String dataPlan,
    required String amount,
    required String pin,
    required WidgetRef ref,
    required String network,
  }) async {
    try {
      var token = await tokenStorage.getToken();

      ref.read(isLoadingProvider.notifier).state = true;

      var response = await httpService.postRequest(
        MobileEndpoints.data,
        data: {
          "beneficiary": phoneNumber,
          "product_code": network,
          "variation_code": planId,
          "pin": pin
        },
        headers: {"ZEEL-SECURE-KEY": token},
      );

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        await refreshUser(ref: ref);
        var data = jsonDecode(response.data);

        Go.to(SentSuccessfully(
          title: "SME Data Purchase Successful",
          body: data["msg"]?.toString() ??
              "SME Data purchase completed successfully",
          nextPage: DataTransactionDetails(
            networkLogo: getNetWorkIcon(network),
            dataPlan: dataPlan,
            amount: returnAmount(
                int.parse(amount.replaceAll("NGN", "").replaceAll(",", ""))),
            transactionID:
                data["transaction"]?["reference"]?.toString().toUpperCase() ??
                    '',
            dateAndTime: formartDateTime(DateTime.now().toString()),
            phoneNumber: phoneNumber,
            serviceProvider: network.toUpperCase(),
            fee: "10.00",
            note: data["msg"]?.toString() ?? "SME Data purchase completed",
          ),
        ));
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;

      if (e.response?.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["msg"] ?? "Purchase failed");
        errorSnack(context, data["msg"] ?? "Purchase failed");
      } else {
        errorSnack(context, "Failed to purchase SME data");
      }

      throw Exception(e);
    }
  }
}
