class BeneficiariesModel {
  bool? success;
  int? code;
  String? message;
  List<Data>? data;

  BeneficiariesModel({this.success, this.code, this.message, this.data});

  BeneficiariesModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userId;
  String? sessionId;
  String? bankCode;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? createdAt;

  Data(
      {this.id,
      this.userId,
      this.sessionId,
      this.bankCode,
      this.bankName,
      this.accountNumber,
      this.accountName,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sessionId = json['session_id'];
    bankCode = json['bank_code'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['session_id'] = sessionId;
    data['bank_code'] = bankCode;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['created_at'] = createdAt;
    return data;
  }
}
