class TransactionsModel {
  bool? success;
  String? message;
  List<Transaction>? transactions;
  Meta? meta;

  TransactionsModel({this.success, this.message, this.transactions, this.meta});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transaction.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Transaction {
  int? id;
  String? reference;
  String? status;
  dynamic amount;
  dynamic balanceBefore;
  dynamic balanceAfter;
  String? type;
  String? walletType;
  String? operation;
  String? beneficiary;
  String? description;
  String? createdAt;
  Product? product;
  Variation? variation;
  dynamic metadata;

  Transaction({
    this.id,
    this.reference,
    this.status,
    this.amount,
    this.balanceBefore,
    this.balanceAfter,
    this.type,
    this.walletType,
    this.operation,
    this.beneficiary,
    this.description,
    this.createdAt,
    this.product,
    this.variation,
    this.metadata,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    status = json['status'];
    amount = json['amount'];
    balanceBefore = json['balance_before'];
    balanceAfter = json['balance_after'];
    type = json['type'];
    walletType = json['wallet_type'];
    operation = json['operation'];
    beneficiary = json['beneficiary'];
    description = json['description'];
    createdAt = json['created_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    variation = json['variation'] != null
        ? Variation.fromJson(json['variation'])
        : null;
    metadata = json['metadata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference'] = reference;
    data['status'] = status;
    data['amount'] = amount;
    data['balance_before'] = balanceBefore;
    data['balance_after'] = balanceAfter;
    data['type'] = type;
    data['wallet_type'] = walletType;
    data['operation'] = operation;
    data['beneficiary'] = beneficiary;
    data['description'] = description;
    data['created_at'] = createdAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (variation != null) {
      data['variation'] = variation!.toJson();
    }
    data['metadata'] = metadata;
    return data;
  }
}

class Product {
  String? name;
  String? code;
  String? image;
  int? minAmount;
  int? maxAmount;
  Cashback? cashback;
  bool? visible;
  List<Variation>? variations;

  Product({
    this.name,
    this.code,
    this.image,
    this.minAmount,
    this.maxAmount,
    this.cashback,
    this.visible,
    this.variations,
  });

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    cashback =
        json['cashback'] != null ? Cashback.fromJson(json['cashback']) : null;
    visible = json['visible'];
    if (json['variations'] != null) {
      variations = <Variation>[];
      json['variations'].forEach((v) {
        variations!.add(Variation.fromJson(v));
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

class Variation {
  String? name;
  String? code;
  int? productId;
  dynamic price;
  dynamic agentPrice;
  Cashback? cashback;
  bool? visible;

  Variation({
    this.name,
    this.code,
    this.productId,
    this.price,
    this.agentPrice,
    this.cashback,
    this.visible,
  });

  Variation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    productId = json['product_id'];
    price = json['price'];
    agentPrice = json['agent_price'];
    cashback =
        json['cashback'] != null ? Cashback.fromJson(json['cashback']) : null;
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

class Cashback {
  int? type;
  dynamic value;
  Agent? agent;

  Cashback({this.type, this.value, this.agent});

  Cashback.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    agent = json['agent'] != null ? Agent.fromJson(json['agent']) : null;
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

class Agent {
  int? type;
  dynamic value;

  Agent({this.type, this.value});

  Agent.fromJson(Map<String, dynamic> json) {
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

class Meta {
  int? items;
  int? total;
  int? next;
  int? prev;

  Meta({this.items, this.total, this.next, this.prev});

  Meta.fromJson(Map<String, dynamic> json) {
    items = json['items'];
    total = json['total'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = items;
    data['total'] = total;
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}
