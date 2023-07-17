import 'package:juba/models/user.dart';

class Comment {
  String? companyId;
  String? id;
  String? comment;
  User? user;

  Comment({this.companyId, this.id, this.comment, this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    id = json['id'];
    comment = json['comment'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['id'] = this.id;
    data['comment'] = this.comment;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

