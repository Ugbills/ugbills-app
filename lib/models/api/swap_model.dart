class SwapResultModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  SwapResultModel({this.success, this.code, this.message, this.data});

  SwapResultModel.fromJson(Map<String, dynamic> json) {
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
  int? amount;
  String? type;
  String? product;
  String? date;
  String? phoneNumber;
  String? serviceProvider;
  String? status;
  String? kind;
  int? fee;
  String? reference;

  Data(
      {this.amount,
      this.type,
      this.product,
      this.date,
      this.phoneNumber,
      this.serviceProvider,
      this.status,
      this.kind,
      this.fee,
      this.reference});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = json['type'];
    product = json['product'];
    date = json['date'];
    phoneNumber = json['phone_number'];
    serviceProvider = json['service_provider'];
    status = json['status'];
    kind = json['kind'];
    fee = json['fee'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['type'] = type;
    data['product'] = product;
    data['date'] = date;
    data['phone_number'] = phoneNumber;
    data['service_provider'] = serviceProvider;
    data['status'] = status;
    data['kind'] = kind;
    data['fee'] = fee;
    data['reference'] = reference;
    return data;
  }
}
