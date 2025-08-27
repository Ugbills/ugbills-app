class CablePlans {
  int? code;
  bool? success;
  String? message;
  List<Data>? data;

  CablePlans({this.code, this.success, this.message, this.data});

  CablePlans.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
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
    data['code'] = code;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? productId;
  String? productCode;
  String? planId;
  String? planName;
  int? amount;

  Data(
      {this.productId,
      this.productCode,
      this.planId,
      this.planName,
      this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCode = json['product_code'];
    planId = json['plan_id'];
    planName = json['plan_name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_code'] = productCode;
    data['plan_id'] = planId;
    data['plan_name'] = planName;
    data['amount'] = amount;
    return data;
  }
}
