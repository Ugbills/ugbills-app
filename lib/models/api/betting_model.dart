class BettingModel {
  int? code;
  bool? success;
  String? message;
  List<Data>? data;

  BettingModel({this.code, this.success, this.message, this.data});

  BettingModel.fromJson(Map<String, dynamic> json) {
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
  int? minAmount;
  int? maxAmount;
  String? name;
  int? fee;

  Data(
      {this.productId,
      this.productCode,
      this.minAmount,
      this.maxAmount,
      this.name,
      this.fee});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCode = json['product_code'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    name = json['name'];
    fee = json['fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_code'] = productCode;
    data['min_amount'] = minAmount;
    data['max_amount'] = maxAmount;
    data['name'] = name;
    data['fee'] = fee;
    return data;
  }
}
