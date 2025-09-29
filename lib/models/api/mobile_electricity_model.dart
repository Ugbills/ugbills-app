class MobileElectricityResponse {
  List<MobileElectricityProduct>? products;

  MobileElectricityResponse({this.products});

  MobileElectricityResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <MobileElectricityProduct>[];
      json['products'].forEach((v) {
        products!.add(MobileElectricityProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MobileElectricityProduct {
  String? name;
  String? code;
  String? image;
  dynamic minAmount;
  dynamic maxAmount;
  MobileElectricityCashback? cashback;
  bool? visible;
  List<dynamic>? variations; // Empty for electricity providers

  MobileElectricityProduct({
    this.name,
    this.code,
    this.image,
    this.minAmount,
    this.maxAmount,
    this.cashback,
    this.visible,
    this.variations,
  });

  MobileElectricityProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    cashback = json['cashback'] != null
        ? MobileElectricityCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
    if (json['variations'] != null) {
      variations = json['variations'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['image'] = image;
    data['min_amount'] = minAmount;
    data['max_amount'] = maxAmount;
    if (cashback != null) {
      data['cashback'] = cashback!.toJson();
    }
    data['visible'] = visible;
    if (variations != null) {
      data['variations'] = variations;
    }
    return data;
  }
}

class MobileElectricityCashback {
  int? type;
  dynamic value;
  MobileElectricityAgent? agent;

  MobileElectricityCashback({this.type, this.value, this.agent});

  MobileElectricityCashback.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    agent = json['agent'] != null
        ? MobileElectricityAgent.fromJson(json['agent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    if (agent != null) {
      data['agent'] = agent!.toJson();
    }
    return data;
  }
}

class MobileElectricityAgent {
  int? type;
  dynamic value;

  MobileElectricityAgent({this.type, this.value});

  MobileElectricityAgent.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
