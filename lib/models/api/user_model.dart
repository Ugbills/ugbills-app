class UserModel {
  bool? success;
  int? code;
  String? message;
  Data? data;

  UserModel({this.success, this.code, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  dynamic walletBalance;
  dynamic commissionBalance;
  String? username;
  String? email;
  int? level;
  dynamic referralCode;
  String? pin;
  String? createdAt;
  String? updatedAt;
  String? fullName;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.walletBalance,
      this.commissionBalance,
      this.username,
      this.email,
      this.level,
      this.referralCode,
      this.pin,
      this.createdAt,
      this.updatedAt,
      this.fullName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    firstName = json['first_name'] ?? json['firstname'];
    lastName = json['last_name'] ?? json['lastname'];
    phoneNumber = json['phone_number'];
    walletBalance = json['wallet_balance'];
    commissionBalance = json['commission_balance'];
    username = json['username'];
    email = json['email'];
    level = json['level'];
    referralCode = json['referral_code'];
    pin = json['pin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['firstname'] = firstName;
    data['lastname'] = lastName;
    data['phone_number'] = phoneNumber;
    data['wallet_balance'] = walletBalance;
    data['commission_balance'] = commissionBalance;
    data['username'] = username;
    data['email'] = email;
    data['level'] = level;
    data['referral_code'] = referralCode;
    data['pin'] = pin;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_name'] = fullName;
    return data;
  }
}
