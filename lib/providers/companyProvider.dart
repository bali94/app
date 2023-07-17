import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:juba/models/company.dart';
import 'package:juba/models/companyDTO.dart';

final _companiesRef =
  FirebaseFirestore.instance.collection('companies').withConverter<Company>(
    fromFirestore: (snapshot, _) => Company.fromJson(snapshot.data()!),
    toFirestore: (company, _) => company.toJson(),
);

class CompanyProvider extends ChangeNotifier {

  Company? currentCompany;
  CompanyDTO? currentCompanyData;

  setCompanyDTO(CompanyDTO? companyDTO){
    currentCompanyData = companyDTO;
    notifyListeners();
  }


  createCompany(Company company) {
    _companiesRef.doc(company.hashId).set(company);
  }

  /*
  updateCompany() {
    _companiesRef.doc('7AoWZm4Nv0hKSevQtpxl').set(Company(

          employees: null,
          homeNumber: null,
          stars: null,
          name: "JuBA Worms",
          imageUrl: null,
          street: null,
          postCode: null,
          yearIncome: null,
          website: null,
          phone: null,
          latitude: 49.6347119,
          description: "Behörde",
          city: null,
          fullAddress: "Von-Steuben-Straße 6, 67549 Worms",
          email: null,
          id: "7AoWZm4Nv0hKSevQtpxl",
          longitude: 8.3527316,
          offers:[
            Offer(
                timestamp: "2022-02-16 08:24:39.732338",
                tasks: [
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet",
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet",
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet"
                ],
                remark: "ggg",
                yourProfile: [
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet",
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet",
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet"
                ],
                whatWeOffer: [
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet",
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet",
                  " Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet"
                ],
                description: "lala",
                title: "Ausbildung zum Fertigungsmechaniker (m/w/d)",
                category: "",
                appliers: [],
                type: 1,
                id: "wzf563567373-873773"
            )
          ]
>>>>>>> 640e85b03e5e42a25472f3130155eebe53a16180

  setCompanyDTO(CompanyDTO? companyDTO){
    currentCompanyData = companyDTO;
    notifyListeners();
  }
   */

  List<Company>? companies = <Company>[];


  getAllCompanies(String query) async {
    // clear list before assigning new values
    companies?.clear();

    final companiesRef = await _companiesRef.get();
    for (final companySnapshot in companiesRef.docs) {
      Company company = companySnapshot.data();

      companies?.add(company);
    }

    notifyListeners();
  }
}