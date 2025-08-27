class BankModel {
  int? code;
  String? message;
  String? title;
  bool? success;
  List<Data>? data;

  BankModel({this.code, this.message, this.title, this.success, this.data});

  BankModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    title = json['title'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['title'] = title;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? bankCode;
  String? bankName;
  String? icon;

  Data({this.bankCode, this.bankName, this.icon});

  Data.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bankName = json['bankName'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
    data['icon'] = icon;
    return data;
  }
}
