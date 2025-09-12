class CryptoBuyQuoteModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  CryptoBuyQuoteModel({this.success, this.code, this.message, this.data});

  CryptoBuyQuoteModel.fromJson(Map<String, dynamic> json) {
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
  dynamic receive;
  dynamic pay;
  dynamic fee;
  dynamic usdValue;
  dynamic convertedVolume;
  String? currency;

  Data(
      {this.receive,
      this.pay,
      this.fee,
      this.usdValue,
      this.convertedVolume,
      this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    receive = json['receive'];
    pay = json['pay'];
    fee = json['fee'];
    usdValue = json['usd_value'];
    convertedVolume = json['converted_volume'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receive'] = receive;
    data['pay'] = pay;
    data['fee'] = fee;
    data['usd_value'] = usdValue;
    data['converted_volume'] = convertedVolume;
    data['currency'] = currency;
    return data;
  }
}
