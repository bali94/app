
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:juba/models/comment.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/providers/offerProvider.dart';

class Company with ClusterItem {
  static Set<Company> companies = <Company>{};

  int? employees;
  String? hashId;
  ArbeitgeberAdresse? fullAddress;
  List<Comment>? comments;
  String? branche;
  String? website;
  String? name;
  double? latitude;
  String? city;
  String? postCode;
  String? description;
  String? yearIncome;
  int? stars;
  int? homeNumber;
  String? street;
  double? longitude;
  String? email;
  String? imageUrl;
  String? phone;
  List<OfferDetailDto>? offers;
  int? anzahlOffeneStellen;
  String? arbeitgeberHashId;

  Company(
      {this.employees,
        this.offers,
        this.fullAddress,
        this.branche,
        this.comments,
        this.website,
        this.name,
        this.latitude,
        this.city,
        this.postCode,
        this.description,
        this.yearIncome,
        this.stars,
        this.homeNumber,
        this.street,
        this.longitude,
        this.email,
        this.hashId,
        this.imageUrl,
        this.phone,
        this.anzahlOffeneStellen,
        this.arbeitgeberHashId});

  @override
  LatLng get location => LatLng(latitude!, longitude!);

  Company.fromJson(Map<String, dynamic> json) {
    employees = json['employees'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments!.add(Comment.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((v) {
        offers!.add( OfferDetailDto.fromJson(v));
      });
    }else{
      offers = [];
    }

    website = json['website'];
    name = json['name'];
    latitude = json['latitude'] != null ? json['latitude'].toDouble(): null;
    city = json['city'];
    postCode = json['postCode'];
    description = json['description'];
    yearIncome = json['yearIncome'];
    stars = json['stars'];
    hashId = json['hashId'];
    homeNumber = json['homeNumber'];
    street = json['street'];
    longitude = json['longitude'] != null ? json['longitude'].toDouble(): null;
    email = json['email'];
    imageUrl = json['imageUrl'];
    phone = json['phone'];
    anzahlOffeneStellen = json['anzahlOffeneStellen'];
    branche = json['branche'];
    arbeitgeberHashId = json['arbeitgeberHashId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employees'] = this.employees;
    data['fullAddress'] = this.fullAddress;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['website'] = this.website;
    data['hashId'] = this.hashId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['city'] = this.city;
    data['postCode'] = this.postCode;
    data['description'] = this.description;
    data['yearIncome'] = this.yearIncome;
    data['branche'] = this.branche;
    data['stars'] = this.stars;
    data['homeNumber'] = this.homeNumber;
    data['street'] = this.street;
    data['longitude'] = this.longitude;
    data['email'] = this.email;
    data['imageUrl'] = this.imageUrl;
    data['phone'] = this.phone;
    data['anzahlOffeneStellen'] = this.anzahlOffeneStellen;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    data['arbeitgeberHashId'] = this.arbeitgeberHashId;
    return data;
  }

  static Future<int?> extractCompaniesFromOffers() async {
    // don't fetch if companies are already loaded
    if (companies.isNotEmpty) return companies.length;
    final offers = await OfferProvider().fetchOffers();
    if (offers == null) return null;
    log('len(offers)=${offers.length.toString()}');

    Set<LatLng> distinctCoords = <LatLng>{};
    for (final offer in offers) {
      final List<Arbeitsorte>? arbeitsorte = offer.arbeitsorte;
      // skip offer
      if (arbeitsorte == null || offer.anzahlOffeneStellen == 0) continue;

      Arbeitsorte? arbeitsOrtMitStelleInWorms;
      double? companyLat, companyLon;
      var hatStelleInWorms = false;
      for (final arbeitsort in arbeitsorte) {
        // filter if company has offer(s) in Worms
        if (!arbeitsort.containsNull() && arbeitsort.ort == 'Worms') {
          hatStelleInWorms = true;
          arbeitsOrtMitStelleInWorms = arbeitsort;
          // set coords
          companyLat = arbeitsort.koordinaten?.lat;
          companyLon = arbeitsort.koordinaten?.lon;
          // skip loop if arbeitsort in Worms found
          break;
        }
      }
      // add company if it has offer(s) in Worms
      if (hatStelleInWorms && distinctCoords.add(LatLng(companyLat!, companyLon!))) {
        // Set only adds unique companies
        companies.add(
            Company(
              arbeitgeberHashId: offer.arbeitgeberHashId,
              name: offer.arbeitgeber,
              branche: offer.branche,
              // replace address of company with address from offer in Worms
              fullAddress: ArbeitgeberAdresse(
                  plz: arbeitsOrtMitStelleInWorms?.plz,
                  ort: arbeitsOrtMitStelleInWorms?.ort,
                  strasse: arbeitsOrtMitStelleInWorms?.strasse
              ),
              latitude: companyLat,
              longitude: companyLon,
            )
        );

        /*
        final addedCompany = Company(
          arbeitgeberHashId: offer.arbeitgeberHashId,
          name: offer.arbeitgeber,
          branche: offer.branche,
          fullAddress: ArbeitgeberAdresse(
              plz: arbeitsOrtMitStelleInWorms?.plz,
              ort: arbeitsOrtMitStelleInWorms?.ort,
              strasse: arbeitsOrtMitStelleInWorms?.strasse
          ),
          latitude: companyLat,
          longitude: companyLon,
        );
         */

        //log('${addedCompany.fullAddressToString()} has been added');
        //log('${addedCompany.name}: lat=${addedCompany.latitude}, lon=${addedCompany.longitude}');
      }
    }

    _sortCompaniesAlphabetically();
    log('Companies loaded from real data: ${companies.length.toString()}');
    //log('--- Ende ---');
    return companies.length;
  }

  static void _sortCompaniesAlphabetically() {
    final companyList = companies.toList()..sort((companyA, companyB) =>
        companyA.name!.compareTo(companyB.name!)
    );
    companies = companyList.toSet();
  }

  String? fullAddressToString() {
    if (fullAddress?.strasse == null || fullAddress?.plz == null || fullAddress?.ort == null) {
      return null;
    }

    return '${fullAddress!.strasse}, ${fullAddress!.plz} ${fullAddress!.ort}';
  }
}