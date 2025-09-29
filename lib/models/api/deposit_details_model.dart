class DepositDetailsModel {
  String? bankName;
  String? accountNumber;
  dynamic transferFee;
  dynamic bankDepositMinAmount;
  dynamic bankDepositMaxAmount;

  DepositDetailsModel({
    this.bankName,
    this.accountNumber,
    this.transferFee,
    this.bankDepositMinAmount,
    this.bankDepositMaxAmount,
  });

  DepositDetailsModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    transferFee = json['transfer_fee'];
    bankDepositMinAmount = json['bank_deposit_min_amount'];
    bankDepositMaxAmount = json['bank_deposit_max_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['transfer_fee'] = transferFee;
    data['bank_deposit_min_amount'] = bankDepositMinAmount;
    data['bank_deposit_max_amount'] = bankDepositMaxAmount;
    return data;
  }
}
