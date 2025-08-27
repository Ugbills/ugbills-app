class AccountLevelModel {
  bool? success;
  String? message;
  int? code;
  List<Data>? data;

  AccountLevelModel({this.success, this.message, this.code, this.data});

  AccountLevelModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
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
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  int? levelId;
  dynamic amountPerTransaction;
  dynamic amountPerDay;
  dynamic totalBalance;
  String? status;

  Data(
      {this.name,
      this.levelId,
      this.amountPerTransaction,
      this.amountPerDay,
      this.totalBalance,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    levelId = json['level_id'];
    amountPerTransaction = json['amount_per_transaction'];
    amountPerDay = json['amount_per_day'];
    totalBalance = json['total_balance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['level_id'] = levelId;
    data['amount_per_transaction'] = amountPerTransaction;
    data['amount_per_day'] = amountPerDay;
    data['total_balance'] = totalBalance;
    data['status'] = status;
    return data;
  }
}
