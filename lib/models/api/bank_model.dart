class BankModel {
  List<BankData>? banks;

  BankModel({this.banks});

  BankModel.fromJson(List<dynamic> json) {
    banks = <BankData>[];
    for (var v in json) {
      banks!.add(BankData.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    if (banks != null) {
      return banks!.map((v) => v.toJson()).toList();
    }
    return [];
  }
}

class BankData {
  String? name;
  String? code;
  String? ussdTemplate;
  String? baseUssdCode;
  String? transferUssdTemplate;
  String? bankId;
  String? nipBankCode;

  BankData({
    this.name,
    this.code,
    this.ussdTemplate,
    this.baseUssdCode,
    this.transferUssdTemplate,
    this.bankId,
    this.nipBankCode,
  });

  BankData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    ussdTemplate = json['ussdTemplate'];
    baseUssdCode = json['baseUssdCode'];
    transferUssdTemplate = json['transferUssdTemplate'];
    bankId = json['bankId'];
    nipBankCode = json['nipBankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['ussdTemplate'] = ussdTemplate;
    data['baseUssdCode'] = baseUssdCode;
    data['transferUssdTemplate'] = transferUssdTemplate;
    data['bankId'] = bankId;
    data['nipBankCode'] = nipBankCode;
    return data;
  }
}

// Keep old Data class for backward compatibility if needed
class Data {
  String? bankCode;
  String? bankName;
  String? icon;

  Data({this.bankCode, this.bankName, this.icon});

  Data.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bankName = json['bankName'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
    data['icon'] = icon;
    return data;
  }
}
