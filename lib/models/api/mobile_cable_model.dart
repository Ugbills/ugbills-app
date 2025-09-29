class MobileCableResponse {
  List<MobileCableProduct>? products;

  MobileCableResponse({this.products});

  MobileCableResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <MobileCableProduct>[];
      json['products'].forEach((v) {
        products!.add(MobileCableProduct.fromJson(v));
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

class MobileCableProduct {
  String? name;
  String? code;
  String? image;
  dynamic minAmount;
  dynamic maxAmount;
  MobileCableCashback? cashback;
  bool? visible;
  List<MobileCableVariation>? variations;

  MobileCableProduct({
    this.name,
    this.code,
    this.image,
    this.minAmount,
    this.maxAmount,
    this.cashback,
    this.visible,
    this.variations,
  });

  MobileCableProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    cashback = json['cashback'] != null
        ? MobileCableCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
    if (json['variations'] != null) {
      variations = <MobileCableVariation>[];
      json['variations'].forEach((v) {
        variations!.add(MobileCableVariation.fromJson(v));
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

class MobileCableVariation {
  String? name;
  String? code;
  dynamic price;
  dynamic agentPrice;
  dynamic productId;
  MobileCableCashback? cashback;
  bool? visible;

  MobileCableVariation({
    this.name,
    this.code,
    this.price,
    this.agentPrice,
    this.productId,
    this.cashback,
    this.visible,
  });

  MobileCableVariation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    price = json['price'];
    agentPrice = json['agent_price'];
    productId = json['product_id'];
    cashback = json['cashback'] != null
        ? MobileCableCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['price'] = price;
    data['agent_price'] = agentPrice;
    data['product_id'] = productId;
    if (cashback != null) {
      data['cashback'] = cashback!.toJson();
    }
    data['visible'] = visible;
    return data;
  }
}

class MobileCableCashback {
  dynamic type;
  dynamic value;
  MobileCableAgent? agent;

  MobileCableCashback({this.type, this.value, this.agent});

  MobileCableCashback.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    agent =
        json['agent'] != null ? MobileCableAgent.fromJson(json['agent']) : null;
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

class MobileCableAgent {
  dynamic type;
  dynamic value;

  MobileCableAgent({this.type, this.value});

  MobileCableAgent.fromJson(Map<String, dynamic> json) {
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
