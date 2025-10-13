class InternetDataResponse {
  List<InternetDataProduct>? products;

  InternetDataResponse({this.products});

  InternetDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <InternetDataProduct>[];
      json['products'].forEach((v) {
        products!.add(InternetDataProduct.fromJson(v));
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

class InternetDataProduct {
  String? name;
  String? code;
  String? image;
  dynamic minAmount;
  dynamic maxAmount;
  InternetDataCashback? cashback;
  bool? visible;
  List<InternetDataVariation>? variations;

  InternetDataProduct({
    this.name,
    this.code,
    this.image,
    this.minAmount,
    this.maxAmount,
    this.cashback,
    this.visible,
    this.variations,
  });

  InternetDataProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    cashback = json['cashback'] != null
        ? InternetDataCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
    if (json['variations'] != null) {
      variations = <InternetDataVariation>[];
      json['variations'].forEach((v) {
        variations!.add(InternetDataVariation.fromJson(v));
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

class InternetDataVariation {
  String? name;
  String? code;
  int? productId;
  dynamic price;
  dynamic agentPrice;
  bool? visible;

  InternetDataVariation({
    this.name,
    this.code,
    this.productId,
    this.price,
    this.agentPrice,
    this.visible,
  });

  InternetDataVariation.fromJson(Map<String, dynamic> json) {
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

class InternetDataCashback {
  dynamic percentage;
  dynamic amount;

  InternetDataCashback({
    this.percentage,
    this.amount,
  });

  InternetDataCashback.fromJson(Map<String, dynamic> json) {
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
