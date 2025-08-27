class CardsModel {
  bool? success;
  int? code;
  String? message;
  List<Data>? data;

  CardsModel({this.success, this.code, this.message, this.data});

  CardsModel.fromJson(Map<String, dynamic> json) {
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
  String? cardId;
  String? cardName;
  String? maskedPan;
  String? cardStatus;
  String? cardType;
  String? cardIssuer;
  String? cardCurrency;
  String? cardBalance;
  String? reference;
  bool? isDeleted;
  bool? isUsable;
  String? createdAt;

  Data(
      {this.cardId,
      this.cardName,
      this.maskedPan,
      this.cardStatus,
      this.cardType,
      this.cardIssuer,
      this.cardCurrency,
      this.cardBalance,
      this.reference,
      this.isDeleted,
      this.isUsable,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    cardName = json['card_name'];
    maskedPan = json['masked_pan'];
    cardStatus = json['card_status'];
    cardType = json['card_type'];
    cardIssuer = json['card_issuer'];
    cardCurrency = json['card_currency'];
    cardBalance = json['card_balance'];
    reference = json['reference'];
    isDeleted = json['is_deleted'];
    isUsable = json['is_usable'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_id'] = cardId;
    data['card_name'] = cardName;
    data['masked_pan'] = maskedPan;
    data['card_status'] = cardStatus;
    data['card_type'] = cardType;
    data['card_issuer'] = cardIssuer;
    data['card_currency'] = cardCurrency;
    data['card_balance'] = cardBalance;
    data['reference'] = reference;
    data['is_deleted'] = isDeleted;
    data['is_usable'] = isUsable;
    data['created_at'] = createdAt;
    return data;
  }
}
