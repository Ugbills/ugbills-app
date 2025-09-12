// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/controllers/auth/auth_helper.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/giftcard/giftcard_transaction_details.dart';
import 'package:ugbills/screens/widgets/sent.dart';
import 'package:ugbills/services/http_service.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

Future buyGiftCard({
  required BuildContext context,
  required String productId,
  required String productName,
  required String brandId,
  required String countryCode,
  required int quantity,
  required String pin,
  required WidgetRef ref,
  required String iconUrl,
  required dynamic unitPrice,
}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;

    var response = await httpService.postRequest(
      Endpoints.giftCardBuy,
      data: {
        "productId": productId,
        "brandId": brandId,
        "countryCode": countryCode,
        "quantity": quantity,
        "pin": pin,
        "iconUrl": iconUrl,
        "unitPrice": unitPrice
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
      log(transaction.toString());
      Go.to(SentSuccessfully(
        title: "Gift Card is Coming!",
        body: data["message"],
        nextPage: GiftcardTransactionDetails(
          giftcardLogo: iconUrl,
          amount: returnAmount(transaction["ngn_amount"]),
          transactionID: transaction["reference"].toString(),
          dateAndTime: formartDateTime(transaction["date"]),
          usdAmount: returnAmount(transaction["usd_amount"]),
          card: productName,
          fee: returnAmount(transaction["fee"]),
          note: 'None',
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
