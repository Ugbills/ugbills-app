// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
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

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

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
      Endpoints.data,
      data: {
        "receipient": phoneNumber,
        "plan_id": planId,
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      await refreshUser(ref: ref);
      var data = jsonDecode(response.data);

      var transaction = data["data"];
      print(transaction);
      Go.to(SentSuccessfully(
        title: "Completed",
        body: data["message"],
        nextPage: DataTransactionDetails(
          networkLogo: getNetWorkIcon(transaction["network"]),
          dataPlan: transaction["plan_name"],
          amount: returnAmount(transaction["amount"]),
          transactionID: transaction["reference"],
          dateAndTime: formartDateTime(DateTime.now().toString()),
          phoneNumber: phoneNumber,
          serviceProvider: transaction["network"],
          fee: returnAmount(transaction["fee"]),
          note: data["message"],
        ),
      ));
    }
  } on DioException catch (e) {
    log(e.toString());
    ref.read(isLoadingProvider.notifier).state = false;

    if (e.response!.data != null) {
      var data = jsonDecode(e.response!.data);
      log(data["message"]);
      errorSnack(context, data["message"]);
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
