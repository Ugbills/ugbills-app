// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/constants/api/mobile_endpoints.dart' hide Endpoints;
import 'package:ugbills/controllers/auth/auth_helper.dart';
import 'package:ugbills/controllers/bills/data_controller.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/airtime/airtime_transaction_details.dart';
import 'package:ugbills/screens/widgets/sent.dart';
import 'package:ugbills/services/http_service.dart';

part 'airtime_controller.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@riverpod
class AirtimeController extends _$AirtimeController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

  // buy method - updated for mobile API
  Future buy({
    required BuildContext context,
    required String phoneNumber,
    required String pin,
    required WidgetRef ref,
    required int amount,
    required String network,
  }) async {
    try {
      var token = await tokenStorage.getToken();

      ref.read(isLoadingProvider.notifier).state = true;

      var response = await httpService.postRequest(
        MobileEndpoints.airtime,
        data: {
          "beneficiary": phoneNumber,
          "amount": amount,
          "product_code": network,
          "pin": pin
        },
        headers: {"ZEEL-SECURE-KEY": token},
      );

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        await refreshUser(ref: ref);
        var data = jsonDecode(response.data);

        Go.to(SentSuccessfully(
          title: "Airtime Purchase Successful",
          body: data["msg"]?.toString() ??
              "Airtime purchase completed successfully",
          nextPage: AirtimeTransactionDetails(
            networkLogo: getNetWorkIcon(network),
            amount: returnAmount(amount),
            transactionID:
                data["transaction"]?["reference"]?.toString().toUpperCase() ??
                    '',
            dateAndTime: formartDateTime(DateTime.now().toString()),
            phoneNumber: phoneNumber,
            serviceProvider: network.toUpperCase(),
            fee: "0.00",
            note: data["msg"]?.toString() ?? "Airtime purchase completed",
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
        errorSnack(context, "Failed to purchase airtime");
      }
      log(e.toString());
      throw Exception(e);
    }
  }
}

// Keep the old function for backwards compatibility if needed

Future buyAirtime({
  required BuildContext context,
  required String phoneNumber,
  required String pin,
  required WidgetRef ref,
  required int amount,
  required String network,
}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;

    var response = await httpService.postRequest(
      MobileEndpoints.airtime,
      data: {
        "phone": phoneNumber,
        "amount": amount,
        "product_code": network,
        "pin": pin
      },
      headers: {"ZEEL-SECURE-KEY": token},
    );

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      await refreshUser(ref: ref);
      var data = jsonDecode(response.data);

      Go.to(SentSuccessfully(
        title: "Airtime Purchase Successful",
        body: data["msg"]?.toString() ??
            "Airtime purchase completed successfully",
        nextPage: AirtimeTransactionDetails(
          networkLogo: getNetWorkIcon(network),
          amount: returnAmount(amount),
          transactionID:
              data["transaction"]?["reference"]?.toString().toUpperCase() ?? '',
          dateAndTime: formartDateTime(DateTime.now().toString()),
          phoneNumber: phoneNumber,
          serviceProvider: network.toUpperCase(),
          fee: "10.00",
          note: data["msg"]?.toString() ?? "Airtime purchase completed",
        ),
      ));
    }
  } on DioException catch (e) {
    ref.read(isLoadingProvider.notifier).state = false;

    if (e.response?.data != null) {
      var data = jsonDecode(e.response!.data);
      log(data["msg"] ?? data["message"] ?? "Purchase failed");
      errorSnack(context, data["msg"] ?? data["message"] ?? "Purchase failed");
    } else {
      errorSnack(context, "Failed to purchase airtime");
    }
    log(e.toString());
    throw Exception(e);
  }
}

Future<Data?> startSwap({
  required String phoneNumber,
  required WidgetRef ref,
  required int amount,
  required String network,
}) async {
  try {
    ref.read(isLoadingProvider.notifier).state = true;
    var token = await tokenStorage.getToken();

    var response = await httpService.postRequest(
      Endpoints.swapInitiate,
      data: {"phone": phoneNumber, "network_id": network, "amount": amount},
      headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      },
    );
    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      var swap = SwapDetails.fromJson(data);
      return swap.data;
    }
  } on DioException catch (e) {
    ref.read(isLoadingProvider.notifier).state = false;
    log(e.toString());
    if (e.response!.data != null) {
      var data = jsonDecode(e.response!.data);
      log(data["message"]);
    }
    return null;
  }
  return null;
}

class SwapDetails {
  int? code;
  String? message;
  bool? success;
  Data? data;

  SwapDetails({this.code, this.message, this.success, this.data});

  SwapDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic receive;
  dynamic pay;
  String? sendTo;
  dynamic swapPercent;

  Data({this.receive, this.pay, this.sendTo, this.swapPercent});

  Data.fromJson(Map<String, dynamic> json) {
    receive = json['receive'];
    pay = json['pay'];
    sendTo = json['send_to'];
    swapPercent = json['swap_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receive'] = receive;
    data['pay'] = pay;
    data['send_to'] = sendTo;
    data['swap_percent'] = swapPercent;
    return data;
  }
}
