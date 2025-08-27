class BankAccountModel {
  bool? success;
  int? code;
  String? message;
  List<Data>? data;

  BankAccountModel({this.success, this.code, this.message, this.data});

  BankAccountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? accountName;
  String? accountNumber;
  String? bankName;

  Data({this.accountName, this.accountNumber, this.bankName});

  Data.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['bank_name'] = bankName;
    return data;
  }
}
