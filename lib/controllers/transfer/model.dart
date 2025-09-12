
class ZeePayInfo {
  bool? success;
  int? code;
  String? message;
  Data? data;

  ZeePayInfo({this.success, this.code, this.message, this.data});

  ZeePayInfo.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? fullName;
  String? avatar;
  String? username;

  Data({this.userId, this.fullName, this.avatar, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    avatar = json['avatar'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['avatar'] = avatar;
    data['username'] = username;
    return data;
  }
}

class AccountInfoModel {
  String? accountNumber;
  String? accountName;
  dynamic senderAccountNumber;
  dynamic senderName;
  String? bankCode;
  String? nameEnquiryId;
  String? sessionID;

  AccountInfoModel(
      {this.accountNumber,
      this.accountName,
      this.senderAccountNumber,
      this.senderName,
      this.bankCode,
      this.nameEnquiryId,
      this.sessionID});

  AccountInfoModel.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    senderAccountNumber = json['sender_account_number'];
    senderName = json['sender_name'];
    bankCode = json['bank_code'];
    nameEnquiryId = json['name_enquiry_id'];
    sessionID = json['sessionID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['sender_account_number'] = senderAccountNumber;
    data['sender_name'] = senderName;
    data['bank_code'] = bankCode;
    data['name_enquiry_id'] = nameEnquiryId;
    data['sessionID'] = sessionID;
    return data;
  }
}
