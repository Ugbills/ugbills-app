// ignore_for_file: use_build_context_synchronously, avoid_build_context_in_providers

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/constants/assets/svg.dart';
import 'package:zeelpay/controllers/transfer/model.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/user/pay/send/bank_transaction_details.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/screens/widgets/sent.dart';
import 'package:zeelpay/services/http_service.dart';

part 'transfer_controller.g.dart';

final ApiRepository api = ApiRepository();

final TokenStorage tokenStorage = TokenStorage();
final HttpService httpService = HttpService();

@riverpod
class TransferController extends _$TransferController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

  //get fetchpackages
  Future<AccountInfoModel?> validateAccount(
      {required String accountNumber,
      required String bankCode,
      required TextEditingController accountNameController}) async {
    try {
      var token = await tokenStorage.getToken();
      var response = await httpService
          .postRequest(Endpoints.transferBankValidate, headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      }, data: {
        "account_number": accountNumber,
        "bank_code": bankCode,
      });

      if (response.statusCode == 200) {
        log(response.data);

        var data = jsonDecode(response.data);

        var info = AccountInfoModel.fromJson(data["data"]);

        return info;
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return null;
  }

  Future transfer({
    required BuildContext context,
    required String sessionId,
    required String note,
    required String pin,
    required WidgetRef ref,
    required double amount,
    required String bankName,
    required String bankCode,
    required String accountName,
    required String accountNumber,
  }) async {
    try {
      var token = await tokenStorage.getToken();

      ref.read(isLoadingProvider.notifier).state = true;

      var request = {
        "pin": pin,
        "amount": amount,
        "narration": note,
        "name_enquiry_id": sessionId,
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_code": bankCode,
        "bank_name": bankName
      };

      print(request);

      var response = await httpService.postRequest(
        Endpoints.transferInitiate,
        data: request,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
      );

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        print(data);
        Go.to(SentSuccessfully(
          title: "Sent",
          body: data["message"],
          nextPage: BankTransactionDetails(
            bankLogo: ZeelSvg.money,
            sessionId: data["data"]["session_id"],
            amount: "₦$amount",
            transactionID: data["data"]["reference"],
            dateAndTime: data["data"]["date"],
            bankName: bankName,
            accountName: accountName,
            accountNumber: accountNumber,
            fee: "₦${data["data"]["fee"]}",
            note: data["data"]["remark"],
          ),
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
}

//get fetchpackages
Future<ZeePayInfo?> validateZeelpayAccount({required String username}) async {
  try {
    var token = await tokenStorage.getToken();
    var response =
        await httpService.getRequest(Endpoints.fundingValidate, headers: {
      'Y-decryption-key': '1234',
      "ZEEL-SECURE-KEY": token
    }, queryParameters: {
      "username": username,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      log(response.data.toString());

      var data = response.data;

      var info = ZeePayInfo.fromJson(data);

      return info;
    }
  } on DioException catch (e) {
    log(e.toString());
    return null;
  }
  return null;
}

Future transferZeelPay({
  required BuildContext context,
  required String note,
  required String pin,
  required WidgetRef ref,
  required double amount,
  required String avatar,
  required String username,
}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;

    var request = {
      "pin": pin,
      "amount": amount,
      "receipient": username,
      "reason": note
    };

    var response = await httpService.postRequest(
      Endpoints.fundingInitiate,
      data: request,
      headers: {'Y-decryption-key': '1234', "ZEEL-SECURE-KEY": token},
    );

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.data);
      Go.to(SentSuccessfully(
        title: "Sent",
        body: data["message"],
        nextPage: BankTransactionDetails(
          bankLogo: avatar,
          sessionId: "",
          amount: "₦${returnAmount(data["data"]["amount"])}",
          transactionID: data["data"]["reference"],
          dateAndTime: data["data"]["date"],
          bankName: "ZeelPay",
          accountName: data["data"]["full_name"],
          accountNumber: "",
          fee: "₦${returnAmount(data["data"]["fee"])}",
          note: data["data"]["note"],
        ),
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

Future confirmTransfer(
    {required BuildContext context,
    required String reference,
    required WidgetRef ref}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;

    var response = await httpService.getRequest(
      "${Endpoints.oneTimeAccount}/$reference",
      headers: {'Y-decryption-key': '1234', "ZEEL-SECURE-KEY": token},
    );

    print(response.data);

    ref.read(isLoadingProvider.notifier).state = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.data;

      if ((data["data"]["paid"])) {
        Go.to(SentSuccessfully(
          title: "Sent",
          body: data["message"],
          nextPage: const UserScreen(),
        ));
      } else {
        print("Transaction not completed");
        errorSnack(context, "Transaction not completed");
      }
    }
  } on DioException catch (e) {
    ref.read(isLoadingProvider.notifier).state = false;
    if (e.response!.data != null) {
      var data = e.response!.data;
      log(data["message"]);
      errorSnack(context, data["message"]);
    }
    log(e.toString());
    throw Exception(e);
  }
}
