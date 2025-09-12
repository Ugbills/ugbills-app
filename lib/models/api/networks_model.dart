class NetworksModel {
  int? code;
  bool? success;
  String? message;
  List<Data>? data;

  NetworksModel({this.code, this.success, this.message, this.data});

  NetworksModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? icon;
  String? swapNumber;
  int? swapPercent;

  Data({this.id, this.name, this.icon, this.swapNumber, this.swapPercent});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    swapNumber = json['swap_number'];
    swapPercent = json['swap_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['swap_number'] = swapNumber;
    data['swap_percent'] = swapPercent;
    return data;
  }
}
