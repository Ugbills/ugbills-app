class VirtualCardModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  VirtualCardModel({this.success, this.code, this.message, this.data});

  VirtualCardModel.fromJson(Map<String, dynamic> json) {
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
  String? cardId;
  String? cardName;
  String? cardNumber;
  String? maskedPan;
  String? cardExpiry;
  String? cardCvv;
  String? cardStatus;
  String? cardType;
  String? cardTypeId;
  String? cardIssuer;
  String? cardCurrency;
  String? cardBalance;
  String? cardStreet;
  String? cardState;
  String? cardCity;
  String? cardPostalCode;
  String? cardCountry;
  int? totalDeclines;
  bool? isDeleted;
  bool? isUsable;
  String? cardCreatedAt;

  Data(
      {this.cardId,
      this.cardName,
      this.cardNumber,
      this.maskedPan,
      this.cardExpiry,
      this.cardCvv,
      this.cardStatus,
      this.cardType,
      this.cardTypeId,
      this.cardIssuer,
      this.cardCurrency,
      this.cardBalance,
      this.cardStreet,
      this.cardState,
      this.cardCity,
      this.cardPostalCode,
      this.cardCountry,
      this.totalDeclines,
      this.isDeleted,
      this.isUsable,
      this.cardCreatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    cardName = json['card_name'];
    cardNumber = json['card_number'];
    maskedPan = json['masked_pan'];
    cardExpiry = json['card_expiry'];
    cardCvv = json['card_cvv'];
    cardStatus = json['card_status'];
    cardType = json['card_type'];
    cardTypeId = json['card_type_id'];
    cardIssuer = json['card_issuer'];
    cardCurrency = json['card_currency'];
    cardBalance = json['card_balance'];
    cardStreet = json['card_street'];
    cardState = json['card_state'];
    cardCity = json['card_city'];
    cardPostalCode = json['card_postal_code'];
    cardCountry = json['card_country'];
    totalDeclines = json['total_declines'];
    isDeleted = json['is_deleted'];
    isUsable = json['is_usable'];
    cardCreatedAt = json['card_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_id'] = cardId;
    data['card_name'] = cardName;
    data['card_number'] = cardNumber;
    data['masked_pan'] = maskedPan;
    data['card_expiry'] = cardExpiry;
    data['card_cvv'] = cardCvv;
    data['card_status'] = cardStatus;
    data['card_type'] = cardType;
    data['card_type_id'] = cardTypeId;
    data['card_issuer'] = cardIssuer;
    data['card_currency'] = cardCurrency;
    data['card_balance'] = cardBalance;
    data['card_street'] = cardStreet;
    data['card_state'] = cardState;
    data['card_city'] = cardCity;
    data['card_postal_code'] = cardPostalCode;
    data['card_country'] = cardCountry;
    data['total_declines'] = totalDeclines;
    data['is_deleted'] = isDeleted;
    data['is_usable'] = isUsable;
    data['card_created_at'] = cardCreatedAt;
    return data;
  }
}
