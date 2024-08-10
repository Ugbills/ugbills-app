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
  String? userId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  dynamic walletBalance;
  dynamic transferLimit;
  dynamic transferLevelLimit;
  String? username;
  String? email;
  String? dateOfBirth;
  int? level;
  String? bvn;
  String? nin;
  bool? kycVerified;
  String? refferalId;
  bool? isRestricted;
  String? profilePicture;
  bool? emailVerified;
  bool? accountDeleted;
  String? country;
  String? address;
  String? lastLogin;
  String? pin;
  String? createdAt;

  Data(
      {this.userId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.walletBalance,
      this.transferLimit,
      this.transferLevelLimit,
      this.username,
      this.email,
      this.dateOfBirth,
      this.level,
      this.bvn,
      this.nin,
      this.kycVerified,
      this.refferalId,
      this.isRestricted,
      this.profilePicture,
      this.emailVerified,
      this.accountDeleted,
      this.country,
      this.address,
      this.lastLogin,
      this.pin,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    walletBalance = json['wallet_balance'];
    transferLimit = json['transfer_limit'];
    transferLevelLimit = json['transfer_level_limit'];
    username = json['username'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    level = json['level'];
    bvn = json['bvn'];
    nin = json['nin'];
    kycVerified = json['kyc_verified'];
    refferalId = json['refferal_id'];
    isRestricted = json['is_restricted'];
    profilePicture = json['profile_picture'];
    emailVerified = json['email_verified'];
    accountDeleted = json['account_deleted'];
    country = json['country'];
    address = json['address'];
    lastLogin = json['last_login'];
    pin = json['pin'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['wallet_balance'] = walletBalance;
    data['transfer_limit'] = transferLimit;
    data['transfer_level_limit'] = transferLevelLimit;
    data['username'] = username;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['level'] = level;
    data['bvn'] = bvn;
    data['nin'] = nin;
    data['kyc_verified'] = kycVerified;
    data['refferal_id'] = refferalId;
    data['is_restricted'] = isRestricted;
    data['profile_picture'] = profilePicture;
    data['email_verified'] = emailVerified;
    data['account_deleted'] = accountDeleted;
    data['country'] = country;
    data['address'] = address;
    data['last_login'] = lastLogin;
    data['pin'] = pin;
    data['created_at'] = createdAt;
    return data;
  }
}
