// ignore_for_file: use_build_context_synchronously, avoid_build_context_in_providers

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart' as WebEndpoints;
import 'package:ugbills/constants/api/mobile_endpoints.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/controllers/transfer/model.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/send/bank_transaction_details.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/screens/widgets/sent.dart';
import 'package:ugbills/services/http_service.dart';

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

  //validate bank account using mobile endpoint
  Future<AccountInfoModel?> validateAccount(
      {required String accountNumber,
      required String bankCode,
      required TextEditingController accountNameController,
      required BuildContext context}) async {
    try {
      var token = await tokenStorage.getToken();
      var response =
          await httpService.postRequest(MobileEndpoints.validateBank, headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      }, data: {
        "account_number": accountNumber,
        "bank_code": bankCode,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Account validation response: ${response.data}');

        var data = jsonDecode(response.data);

        var info = AccountInfoModel.fromJson(data);
        return info;
      }
    } on DioException catch (e) {
      log('Account validation error: ${e.toString()}');
      if (e.response?.data != null) {
        var errorData = jsonDecode(e.response!.data);
        errorSnack(context, errorData['msg'] ?? 'Account validation failed');
      }
      return null;
    }
    return null;
  }

  Future transfer({
    required BuildContext context,
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
        "description": note,
        "account_number": accountNumber,
        "bank_code": bankCode,
      };

      log('Transfer request: $request');

      var response = await httpService.postRequest(
        MobileEndpoints.bankTransfer,
        data: request,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
      );

      ref.read(isLoadingProvider.notifier).state = false;

      log(response.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.data);
        log('Transfer response: $data');

        Go.to(SentSuccessfully(
          title: "Sent",
          body: data["msg"] ?? "Transfer completed successfully",
          nextPage: BankTransactionDetails(
            bankLogo: ZeelSvg.money,
            sessionId: "",
            amount: "₦$amount",
            transactionID: data["transaction"]["reference"] ?? "N/A",
            dateAndTime:
                data["transaction"]["created_at"] ?? DateTime.now().toString(),
            bankName: bankName,
            accountName: accountName,
            accountNumber: accountNumber,
            fee: "₦${data["transaction"]["charges"] ?? '50.00'}",
            note: note,
          ),
        ));
      }
    } on DioException catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;

      if (e.response?.data != null) {
        var data = jsonDecode(e.response!.data);
        String errorMessage = "Transfer failed";
        if (data["errors"] != null &&
            data["errors"] is List &&
            data["errors"].isNotEmpty) {
          errorMessage = data["errors"][0];
        } else if (data["msg"] != null) {
          errorMessage = data["msg"];
        }
        errorSnack(context, errorMessage);
      } else {
        log('Network error: ${e.toString()}');
        errorSnack(context, "Network error. Please try again.");
      }
      throw Exception(e);
    }
  }
}

//get fetchpackages
Future<ZeePayInfo?> validateUgBillsAccount(
    {required String username, required BuildContext context}) async {
  try {
    var token = await tokenStorage.getToken();
    var response =
        await httpService.postRequest(MobileEndpoints.validateWallet, headers: {
      'X-Forwarded-For': '1234',
      'Y-decryption-key': '1234',
      "ZEEL-SECURE-KEY": token
    }, data: {
      "username": username,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      log(response.data.toString());

      var data = jsonDecode(response.data);

      var info = ZeePayInfo.fromJson(data);

      return info;
    }
  } on DioException catch (e) {
    log(e.toString());
    if (e.response?.data != null) {
      var errorData = jsonDecode(e.response!.data);
      errorSnack(context, errorData['message'] ?? 'Account validation failed');
    }

    return null;
  }
  return null;
}

Future transferUgBills({
  required BuildContext context,
  required String note,
  required String pin,
  required WidgetRef ref,
  required double amount,
  required String username,
  required String fullname,
}) async {
  try {
    var token = await tokenStorage.getToken();

    ref.read(isLoadingProvider.notifier).state = true;

    var request = {
      "pin": pin,
      "amount": amount,
      "username": username,
      "description": note
    };

    var response = await httpService.postRequest(
      MobileEndpoints.walletTransfer,
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
      Go.to(SentSuccessfully(
        title: "Sent",
        body: data["msg"],
        nextPage: BankTransactionDetails(
          bankLogo: ZeelPng.avatar,
          sessionId: "",
          amount: "₦${returnAmount(amount)}",
          transactionID: data["transaction"]["reference"],
          dateAndTime: DateTime.now().toString(),
          bankName: "UgBills",
          accountName: fullname,
          accountNumber: username,
          fee: "₦${data["transaction"]["charges"] ?? '0.00'}",
          note: note,
        ),
      ));
    }
  } on DioException catch (e) {
    ref.read(isLoadingProvider.notifier).state = false;

    if (e.response!.data != null) {
      var data = jsonDecode(e.response!.data);
      String errorMessage = "Transfer failed";
      if (data["errors"] != null &&
          data["errors"] is List &&
          data["errors"].isNotEmpty) {
        errorMessage = data["errors"][0];
      } else if (data["msg"] != null) {
        errorMessage = data["msg"];
      }
      errorSnack(context, errorMessage);
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
      "${WebEndpoints.Endpoints.oneTimeAccount}/$reference",
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
