import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:juba/models/offerdetailDTO.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import '../models/companyDTO.dart';
class ApiHelper {
  static late final Map<String, dynamic> _decodedToken;
  static late String? _jwtToken;
  static late final dynamic jobOffersInWorms;
  static late final dynamic currentJobOfferDetails;
  List<OfferDetailDto> stellen = [];
   Future<String> getJwtToken() async {
     _jwtToken = null;
    const String tokenUrl = 'https://rest.arbeitsagentur.de/oauth/gettoken_cc';
    const Map<String, String> headers = {
      HttpHeaders.userAgentHeader: 'Jugendberufsagentur Worms App',
      HttpHeaders.hostHeader: 'rest.arbeitsagentur.de',
      HttpHeaders.connectionHeader: 'keep-alive',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=utf-8',
    };
    const Map<String, String> credentials = {
      'client_id': '383f42ae-02ec-40e9-9c15-374470ba720b',
      'client_secret': 'ed115668-f6dd-4885-ba6b-0ab9eb496791',
      'grant_type': 'client_credentials'
    };
    http.Response response = await http.post(
        Uri.parse(tokenUrl), headers: headers, body: credentials
    );
    // check the response status
    if (response.statusCode == 200) {
      dynamic decodedResponseBody = json.decode(response.body);
      debugPrint('Response body: $decodedResponseBody');
      _jwtToken = decodedResponseBody['access_token'];
      return _jwtToken!;
    } else {
      debugPrint('JWT Token konnte nicht abgerufen werden: ${response.statusCode.toString()}');
      _jwtToken = 'could-not-get-token';
      return 'could-not-get-token';
    }
  }
  Future<dynamic> getCompanyData(dynamic res, String hashId, String captcha) async {
    try{
      if (_jwtToken == 'could-not-get-token') {
        return null;
      }
      final Map<String, String> headers = {
        "Content-type": 'application/json',
        "Authorization": _jwtToken!,
        "aas-answer": captcha,
        "aas-info": "sessionId=${res["sessionId"]},challengeId=${res["challengeId"]}",
      };
      final jobsUri = Uri.https(
          'rest.arbeitsagentur.de', '/jobboerse/jobsuche-service/pc/v2/jobs/${base64.encode(utf8. encode(hashId))}/bewerbung'
      );
      debugPrint('jobsUri="${jobsUri.toString()}"');
      final response = await http.get(jobsUri, headers: headers,);
      // check the response status
      if (response.statusCode == 200) {
        dynamic data = json.decode(utf8.decode(response.bodyBytes));
        CompanyDTO companyDTO = CompanyDTO.fromJson(data);
        return companyDTO;
      } else {
        debugPrint('fehler aufgetreten: ${response.statusCode.toString()}, ${response.reasonPhrase}');
        return null;
      }
    }catch(e){
      print('err is $e');
      return null;
    }

  }

  Future<List<OfferDetailDto>> fetchJobs() async {
    int i = 0;
    List<OfferDetailDto> list= [];
    // ignore: prefer_is_empty
    while(stellen.length >= 0){
      if(list.isNotEmpty){
        for(var stl in list) {
          stellen.add(stl);
        }
      }
      i++;
      list =  await getJobOffersInWorms(i, 100, null);
      if(list.isEmpty){
        return stellen;
      }
    }
    return stellen;
  }
  Future<dynamic> getChallengeId() async {
    try{
      if (_jwtToken == 'could-not-get-token') {
        return null;
      }
      final Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: _jwtToken!
      };


      final jobsUri = Uri.https(
          'rest.arbeitsagentur.de', '/idaas/id-aas-service/pc/v1/assignment/',
      );
      debugPrint('jobsUri="${jobsUri.toString()}"');

      final response = await http.post(jobsUri, headers: headers,
          body: json.encode({"formId":"ARBEITGEBERDATEN","formProtectionLevel": "JB_JOBSUCHE_10"}));
      // check the response status
      if (response.statusCode == 200) {
        dynamic res = json.decode(utf8.decode(response.bodyBytes));
        if(res != null ){
          return res;
        }else{
          return null;
        }
      } else {
        debugPrint('fehler aufgetreten: ${response.statusCode.toString()}');
      }
    }catch(e){
      print('err is $e');
      return null;
    }

  }
  Future<dynamic> getCaptcha(dynamic res) async {
    try{
      if (_jwtToken == 'could-not-get-token') {
        return null;
      }
      final Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: _jwtToken!
      };
      final jobsUri = Uri.https(
        'rest.arbeitsagentur.de', '/idaas/id-aas-service/ct/v1/captcha/${res['challengeId']}?type=image&languageIso639Code=de',
      );
      debugPrint('jobsUri="${jobsUri.toString()}"');

      final response = await http.get(jobsUri, headers: headers,);
      // check the response status
      if (response.statusCode == 200) {
        Uint8List? res = response.bodyBytes;
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path + "/${DateTime.now()}.png";
        File imageFile = File(tempPath);
        if(! await imageFile.exists()){
          imageFile.create(recursive: true); }
        imageFile.writeAsBytes(res);
        if(imageFile != null ){
          return imageFile;
        }else{
          return null;
        }
      } else {
        debugPrint('fehler aufgetreten: ${response.statusCode.toString()}');
      }
    }catch(e){
      print('err is $e');
      return null;
    }

  }
  Future<List<OfferDetailDto>> getJobOffersInWorms(int? val, int size, String? query) async {
    try{
      await getJwtToken();
      final Map<String, String> headers = {
        HttpHeaders.userAgentHeader: 'Jugendberufsagentur Worms App',
        HttpHeaders.hostHeader: 'rest.arbeitsagentur.de',
        HttpHeaders.connectionHeader: 'keep-alive',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: _jwtToken!
      };
      Map<String, String> params = {
        'was': '$query',
        'wo': 'Worms',
        'pav': 'true',
        'size': '$size',
        //'page': '$val'
      };

      final jobsUri = Uri.https(
          'rest.arbeitsagentur.de', '/jobboerse/jobsuche-service/pc/v4/jobs',params
      );
      debugPrint('jobsUri="${jobsUri.toString()}"');

      final response = await http.get(jobsUri, headers: headers,);
      // check the response status
      if (response.statusCode == 200) {
        dynamic jobOffers = json.decode(utf8.decode(response.bodyBytes));
        if(jobOffers != null ){
          return (jobOffers['stellenangebote'] as List).map((i) => OfferDetailDto.fromJson(i)).toList();
        }else{
          return [];
        }
      } else {
        debugPrint('Stellen konnten nicht abgerufen werden: ${response.statusCode.toString()}');
        jobOffersInWorms = 'could-not-get-job-offers';
        return [];
      }
    }catch(e){
      print('err is $e');
      return [];
    }

  }

   Future<OfferDetailDto?> getJobOfferDetailsInWorms(
      {String hashId = 'UAHLm0-WmQqgZqCBE8kvi9oJevvgZYZ7-sM0J3EQttM='}) async {
    // Retrieve new token after expiration
   //  await getJwtToken();
    if (_jwtToken == 'could-not-get-token') return null;

    final String jobDetailsUrl =
        'https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v2/jobdetails/${base64.encode(utf8. encode(hashId))}';
    debugPrint('Decoded Base64-HashId="${base64.encode(utf8.encode(hashId))}"');

    final Map<String, String> headers = {
      HttpHeaders.userAgentHeader: 'Jugendberufsagentur Worms App',
      HttpHeaders.hostHeader: 'rest.arbeitsagentur.de',
      HttpHeaders.connectionHeader: 'keep-alive',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _jwtToken!
    };
    final response = await http.get(Uri.parse(jobDetailsUrl), headers: headers);
    // check the response status
    if (response.statusCode == 200) {
      dynamic jobOfferDetails = json.decode(utf8.decode(response.bodyBytes));
      OfferDetailDto dtoDetail = OfferDetailDto.fromJson(jobOfferDetails);
      return dtoDetail;
    } else {
      debugPrint(
          'Details zu der angegebenen Stelle konnten nicht abgerufen werden: ${response.statusCode.toString()}');
      return null;
    }
  }

/*
  static Future<void> getAllCompanyCoordsAndTotalNumberOfOffers() async {
    final jobOffers = await getJobOffersInWorms();

    final List<dynamic> companyCoords = jobOffers['angebote'];
    companyCoords.forEach((e) => debugPrint(e.entries['arbeitsort']['koordinaten']['lat']));
  }

  static Future<dynamic> getCompanyLogo(String ) async {

  }

  static Future<dynamic> getJobOfferContactDetails() async {

  }
   */
}
