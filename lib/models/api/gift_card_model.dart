class GiftCardsModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  GiftCardsModel({this.success, this.message, this.code, this.data});

  GiftCardsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Content>? content;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  bool? first;
  Sort? sort;
  int? numberOfElements;
  int? size;
  int? number;
  bool? empty;

  Data(
      {this.content,
      this.pageable,
      this.totalElements,
      this.totalPages,
      this.last,
      this.first,
      this.sort,
      this.numberOfElements,
      this.size,
      this.number,
      this.empty});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    first = json['first'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
    data['last'] = last;
    data['first'] = first;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['numberOfElements'] = numberOfElements;
    data['size'] = size;
    data['number'] = number;
    data['empty'] = empty;
    return data;
  }
}

class Content {
  int? productId;
  String? productName;
  bool? global;
  bool? supportsPreOrder;
  dynamic senderFee;
  dynamic senderFeePercentage;
  dynamic discountPercentage;
  String? denominationType;
  String? recipientCurrencyCode;
  dynamic minRecipientDenomination;
  dynamic maxRecipientDenomination;
  String? senderCurrencyCode;
  dynamic minSenderDenomination;
  dynamic maxSenderDenomination;
  List<int>? fixedRecipientDenominations;
  List<int>? fixedSenderDenominations;
  FixedRecipientToSenderDenominationsMap?
      fixedRecipientToSenderDenominationsMap;
  Metadata? metadata;
  List<String>? logoUrls;
  Brand? brand;
  Category? category;
  Country? country;
  RedeemInstruction? redeemInstruction;

  Content(
      {this.productId,
      this.productName,
      this.global,
      this.supportsPreOrder,
      this.senderFee,
      this.senderFeePercentage,
      this.discountPercentage,
      this.denominationType,
      this.recipientCurrencyCode,
      this.minRecipientDenomination,
      this.maxRecipientDenomination,
      this.senderCurrencyCode,
      this.minSenderDenomination,
      this.maxSenderDenomination,
      this.fixedRecipientDenominations,
      this.fixedSenderDenominations,
      this.fixedRecipientToSenderDenominationsMap,
      this.metadata,
      this.logoUrls,
      this.brand,
      this.category,
      this.country,
      this.redeemInstruction});

  Content.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    global = json['global'];
    supportsPreOrder = json['supportsPreOrder'];
    senderFee = json['senderFee'];
    senderFeePercentage = json['senderFeePercentage'];
    discountPercentage = json['discountPercentage'];
    denominationType = json['denominationType'];
    recipientCurrencyCode = json['recipientCurrencyCode'];
    minRecipientDenomination = json['minRecipientDenomination'];
    maxRecipientDenomination = json['maxRecipientDenomination'];
    senderCurrencyCode = json['senderCurrencyCode'];
    minSenderDenomination = json['minSenderDenomination'];
    maxSenderDenomination = json['maxSenderDenomination'];
    fixedRecipientDenominations =
        json['fixedRecipientDenominations'].cast<int>();
    fixedSenderDenominations = json['fixedSenderDenominations'].cast<int>();
    fixedRecipientToSenderDenominationsMap =
        json['fixedRecipientToSenderDenominationsMap'] != null
            ? FixedRecipientToSenderDenominationsMap.fromJson(
                json['fixedRecipientToSenderDenominationsMap'])
            : null;
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    logoUrls = json['logoUrls'].cast<String>();
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    redeemInstruction = json['redeemInstruction'] != null
        ? RedeemInstruction.fromJson(json['redeemInstruction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['global'] = global;
    data['supportsPreOrder'] = supportsPreOrder;
    data['senderFee'] = senderFee;
    data['senderFeePercentage'] = senderFeePercentage;
    data['discountPercentage'] = discountPercentage;
    data['denominationType'] = denominationType;
    data['recipientCurrencyCode'] = recipientCurrencyCode;
    data['minRecipientDenomination'] = minRecipientDenomination;
    data['maxRecipientDenomination'] = maxRecipientDenomination;
    data['senderCurrencyCode'] = senderCurrencyCode;
    data['minSenderDenomination'] = minSenderDenomination;
    data['maxSenderDenomination'] = maxSenderDenomination;
    data['fixedRecipientDenominations'] = fixedRecipientDenominations;
    data['fixedSenderDenominations'] = fixedSenderDenominations;
    if (fixedRecipientToSenderDenominationsMap != null) {
      data['fixedRecipientToSenderDenominationsMap'] =
          fixedRecipientToSenderDenominationsMap!.toJson();
    }
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['logoUrls'] = logoUrls;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (redeemInstruction != null) {
      data['redeemInstruction'] = redeemInstruction!.toJson();
    }
    return data;
  }
}

class FixedRecipientToSenderDenominationsMap {
  dynamic i200;
  dynamic i500;
  dynamic i1000;
  dynamic i1199;
  dynamic i9499;
  dynamic i4199;
  dynamic i2699;
  dynamic i10;
  dynamic i20;
  dynamic i50;
  dynamic i100;
  dynamic i2499;
  dynamic i250;
  dynamic i15;
  dynamic i425;
  dynamic i75;
  dynamic i110;
  dynamic i160;
  dynamic i240;
  dynamic i320;
  dynamic i700;
  dynamic i840;
  dynamic i02;
  dynamic i099;
  dynamic i499;
  dynamic i999;
  dynamic d1999;
  dynamic d2999;
  dynamic i4999;
  dynamic i9999;
  dynamic i65;
  dynamic i130;
  dynamic i150;
  dynamic i800;
  dynamic i299;
  dynamic i1499;
  dynamic i699;
  dynamic d1299;
  dynamic d3899;
  dynamic d5999;

  FixedRecipientToSenderDenominationsMap(
      {this.i200,
      this.i500,
      this.i1000,
      this.i1199,
      this.i9499,
      this.i4199,
      this.i2699,
      this.i10,
      this.i20,
      this.i50,
      this.i100,
      this.i2499,
      this.i250,
      this.i15,
      this.i425,
      this.i75,
      this.i110,
      this.i160,
      this.i240,
      this.i320,
      this.i700,
      this.i840,
      this.i02,
      this.i099,
      this.i499,
      this.i999,
      this.d1999,
      this.d2999,
      this.i4999,
      this.i9999,
      this.i65,
      this.i130,
      this.i150,
      this.i800,
      this.i299,
      this.i1499,
      this.i699,
      this.d1299,
      this.d3899,
      this.d5999});

  FixedRecipientToSenderDenominationsMap.fromJson(Map<String, dynamic> json) {
    i200 = json['20.0'];
    i500 = json['50.0'];
    i1000 = json['100.0'];
    i1199 = json['11.99'];
    i9499 = json['94.99'];
    i4199 = json['41.99'];
    i2699 = json['26.99'];
    i10 = json['1.0'];
    i20 = json['2.0'];
    i50 = json['5.0'];
    i100 = json['10.0'];
    i2499 = json['24.99'];
    i250 = json['25.0'];
    i15 = json['1.5'];
    i425 = json['4.25'];
    i75 = json['7.5'];
    i110 = json['11.0'];
    i160 = json['16.0'];
    i240 = json['24.0'];
    i320 = json['32.0'];
    i700 = json['70.0'];
    i840 = json['84.0'];
    i02 = json['0.2'];
    i099 = json['0.99'];
    i499 = json['4.99'];
    i999 = json['9.99'];
    d1999 = json['19.99'];
    d2999 = json['29.99'];
    i4999 = json['49.99'];
    i9999 = json['99.99'];
    i65 = json['6.5'];
    i130 = json['13.0'];
    i150 = json['15.0'];
    i800 = json['80.0'];
    i299 = json['2.99'];
    i1499 = json['14.99'];
    i699 = json['6.99'];
    d1299 = json['12.99'];
    d3899 = json['38.99'];
    d5999 = json['59.99'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['20.0'] = i200;
    data['50.0'] = i500;
    data['100.0'] = i1000;
    data['11.99'] = i1199;
    data['94.99'] = i9499;
    data['41.99'] = i4199;
    data['26.99'] = i2699;
    data['1.0'] = i10;
    data['2.0'] = i20;
    data['5.0'] = i50;
    data['10.0'] = i100;
    data['24.99'] = i2499;
    data['25.0'] = i250;
    data['1.5'] = i15;
    data['4.25'] = i425;
    data['7.5'] = i75;
    data['11.0'] = i110;
    data['16.0'] = i160;
    data['24.0'] = i240;
    data['32.0'] = i320;
    data['70.0'] = i700;
    data['84.0'] = i840;
    data['0.2'] = i02;
    data['0.99'] = i099;
    data['4.99'] = i499;
    data['9.99'] = i999;
    data['19.99'] = d1999;
    data['29.99'] = d2999;
    data['49.99'] = i4999;
    data['99.99'] = i9999;
    data['6.5'] = i65;
    data['13.0'] = i130;
    data['15.0'] = i150;
    data['80.0'] = i800;
    data['2.99'] = i299;
    data['14.99'] = i1499;
    data['6.99'] = i699;
    data['12.99'] = d1299;
    data['38.99'] = d3899;
    data['59.99'] = d5999;
    return data;
  }
}

class Metadata {
  String? s1199;
  String? s9499;
  String? s4199;
  String? s2699;
  String? s15;
  String? s425;
  String? s75;
  String? s110;
  String? s160;
  String? s240;
  String? s320;
  String? s500;
  String? s700;
  String? s840;
  String? s099;
  String? s499;
  String? s999;
  String? s1999;
  String? s2999;
  String? s4999;
  String? s9999;

  Metadata(
      {this.s1199,
      this.s9499,
      this.s4199,
      this.s2699,
      this.s15,
      this.s425,
      this.s75,
      this.s110,
      this.s160,
      this.s240,
      this.s320,
      this.s500,
      this.s700,
      this.s840,
      this.s099,
      this.s499,
      this.s999,
      this.s1999,
      this.s2999,
      this.s4999,
      this.s9999});

  Metadata.fromJson(Map<String, dynamic> json) {
    s1199 = json['11.99'];
    s9499 = json['94.99'];
    s4199 = json['41.99'];
    s2699 = json['26.99'];
    s15 = json['1.5'];
    s425 = json['4.25'];
    s75 = json['7.5'];
    s110 = json['11.0'];
    s160 = json['16.0'];
    s240 = json['24.0'];
    s320 = json['32.0'];
    s500 = json['50.0'];
    s700 = json['70.0'];
    s840 = json['84.0'];
    s099 = json['0.99'];
    s499 = json['4.99'];
    s999 = json['9.99'];
    s1999 = json['19.99'];
    s2999 = json['29.99'];
    s4999 = json['49.99'];
    s9999 = json['99.99'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['11.99'] = s1199;
    data['94.99'] = s9499;
    data['41.99'] = s4199;
    data['26.99'] = s2699;
    data['1.5'] = s15;
    data['4.25'] = s425;
    data['7.5'] = s75;
    data['11.0'] = s110;
    data['16.0'] = s160;
    data['24.0'] = s240;
    data['32.0'] = s320;
    data['50.0'] = s500;
    data['70.0'] = s700;
    data['84.0'] = s840;
    data['0.99'] = s099;
    data['4.99'] = s499;
    data['9.99'] = s999;
    data['19.99'] = s1999;
    data['29.99'] = s2999;
    data['49.99'] = s4999;
    data['99.99'] = s9999;
    return data;
  }
}

class Brand {
  int? brandId;
  String? brandName;

  Brand({this.brandId, this.brandName});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    brandName = json['brandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Country {
  String? isoName;
  String? name;
  String? flagUrl;

  Country({this.isoName, this.name, this.flagUrl});

  Country.fromJson(Map<String, dynamic> json) {
    isoName = json['isoName'];
    name = json['name'];
    flagUrl = json['flagUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isoName'] = isoName;
    data['name'] = name;
    data['flagUrl'] = flagUrl;
    return data;
  }
}

class RedeemInstruction {
  String? concise;
  String? verbose;

  RedeemInstruction({this.concise, this.verbose});

  RedeemInstruction.fromJson(Map<String, dynamic> json) {
    concise = json['concise'];
    verbose = json['verbose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['concise'] = concise;
    data['verbose'] = verbose;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? unpaged;
  bool? paged;

  Pageable(
      {this.sort,
      this.pageNumber,
      this.pageSize,
      this.offset,
      this.unpaged,
      this.paged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['offset'] = offset;
    data['unpaged'] = unpaged;
    data['paged'] = paged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    data['empty'] = empty;
    return data;
  }
}
