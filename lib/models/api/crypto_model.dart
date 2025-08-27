class CryptoListModel {
  int? code;
  String? message;
  bool? success;
  List<Data>? data;

  CryptoListModel({this.code, this.message, this.success, this.data});

  CryptoListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
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
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? currency;
  List<String>? networks;
  String? icon;

  Data({this.name, this.currency, this.networks, this.icon});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currency = json['currency'];
    networks = json['networks'].cast<String>();
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['currency'] = currency;
    data['networks'] = networks;
    data['icon'] = icon;
    return data;
  }
}
