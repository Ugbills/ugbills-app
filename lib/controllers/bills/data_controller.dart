// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/controllers/auth/auth_helper.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/data/data_transaction_details.dart';
import 'package:ugbills/screens/widgets/sent.dart';
import 'package:ugbills/services/http_service.dart';

part 'data_controller.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@riverpod
class DataController extends _$DataController {
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
        MobileEndpoints.databundle,
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
          title: "Data Purchase Successful",
          body:
              data["msg"]?.toString() ?? "Data purchase completed successfully",
          nextPage: DataTransactionDetails(
            networkLogo: getNetWorkIcon(network),
            dataPlan: dataPlan,
            amount: returnAmount(int.parse(amount)),
            transactionID:
                data["transaction"]?["reference"]?.toString().toUpperCase() ??
                    '',
            dateAndTime: formartDateTime(DateTime.now().toString()),
            phoneNumber: phoneNumber,
            serviceProvider: network.toUpperCase(),
            fee: "0.00",
            note: data["msg"]?.toString() ?? "Data purchase completed",
          ),
        ));
      }
    } on DioException catch (e) {
      log(e.toString());
      ref.read(isLoadingProvider.notifier).state = false;

      if (e.response?.data != null) {
        var data = jsonDecode(e.response!.data);
        log(data["errors"][0] ?? data["msg"] ?? "Purchase failed");
        errorSnack(
            context, data["errors"][0] ?? data["msg"] ?? "Purchase failed");
      } else {
        errorSnack(context, "Failed to purchase data");
      }

      throw Exception(e);
    }
  }
}

// Keep the old function for backwards compatibility if needed

Future buyData({
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
      '/api/mobile/v1/databundle',
      data: {
        "phone": phoneNumber,
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
        title: "Data Purchase Successful",
        body: data["msg"]?.toString() ?? "Data purchase completed successfully",
        nextPage: DataTransactionDetails(
          networkLogo: getNetWorkIcon(network),
          dataPlan: dataPlan,
          amount: returnAmount(int.parse(amount)),
          transactionID:
              data["transaction"]?["reference"]?.toString().toUpperCase() ?? '',
          dateAndTime: formartDateTime(DateTime.now().toString()),
          phoneNumber: phoneNumber,
          serviceProvider: network.toUpperCase(),
          fee: "10.00",
          note: data["msg"]?.toString() ?? "Data purchase completed",
        ),
      ));
    }
  } on DioException catch (e) {
    log(e.toString());
    ref.read(isLoadingProvider.notifier).state = false;

    if (e.response?.data != null) {
      var data = jsonDecode(e.response!.data);
      log(data["msg"] ?? data["message"] ?? "Purchase failed");
      errorSnack(context, data["msg"] ?? data["message"] ?? "Purchase failed");
    } else {
      errorSnack(context, "Failed to purchase data");
    }

    throw Exception(e);
  }
}

getNetWorkIcon(String name) {
  if (name.toLowerCase().contains("mtn")) {
    return ZeelPng.mtn;
  } else if (name.toLowerCase().contains("glo")) {
    return ZeelPng.glo;
  } else if (name.toLowerCase().contains("airtel")) {
    return ZeelPng.airtel;
  } else {
    return ZeelPng.mobile;
  }
}

getCryptoIcon(String name) {
  if (name.toLowerCase().contains("bitcoin") ||
      name.toLowerCase().contains("btc")) {
    return ZeelPng.bitcoin;
  } else if (name.toLowerCase().contains("ethereum") ||
      name.toLowerCase().contains("eth")) {
    return ZeelPng.ethereum;
  } else if (name.toLowerCase().contains("usdt")) {
    return ZeelPng.tether;
  } else {
    return ZeelPng.sellCrypto;
  }
}
