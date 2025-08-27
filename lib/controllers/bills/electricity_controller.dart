// ignore_for_file: avoid_build_context_in_providers, use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/constants/assets/svg.dart';
import 'package:zeelpay/controllers/auth/auth_helper.dart';
import 'package:zeelpay/controllers/transfer/transfer_controller.dart';
import 'package:zeelpay/helpers/api/response_helper.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/common/data_formatter.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/user/pay/electricity/electricity_transaction_details.dart';
import 'package:zeelpay/screens/widgets/sent.dart';

part 'electricity_controller.g.dart';

final ApiRepository api = ApiRepository();

@riverpod
class ElectricityController extends _$ElectricityController {
  @override
  dynamic build() {
    throw UnimplementedError();
  }

  Future<CustomerInfoModel?> validateName(
      {required String customerId,
      required String productID,
      required String meterType,
      required WidgetRef ref}) async {
    try {
      ref.read(isValidatingProvider.notifier).state = true;

      var token = await tokenStorage.getToken();
      var response = await httpService.getRequest(Endpoints.electricityValidate,
          headers: {
            'X-Forwarded-For': '1234',
            'Y-decryption-key': '1234',
            "ZEEL-SECURE-KEY": token
          },
          queryParameters: {
            "product_id": productID,
            "meter_number": customerId,
            "meter_type": meterType
          },
          responseType: ResponseType.plain);

      ref.read(isValidatingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        await refreshUser(ref: ref);
        log(response.data.toString());

        var data = jsonDecode(response.data);

        var info = CustomerInfoModel.fromJson(data["data"]);

        return info;
      }
    } on DioException catch (e) {
      ref.read(isValidatingProvider.notifier).state = false;
      log(e.toString());
      throw Exception(e);
    }
    return null;
  }

// buy method
  Future buy({
    required String customerId,
    required String productID,
    required String pin,
    required String meterType,
    required String amount,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;

      var token = await tokenStorage.getToken();
      var response =
          await httpService.postRequest(Endpoints.electricityBuy, headers: {
        'X-Forwarded-For': '1234',
        'Y-decryption-key': '1234',
        "ZEEL-SECURE-KEY": token
      }, data: {
        "pin": pin,
        "meter_type": meterType,
        "amount": amount,
        "product_id": productID,
        "meter_number": customerId
      });

      ref.read(isLoadingProvider.notifier).state = false;

      if (response.statusCode == 200) {
        log(response.data.toString());

        var data = jsonDecode(response.data);
        var transaction = data["data"];

        Go.to(SentSuccessfully(
          title: "Completed",
          body: data["message"],
          nextPage: ElectricityTransactionDetails(
            electricityProviderLogo: ZeelSvg.electricity,
            amount: returnAmount(transaction["amount"]),
            transactionID: transaction["reference"],
            dateAndTime: formartDateTime(DateTime.now().toString()),
            meterNumber: customerId,
            serviceProvider: transaction["provider"],
            type: meterType.toUpperCase(),
            pin: transaction["token"],
            fee: returnAmount(transaction["fee"]),
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
    return null;
  }
}

class CustomerInfoModel {
  String? name;

  CustomerInfoModel({this.name});

  CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
