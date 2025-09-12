// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/card_provider.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/card/success_message.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/services/http_service.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

Future applyForCard(
    {required BuildContext context, required WidgetRef ref}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;
    var response = await httpService.postRequest(
      Endpoints.cardApply,
      headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      },
    );

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      log(data.toString());
      successSnack(context, data["message"]);
      ref.refresh(canCreateCardProvider);
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

Future freezeCard(
    {required BuildContext context,
    required String pin,
    required String cardId,
    required WidgetRef ref}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;
    var response = await httpService.postRequest(Endpoints.cardFreeze,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        data: {
          "pin": pin,
          "card_id": cardId
        });

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      log(data.toString());
      successSnack(context, data["message"]);
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

Future unfreezeCard(
    {required BuildContext context,
    required String pin,
    required String cardId,
    required WidgetRef ref}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;
    var response = await httpService.postRequest(Endpoints.cardUnFreeze,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        data: {
          "pin": pin,
          "card_id": cardId
        });

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      log(data.toString());
      successSnack(context, data["message"]);
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

Future fundCard(
    {required BuildContext context,
    required String pin,
    required dynamic amount,
    required String cardId,
    required WidgetRef ref}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;
    var response = await httpService.postRequest(Endpoints.cardFund, headers: {
      'X-Forwarded-For': '1234',
      'Y-decryption-key': '1234',
      "ZEEL-SECURE-KEY": token
    }, data: {
      "pin": pin,
      "amount": amount,
      "card_id": cardId
    });

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      log(data.toString());
      Go.to(SuccessMessage(
        title: "Card Funded",
        body: data["message"],
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

Future withdrawCard(
    {required BuildContext context,
    required String pin,
    required dynamic amount,
    required String cardId,
    required WidgetRef ref}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;
    var response = await httpService.postRequest(Endpoints.cardWithdraw,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        data: {
          "pin": pin,
          "amount": amount,
          "card_id": cardId
        });

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      log(data.toString());
      Go.to(SuccessMessage(
        title: "Card Withdrawal",
        body: data["message"],
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

Future createCard(
    {required BuildContext context,
    required String cardType,
    required String pin,
    required WidgetRef ref}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;
    var response =
        await httpService.postRequest(Endpoints.cardCreate, headers: {
      'X-Forwarded-For': '1234',
      'Y-decryption-key': '1234',
      "ZEEL-SECURE-KEY": token
    }, data: {
      "card_type": cardType,
      "pin": pin,
    });

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      log(data.toString());
      ref.refresh(canCreateCardProvider);
      ref.read(currentScreenProvider.notifier).state = 3;
      Go.to(const UserScreen());
      successSnack(context, data["message"]);
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
