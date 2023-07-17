import 'package:juba/models/offerdetailDTO.dart';

class JobTags {
  String? name;
  String? id;
  List<OfferDetailDto>? offers;

  JobTags({this.name, this.id, this.offers});

  JobTags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((v) {
        offers!.add(OfferDetailDto.fromJson(v));
      });
    }else{
      offers = [];
    }
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] =
        this.name;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    data['id'] =
        this.id;
    
    return data;
  }

}