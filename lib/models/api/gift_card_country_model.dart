class GiftCardCountryModel {
  bool? success;
  String? message;
  int? code;
  List<Data>? data;

  GiftCardCountryModel({this.success, this.message, this.code, this.data});

  GiftCardCountryModel.fromJson(Map<String, dynamic> json) {
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
  String? isoName;
  String? name;
  String? currencyCode;
  String? currencyName;
  String? flagUrl;

  Data(
      {this.isoName,
      this.name,
      this.currencyCode,
      this.currencyName,
      this.flagUrl});

  Data.fromJson(Map<String, dynamic> json) {
    isoName = json['isoName'];
    name = json['name'];
    currencyCode = json['currencyCode'];
    currencyName = json['currencyName'];
    flagUrl = json['flagUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isoName'] = isoName;
    data['name'] = name;
    data['currencyCode'] = currencyCode;
    data['currencyName'] = currencyName;
    data['flagUrl'] = flagUrl;
    return data;
  }
}
