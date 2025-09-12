import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/api/endpoints.dart';
import 'package:ugbills/helpers/api/response_helper.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/models/api/bank_account_model.dart';
import 'package:ugbills/models/api/beneficiaries_model.dart';
import 'package:ugbills/models/api/level_model.dart';
import 'package:ugbills/models/api/onetime_bank_model.dart';
import 'package:ugbills/models/api/referrals_model.dart';
import 'package:ugbills/models/api/user_model.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/auth/create/set_pin.dart';
import 'package:ugbills/services/http_service.dart';

part 'user_provider.g.dart';

ApiRepository api = ApiRepository();

var tokenStorage = TokenStorage();

var httpService = HttpService();

@Riverpod(keepAlive: false)
Future<UserModel?> fetchUserInformation(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();

    log(token!);

    var response = await httpService.getRequest(Endpoints.user,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200 || response.statusCode == 201) {
      log(response.data);
      var user = UserModel.fromJson(jsonDecode(response.data));

      if (user.data!.pin!.isEmpty) {
        Go.to(const SetransactionPin());
      }

      return user;
    }
  } on DioException catch (e) {
    log(e.toString());
    if (e.response!.statusCode == 401) {
      AuthRepository().logout();
    }
    throw Exception(e);
  }
  return null;
}

//fetch user beneficiaries

@Riverpod(keepAlive: false)
Future<BeneficiariesModel?> fetchUserBeneficiaries(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();

    log(token!);

    var response = await httpService.getRequest(Endpoints.userBeneficiaries,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);
      return BeneficiariesModel.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

//fetch user refferals

@Riverpod(keepAlive: false)
Future<ReferralsModel?> fetchUserReferrals(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();

    log(token!);

    var response = await httpService.getRequest(Endpoints.userReferrals,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);
      return ReferralsModel.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

// fetch user virtual accounts

@Riverpod(keepAlive: false)
Future<OneTimeBank?> oneTimeAccount(Ref ref, {required dynamic amount}) async {
  try {
    var token = await tokenStorage.getToken();
    var response = await httpService.postRequest(Endpoints.oneTimeAccount,
        data: {
          "amount": amount
        },
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        });

    if (response.statusCode == 200) {
      log(response.data);
      return OneTimeBank.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    if (e.response!.data != null) {
      //show custom error message

      throw Exception(jsonDecode(e.response!.data)["message"]);
    }

    throw Exception(e);
  }
  return null;
}

// fetch user virtual accounts

@Riverpod(keepAlive: false)
Future<BankAccountModel?> fetchUserVirtualAccount(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();

    log(token!);

    var response = await httpService.getRequest(Endpoints.virtualAccount,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);
      return BankAccountModel.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}

@Riverpod(keepAlive: false)
Future<AccountLevelModel?> fetchAccountLevel(Ref ref) async {
  try {
    var token = await tokenStorage.getToken();

    log(token!);

    var response = await httpService.getRequest(Endpoints.currentLevel,
        headers: {
          'X-Forwarded-For': '1234',
          'Y-decryption-key': '1234',
          "ZEEL-SECURE-KEY": token
        },
        responseType: ResponseType.plain);

    if (response.statusCode == 200) {
      log(response.data);
      return AccountLevelModel.fromJson(jsonDecode(response.data));
    }
  } on DioException catch (e) {
    throw Exception(e);
  }
  return null;
}
