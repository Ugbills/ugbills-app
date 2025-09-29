class DataBundleResponse {
  List<DataBundleProduct>? products;

  DataBundleResponse({this.products});

  DataBundleResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <DataBundleProduct>[];
      json['products'].forEach((v) {
        products!.add(DataBundleProduct.fromJson(v));
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

class DataBundleProduct {
  String? name;
  String? code;
  String? image;
  dynamic minAmount;
  dynamic maxAmount;
  DataBundleCashback? cashback;
  bool? visible;
  List<DataBundleVariation>? variations;

  DataBundleProduct({
    this.name,
    this.code,
    this.image,
    this.minAmount,
    this.maxAmount,
    this.cashback,
    this.visible,
    this.variations,
  });

  DataBundleProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    cashback = json['cashback'] != null
        ? DataBundleCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
    if (json['variations'] != null) {
      variations = <DataBundleVariation>[];
      json['variations'].forEach((v) {
        variations!.add(DataBundleVariation.fromJson(v));
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

class DataBundleVariation {
  String? name;
  String? code;
  int? productId;
  dynamic price;
  dynamic agentPrice;
  DataBundleCashback? cashback;
  bool? visible;

  DataBundleVariation({
    this.name,
    this.code,
    this.productId,
    this.price,
    this.agentPrice,
    this.cashback,
    this.visible,
  });

  DataBundleVariation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    productId = json['product_id'];
    price = json['price'];
    agentPrice = json['agent_price'];
    cashback = json['cashback'] != null
        ? DataBundleCashback.fromJson(json['cashback'])
        : null;
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['product_id'] = productId;
    data['price'] = price;
    data['agent_price'] = agentPrice;
    if (cashback != null) {
      data['cashback'] = cashback!.toJson();
    }
    data['visible'] = visible;
    return data;
  }
}

class DataBundleCashback {
  int? type;
  dynamic value;
  DataBundleAgent? agent;

  DataBundleCashback({this.type, this.value, this.agent});

  DataBundleCashback.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    agent =
        json['agent'] != null ? DataBundleAgent.fromJson(json['agent']) : null;
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

class DataBundleAgent {
  int? type;
  dynamic value;

  DataBundleAgent({this.type, this.value});

  DataBundleAgent.fromJson(Map<String, dynamic> json) {
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
