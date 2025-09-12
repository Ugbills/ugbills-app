class ReferralsModel {
  bool? success;
  dynamic code;
  String? message;
  Data? data;

  ReferralsModel({this.success, this.code, this.message, this.data});

  ReferralsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic balance;
  List<Referrals>? referrals;

  Data({this.balance, this.referrals});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    if (json['Referrals'] != null) {
      referrals = <Referrals>[];
      json['Referrals'].forEach((v) {
        referrals!.add(Referrals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    if (referrals != null) {
      data['Referrals'] = referrals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Referrals {
  String? name;
  String? status;
  String? createdAt;

  Referrals({this.name, this.status, this.createdAt});

  Referrals.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
