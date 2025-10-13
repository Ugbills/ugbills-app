class SMEDataResponse {
  List<SMEDataProduct>? products;

  SMEDataResponse({this.products});

  SMEDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <SMEDataProduct>[];
      json['products'].forEach((v) {
        products!.add(SMEDataProduct.fromJson(v));
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

class SMEDataProduct {
  String? name;
  String? code;
  String? image;
  dynamic minAmount;
  dynamic maxAmount;
  SMEDataCashback? cashback;
  bool? visible;
  List<SMEDataVariation>? variations;

  SMEDataProduct({
    this.name,
    this.code,
    this.image,
    this.minAmount,
    this.maxAmount,
    this.cashback,
    this.visible,
    this.variations,
  });

  SMEDataProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    cashback = json['cashback'] != null
        ? SMEDataCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
    if (json['variations'] != null) {
      variations = <SMEDataVariation>[];
      json['variations'].forEach((v) {
        variations!.add(SMEDataVariation.fromJson(v));
      });
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
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SMEDataVariation {
  String? name;
  String? code;
  int? productId;
  dynamic price;
  dynamic agentPrice;
  bool? visible;

  SMEDataVariation({
    this.name,
    this.code,
    this.productId,
    this.price,
    this.agentPrice,
    this.visible,
  });

  SMEDataVariation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    productId = json['product_id'];
    price = json['price'];
    agentPrice = json['agent_price'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['product_id'] = productId;
    data['price'] = price;
    data['agent_price'] = agentPrice;
    data['visible'] = visible;
    return data;
  }
}

class SMEDataCashback {
  dynamic percentage;
  dynamic amount;

  SMEDataCashback({
    this.percentage,
    this.amount,
  });

  SMEDataCashback.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentage'] = percentage;
    data['amount'] = amount;
    return data;
  }
}
