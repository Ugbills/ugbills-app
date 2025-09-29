class MobileAirtimeResponse {
  List<MobileAirtimeProduct>? products;

  MobileAirtimeResponse({this.products});

  MobileAirtimeResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <MobileAirtimeProduct>[];
      json['products'].forEach((v) {
        products!.add(MobileAirtimeProduct.fromJson(v));
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

class MobileAirtimeProduct {
  String? name;
  String? code;
  String? image;
  dynamic minAmount;
  dynamic maxAmount;
  MobileAirtimeCashback? cashback;
  bool? visible;
  String? serviceId;

  MobileAirtimeProduct({
    this.name,
    this.code,
    this.image,
    this.minAmount,
    this.maxAmount,
    this.cashback,
    this.visible,
    this.serviceId,
  });

  MobileAirtimeProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    cashback = json['cashback'] != null
        ? MobileAirtimeCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
    serviceId = json['service_id'];
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
    data['service_id'] = serviceId;
    return data;
  }
}

class MobileAirtimeCashback {
  dynamic type;
  dynamic value;
  MobileAirtimeAgent? agent;

  MobileAirtimeCashback({this.type, this.value, this.agent});

  MobileAirtimeCashback.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    agent = json['agent'] != null
        ? MobileAirtimeAgent.fromJson(json['agent'])
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

class MobileAirtimeAgent {
  dynamic type;
  dynamic value;

  MobileAirtimeAgent({this.type, this.value});

  MobileAirtimeAgent.fromJson(Map<String, dynamic> json) {
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
