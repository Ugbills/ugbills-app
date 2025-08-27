class OneTimeBank {
  int? code;
  String? message;
  String? status;
  Data? data;

  OneTimeBank({this.code, this.message, this.status, this.data});

  OneTimeBank.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accountNumber;
  String? accountName;
  String? bankName;
  String? expires;
  String? reference;

  Data(
      {this.accountNumber,
      this.accountName,
      this.bankName,
      this.expires,
      this.reference});

  Data.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    bankName = json['bank_name'];
    expires = json['expires'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['bank_name'] = bankName;
    data['expires'] = expires;
    data['reference'] = reference;
    return data;
  }
}
