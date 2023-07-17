import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/company.dart';
import 'package:juba/models/jobTags.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/models/user.dart';

import '../models/jobTags.dart';


final jobTagsOffersDatasRef =
    FirebaseFirestore.instance.collection('TagsOffers').withConverter<JobTags>(
          fromFirestore: (snapshot, _) => JobTags.fromJson(snapshot.data()!),
          toFirestore: (name, _) => name.toJson(),
        );

final fullOffersDatasRef = FirebaseFirestore.instance
    .collection('FullOffersDatas')
    .withConverter<OfferDetailDto>(
      fromFirestore: (snapshot, _) => OfferDetailDto.fromJson(snapshot.data()!),
      toFirestore: (stelle, _) => stelle.toJson(),
    );
final apiDatasRef = FirebaseFirestore.instance
    .collection('ApiJobDetails')
    .withConverter<OfferDetailDto>(
      fromFirestore: (snapshot, _) => OfferDetailDto.fromJson(snapshot.data()!),
      toFirestore: (stelle, _) => stelle.toJson(),
    );

class OfferProvider extends ChangeNotifier {
  static TextEditingController queryCtrl = TextEditingController();


  List<String>? tags;
  List<OfferDetailDto> tagOffers = [];

  List<OfferDetailDto>? stellen;
  List<OfferDetailDto>? topTenOffers;

  String sortBy = 'aktuelleVeroeffentlichungsdatum';
  String? searchQuery;
  setSortQuery(String query) {
    sortBy = query;
    notifyListeners();
  }

  setTags(List<String> list) {
    tags = list;
    notifyListeners();
  }
  setTagsOffers() {
    tagOffers = [];
    WidgetsBinding.instance!.addPostFrameCallback((_) => notifyListeners());
  }

  setSearchQuery(String? query) {
    searchQuery = query;
    notifyListeners();
  }



  Future<List<OfferDetailDto>?> fetchOffers({String? companyName, int limit = 0}) async {
    List<OfferDetailDto> stls = [];
    final stelle;
    if (limit > 0) {
      stelle = await fullOffersDatasRef
          .orderBy(sortBy,
              descending: sortBy == 'eintrittsdatum' ||
                      sortBy == 'aktuelleVeroeffentlichungsdatum' ||
                      sortBy == 'betriebsgroesse'
                  ? true
                  : false)
          .limit(limit)
          .get();
    } else {
      stelle = await fullOffersDatasRef.get();
    }

    for (var e in stelle.docs) {
      OfferDetailDto stl = e.data();
      stls.add(stl);
    }

    // return stls;
    if (companyName != null) return stls.where((element) => element.arbeitgeber!.toLowerCase().contains(companyName.toLowerCase())).toList();
    var st = searchQuery == null
        ? stls
        : stls.where((element) =>
            element.titel!.toLowerCase().contains(searchQuery!.toLowerCase()) ||
            element.arbeitgeber!
                .toLowerCase()
                .contains(searchQuery!.toLowerCase()));
    stellen = st.toList();
    notifyListeners();
    return stellen;
  }

  Future<List<JobTags>?> fetchTagsAndOffers(String? query) async {

    List<JobTags> jtags = [];
    var myTags = await jobTagsOffersDatasRef.orderBy('name').get();
    for (var e in myTags.docs) {
      JobTags tgs = e.data();
      jtags.add(tgs);
    }
    var newList = query == null || query == ''
        ? jtags
        : jtags.where(
            (element) => element.name!.toLowerCase().contains(query.toLowerCase()));
    return newList.toList();
  }
  Future <void> getTagJobsById(String? id) async  {
    if(id != null){
      dynamic tagJbs = await jobTagsOffersDatasRef.doc(id).get().then((snapshot) => snapshot.data()!);
      tagOffers = tagJbs.offers;
      notifyListeners();
    }

  }
  Future <void> fetchTagJobsByMultipleId(List<JobTags> jbTags) async  {
    for(var jt in jbTags){
      dynamic tagJbs = await jobTagsOffersDatasRef.doc(jt.id).get().then((snapshot) => snapshot.data()!);
      tagOffers += tagJbs.offers!;
    }
    notifyListeners();
    tagOffers;
  }

  Future<List<dynamic>?> sortOffersList(
      int sortNumber, List<dynamic> list) async {
    switch (sortNumber) {
      case 1:
        return sortOffersByName(list);
      case 2:
        return sortOffersByDate(list);
      case 3:
        return sortOffersByPublishDate(list);
      case 4:
        return sortOffersByName(list);
    }
  }

  Future< List<OfferDetailDto>> topTenOffer(User? user) async {
    List<OfferDetailDto> topTenList = [];
    List<OfferDetailDto> stls = [];
    var stelle = await fullOffersDatasRef.get();
    for (var e in stelle.docs) {
      OfferDetailDto stl = e.data();
      stls.add(stl);
    }
    List<dynamic> m_Offers = sortedListByCompanyName(stls);
    if (user?.tags == null || user?.tags!.isEmpty == true) {
      topTenOffers = getTenLastOffers(m_Offers);
      return topTenOffers!;
    }
    List<dynamic> tags = sortedListByString(user!.tags!);
    for (var tag in tags) {
      for (var offer in m_Offers) {
        if (topTenList.length <= 10) {
          if (offer.beruf == tag) {
            topTenList.add(offer);
          }
        } else {
          break;
        }
      }
    }
    topTenOffers = topTenList.isNotEmpty == true ? topTenList: getTenLastOffers(m_Offers);
    notifyListeners();
    return topTenOffers!;
  }
  List<OfferDetailDto> getTenLastOffers( List<dynamic> list ){
    List<OfferDetailDto> lst = [];
    for (var offer in list) {
      if (lst.length <= 10) {
        lst.add(offer);
      } else {
        return lst;
      }
    }
    return lst;
  }
  List<dynamic> sortOffersByName(List<dynamic> list) {
    List<dynamic> myList = list;
    list.sort((a, b) => a.arbeitgeber!.compareTo(b.arbeitgeber!));
    return myList;
  }

  List<dynamic> sortOffersByPublishDate(List<dynamic> list) {
    List<dynamic> myList = list;
    list.sort((a, b) => DateTime.parse(a.aktuelleVeroeffentlichungsdatum!)
        .compareTo(DateTime.parse(b.aktuelleVeroeffentlichungsdatum!)));
    return myList;
  }

  List<dynamic> sortedListByCompanyName(List<dynamic> list) {
    List<dynamic> myList = list;
    list.sort((a, b) => a.beruf!.compareTo(b.beruf!));
    return myList;
  }

  List<dynamic> sortedListByString(List<dynamic> list) {
    List<dynamic> myList = list;
    list.sort((a, b) => a.compareTo(b));
    return myList;
  }

  List<dynamic> sortOffersByDate(List<dynamic> list) {
    List<dynamic> myList = list;
    list.sort((a, b) =>
        DateTime.parse(a.timestamp!).compareTo(DateTime.parse(b.timestamp!)));
    return myList;
  }
}
