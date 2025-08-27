// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/common/data_formatter.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/providers/transaction_provider.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/user/trade/crypto_transaction_details.dart';
import 'package:zeelpay/screens/widgets/processing.dart';
import 'package:zeelpay/screens/widgets/sent.dart';
import 'package:zeelpay/services/http_service.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

Future buyCrypto({
  required BuildContext context,
  required dynamic tokenAmount,
  required String currency,
  required String pin,
  required WidgetRef ref,
  required double amount,
  required String network,
  required String receivingAddress,
}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;

    var response = await httpService.postRequest(
      Endpoints.cryptoBuy,
      data: {
        "currency": currency,
        "amount": amount,
        "network": network,
        "receiving_address": receivingAddress.trim(),
        "pin": pin
      },
      headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      },
    );

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      ref.refresh(fetchUserInformationProvider);
      ref.refresh(fetchUserTransactionsProvider());
      var data = jsonDecode(response.data);
      print(data);
      Go.to(SentSuccessfully(
        title: "Done",
        body: data["message"],
        nextPage: CryptoTransactionDetails(
            cryptoCoinLogo: returnCoinLogo(currency),
            amount: "₦${returnAmount(data["data"]["amount"])}",
            transactionID: data["data"]["reference"],
            dateAndTime: formartDateTime(data["data"]["date"]),
            usdAmount: "\$${returnUsdAmount(amount)}",
            tokenAmount: "$tokenAmount $currency",
            token: network,
            type: data["data"]["type"],
            usdtAddress: data["data"]["beneficiary"],
            fee: "₦${returnAmount(data["data"]["fee"])}"),
      ));
    }
  } on DioException catch (e) {
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

//sell crypto
Future sellCrypto({
  required BuildContext context,
  required String currency,
  required dynamic tokenAmount,
  required WidgetRef ref,
  required String network,
  required double volume,
}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;

    var response = await httpService.postRequest(
      Endpoints.cryptoSell,
      data: {"currency": currency, "network": network, "volume": volume},
      headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      },
    );

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      ref.refresh(fetchUserInformationProvider);
      ref.refresh(fetchUserTransactionsProvider());
      var data = jsonDecode(response.data);
      Go.to(ProcesssingScreen(
        title: "Processing",
        body: data["message"],
        nextPage: CryptoTransactionDetails(
            cryptoCoinLogo: returnCoinLogo(currency),
            amount: "₦${returnAmount(data["data"]["receive"])}",
            transactionID: data["data"]["reference"],
            dateAndTime: formartDateTime(DateTime.now().toString()),
            usdAmount: "\$${returnAmount(data["data"]["amount"])}",
            tokenAmount: "$tokenAmount $currency",
            token: currency,
            type: "Sell Crypto",
            usdtAddress: data["data"]["address"],
            fee: "₦${returnAmount(data["data"]["fee"])}"),
      ));
    }
  } on DioException catch (e) {
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

returnCoinLogo(String currency) {
  if (currency.toLowerCase() == "usdt") {
    return ZeelPng.tether;
  } else if (currency.toLowerCase() == "btc") {
    return ZeelPng.bitcoin;
  } else if (currency.toLowerCase() == "eth") {
    return ZeelPng.ethereum;
  } else {
    return ZeelPng.tether;
  }
}
