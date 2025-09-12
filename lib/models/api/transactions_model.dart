class TransactionsModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  TransactionsModel({this.success, this.code, this.message, this.data});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
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
  List<ResponseData>? responseData;
  int? page;
  int? size;
  bool? nexpage;

  Data({this.responseData, this.page, this.size, this.nexpage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['response_data'] != null) {
      responseData = <ResponseData>[];
      json['response_data'].forEach((v) {
        responseData!.add(ResponseData.fromJson(v));
      });
    }
    page = json['page'];
    size = json['size'];
    nexpage = json['nexpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (responseData != null) {
      data['response_data'] = responseData!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['size'] = size;
    data['nexpage'] = nexpage;
    return data;
  }
}

class ResponseData {
  dynamic fee;
  String? accountNumber;
  String? reference;
  String? id;
  dynamic balanceBefore;
  String? senderAccount;
  String? status;
  String? createdAt;
  dynamic balanceAfter;
  String? recipient;
  String? transactionId;
  String? updatedAt;
  dynamic usdBalanceBefore;
  String? sender;
  String? sessionId;
  String? userId;
  dynamic usdBalanceAfter;
  String? title;
  String? billProvider;
  String? transactionType;
  String? note;
  String? receiptString;
  String? transactionKind;
  String? currency;
  int? pkid;
  dynamic amount;
  String? bank;
  String? method;

  ResponseData(
      {this.fee,
      this.accountNumber,
      this.reference,
      this.id,
      this.balanceBefore,
      this.senderAccount,
      this.status,
      this.createdAt,
      this.balanceAfter,
      this.recipient,
      this.transactionId,
      this.updatedAt,
      this.usdBalanceBefore,
      this.sender,
      this.sessionId,
      this.userId,
      this.usdBalanceAfter,
      this.title,
      this.billProvider,
      this.transactionType,
      this.note,
      this.receiptString,
      this.transactionKind,
      this.currency,
      this.pkid,
      this.amount,
      this.bank,
      this.method});

  ResponseData.fromJson(Map<String, dynamic> json) {
    fee = json['fee'];
    accountNumber = json['account_number'];
    reference = json['reference'];
    id = json['id'];
    balanceBefore = json['balance_before'];
    senderAccount = json['sender_account'];
    status = json['status'];
    createdAt = json['created_at'];
    balanceAfter = json['balance_after'];
    recipient = json['recipient'];
    transactionId = json['transaction_id'];
    updatedAt = json['updated_at'];
    usdBalanceBefore = json['usd_balance_before'];
    sender = json['sender'];
    sessionId = json['session_id'];
    userId = json['user_id'];
    usdBalanceAfter = json['usd_balance_after'];
    title = json['title'];
    billProvider = json['bill_provider'];
    transactionType = json['transaction_type'];
    note = json['note'];
    receiptString = json['receipt_string'];
    transactionKind = json['transaction_kind'];
    currency = json['currency'];
    pkid = json['pkid'];
    amount = json['amount'];
    bank = json['bank'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fee'] = fee;
    data['account_number'] = accountNumber;
    data['reference'] = reference;
    data['id'] = id;
    data['balance_before'] = balanceBefore;
    data['sender_account'] = senderAccount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['balance_after'] = balanceAfter;
    data['recipient'] = recipient;
    data['transaction_id'] = transactionId;
    data['updated_at'] = updatedAt;
    data['usd_balance_before'] = usdBalanceBefore;
    data['sender'] = sender;
    data['session_id'] = sessionId;
    data['user_id'] = userId;
    data['usd_balance_after'] = usdBalanceAfter;
    data['title'] = title;
    data['bill_provider'] = billProvider;
    data['transaction_type'] = transactionType;
    data['note'] = note;
    data['receipt_string'] = receiptString;
    data['transaction_kind'] = transactionKind;
    data['currency'] = currency;
    data['pkid'] = pkid;
    data['amount'] = amount;
    data['bank'] = bank;
    data['method'] = method;
    return data;
  }
}
