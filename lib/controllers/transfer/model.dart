class ZeePayInfo {
  bool? success;
  int? code;
  String? message;
  Data? data;

  ZeePayInfo({this.success, this.code, this.message, this.data});

  ZeePayInfo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? fullName;
  String? username;

  Data({this.fullName, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['username'] = username;
    return data;
  }
}

class AccountInfoModel {
  String? accountName;

  AccountInfoModel({this.accountName});

  AccountInfoModel.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_name'] = accountName;
    return data;
  }
}
