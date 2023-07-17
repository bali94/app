
class Message {
  String? messageId;
  String? name;
  String? message;
  String? phone;
  String? email;
  String? timestamp;
  String? regard;

  Message({this.messageId,
    this.name,
    this.message,
    this.email,
    this.phone,
    this.timestamp,
    this.regard,
  });

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    phone = json['phone'];
    name = json['name'];
    message = json['message'];
    email = json['email'];
    timestamp = json['timestamp'];
    regard = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['name'] = this.name;
    data['message'] = this.message;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['timestamp'] = timestamp;
    data['regard'] = regard;
    return data;
  }
}

