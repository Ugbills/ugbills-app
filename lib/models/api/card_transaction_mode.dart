class CardTransactionModel {
  bool? success;
  int? code;
  String? message;
  List<Data>? data;

  CardTransactionModel({this.success, this.code, this.message, this.data});

  CardTransactionModel.fromJson(Map<String, dynamic> json) {
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
  dynamic amount;
  String? recipientCity;
  String? createdAt;
  String? cardId;
  dynamic fee;
  String? method;
  String? updatedAt;
  double? balanceBefore;
  String? reference;
  dynamic balanceAfter;
  String? status;
  String? userId;
  String? transactionType;
  String? transactionId;
  String? description;
  String? sessionId;
  String? currency;
  int? pkid;
  String? receipient;
  String? id;

  Data(
      {this.amount,
      this.recipientCity,
      this.createdAt,
      this.cardId,
      this.fee,
      this.method,
      this.updatedAt,
      this.balanceBefore,
      this.reference,
      this.balanceAfter,
      this.status,
      this.userId,
      this.transactionType,
      this.transactionId,
      this.description,
      this.sessionId,
      this.currency,
      this.pkid,
      this.receipient,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    recipientCity = json['recipient_city'];
    createdAt = json['created_at'];
    cardId = json['card_id'];
    fee = json['fee'];
    method = json['method'];
    updatedAt = json['updated_at'];
    balanceBefore = json['balance_before'];
    reference = json['reference'];
    balanceAfter = json['balance_after'];
    status = json['status'];
    userId = json['user_id'];
    transactionType = json['transaction_type'];
    transactionId = json['transaction_id'];
    description = json['description'];
    sessionId = json['session_id'];
    currency = json['currency'];
    pkid = json['pkid'];
    receipient = json['receipient'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['recipient_city'] = recipientCity;
    data['created_at'] = createdAt;
    data['card_id'] = cardId;
    data['fee'] = fee;
    data['method'] = method;
    data['updated_at'] = updatedAt;
    data['balance_before'] = balanceBefore;
    data['reference'] = reference;
    data['balance_after'] = balanceAfter;
    data['status'] = status;
    data['user_id'] = userId;
    data['transaction_type'] = transactionType;
    data['transaction_id'] = transactionId;
    data['description'] = description;
    data['session_id'] = sessionId;
    data['currency'] = currency;
    data['pkid'] = pkid;
    data['receipient'] = receipient;
    data['id'] = id;
    return data;
  }
}
