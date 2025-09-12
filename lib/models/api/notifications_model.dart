class NotificationsModel {
  int? code;
  bool? success;
  String? message;
  List<Data>? data;

  NotificationsModel({this.code, this.success, this.message, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? date;
  String? type;
  String? status;
  dynamic requestId;
  dynamic senderId;
  dynamic receiverId;

  Data(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.type,
      this.status,
      this.requestId,
      this.senderId,
      this.receiverId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    type = json['type'];
    status = json['status'];
    requestId = json['request_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['type'] = type;
    data['status'] = status;
    data['request_id'] = requestId;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    return data;
  }
}
