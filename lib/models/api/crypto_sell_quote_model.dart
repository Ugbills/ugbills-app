class CryptoSellQuoteModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  CryptoSellQuoteModel({this.success, this.message, this.code, this.data});

  CryptoSellQuoteModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? address;
  dynamic amount;
  dynamic receive;
  dynamic fee;
  String? reference;

  Data({this.address, this.amount, this.receive, this.fee, this.reference});

  Data.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    amount = json['amount'];
    receive = json['receive'];
    fee = json['fee'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['amount'] = amount;
    data['receive'] = receive;
    data['fee'] = fee;
    data['reference'] = reference;
    return data;
  }
}
