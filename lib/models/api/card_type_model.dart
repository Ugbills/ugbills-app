class CardTypeModel {
  bool? success;
  int? code;
  String? message;
  List<Data>? data;

  CardTypeModel({this.success, this.code, this.message, this.data});

  CardTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
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
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? type;
  int? creationFee;
  String? issuer;
  String? currency;

  Data(
      {this.id,
      this.name,
      this.type,
      this.creationFee,
      this.issuer,
      this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    creationFee = json['creation_fee'];
    issuer = json['issuer'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['creation_fee'] = creationFee;
    data['issuer'] = issuer;
    data['currency'] = currency;
    return data;
  }
}
