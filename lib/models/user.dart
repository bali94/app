
import 'package:juba/models/jobTags.dart';
import 'package:juba/models/offerdetailDTO.dart';

class User {
  String? address;
  String? bio;
  String? dateOfBirth;
  bool? valid;
  String? photoUrl;
  String? email;
  String? displayName;
  String? notificationToken;
  String? id;
  String? yourResume;
  List<JobTags>? tags;
  List<OfferDetailDto>? yourFavoritesOffers;
  List<OfferDetailDto>? offersYouAppliedTo;
  bool? isAdmin;
  User(
      {this.address,
      this.tags,
      this.bio,
      this.dateOfBirth,
      this.valid,
      this.photoUrl,
      this.email,
      this.displayName,
      this.notificationToken,
      this.yourResume,
      this.id,
        this.isAdmin,
      this.offersYouAppliedTo,
      this.yourFavoritesOffers});

  User.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    bio = json['bio'];
    if (json['tags'] != null) {
    tags = [];
    json['tags'].forEach((v) {
    tags!.add(JobTags.fromJson(v));
    });
    }
    dateOfBirth = json['dateOfBirth'];
    valid = json['valid'];
    isAdmin = json['isAdmin'] ?? null;
    photoUrl = json['photoUrl'];
    email = json['email'];
    displayName = json['displayName'] == ''
        ? json['email'].substring(0, 3)
        : json['displayName'];
    yourResume =
        json['yourResume'] == '' ? 'No Resume added' : json['yourResume'];
    notificationToken = json['notificationToken'];
    id = json['id'];
    if (json['offersYouAppliedTo'] != null) {
      offersYouAppliedTo = [];
      json['offersYouAppliedTo'].forEach((v) {
        offersYouAppliedTo!.add(OfferDetailDto.fromJson(v));
      });
    }
    if (json['yourFavoritesOffers'] != null) {
      yourFavoritesOffers = [];
      json['yourFavoritesOffers'].forEach((v) {
        yourFavoritesOffers!.add(OfferDetailDto.fromJson(v));
      });
    }else{
    yourFavoritesOffers = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data['bio'] = bio;
    data['tags'] = tags;
    data['dateOfBirth'] = dateOfBirth;
    data['valid'] = valid;
    data['photoUrl'] = photoUrl;
    data['isAdmin'] = null;
    data['email'] = email;
    data['displayName'] = displayName;
    data['notificationToken'] = notificationToken;
    data['id'] = id;
    if (this.yourFavoritesOffers != null) {
      data['yourFavoritesOffers'] = this.yourFavoritesOffers!.map((v) => v.toJson()).toList();
    }
    if (this.offersYouAppliedTo != null) {
      data['offersYouAppliedTo'] = this.offersYouAppliedTo!.map((v) => v.toJson()).toList();
    }
    data['yourResume'] = yourResume;
    return data;
  }
}
