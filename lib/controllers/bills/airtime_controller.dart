// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/controllers/auth/auth_helper.dart';
import 'package:zeelpay/controllers/bills/data_controller.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/common/data_formatter.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/user/pay/airtime/airtime_transaction_details.dart';
import 'package:zeelpay/screens/widgets/sent.dart';
import 'package:zeelpay/services/http_service.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

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
      Endpoints.airtime,
      data: {
        "phone": phoneNumber,
        "amount": amount,
        "network_id": network,
        "pin": pin
      },
      headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      },
    );

    ref.read(isLoadingProvider.notifier).state = false;

    print(response.data);

    if (response.statusCode == 200) {
      await refreshUser(ref: ref);
      var data = jsonDecode(response.data);
      print(data);
      Go.to(SentSuccessfully(
        title: "Completed",
        body: data["message"],
        nextPage: AirtimeTransactionDetails(
          networkLogo: getNetWorkIcon(data["data"]["network"].toString()),
          amount: returnAmount(amount),
          transactionID: data["data"]["reference"].toString().toUpperCase(),
          dateAndTime: formartDateTime(data["data"]["date"].toString()),
          phoneNumber: data["data"]["phone_number"].toString(),
          serviceProvider: data["data"]["network"].toString().toUpperCase(),
          fee: returnAmount(data["data"]["fee"]),
          note: data["data"]["note"].toString(),
        ),
      ));
    }
  } on DioException catch (e) {
    print(e);
    ref.read(isLoadingProvider.notifier).state = false;
    if (e.response!.data != null) {
      var data = jsonDecode(e.response!.data);
      log(data["message"]);
      errorSnack(context, data["message"]);
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
