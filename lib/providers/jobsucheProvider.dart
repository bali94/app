import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

import 'dart:async';
import 'dart:io';

class JobsucheProvider {
  static late final Map<String, dynamic> _decodedToken;
  static late final String _jwtToken;
  static late final dynamic jobOffersInWorms;
  static late final dynamic currentJobOfferDetails;

  static Future<String> getJwtToken() async {
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

    try {
      http.Response response = await http.post(
          Uri.parse(tokenUrl), headers: headers, body: credentials
      ).timeout(const Duration(seconds: 30));
      // check the response status
      if (response.statusCode == 200) {
        dynamic decodedResponseBody = json.decode(response.body);
        debugPrint('Response body: $decodedResponseBody');

        _decodedToken = JwtDecoder.decode(response.body);

        _jwtToken = decodedResponseBody['access_token'];
        return _jwtToken;
      } else {
        debugPrint(
            'JWT Token konnte nicht abgerufen werden: ${response.statusCode
                .toString()}');

        _jwtToken = 'could-not-get-token';
        return 'could-not-get-token';
      }
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: API-Aufruf hat Zeitfenster überschritten: $e');

      return 'api-timeout';
    } on SocketException catch (e) {
      debugPrint('SocketException: Verbindung zur API nicht möglich: $e');

      return 'api-connection-error';
    }
  }

  static Future<dynamic> getJobOffersInWorms() async {
    if (_jwtToken == 'could-not-get-token') {
      return 'missing-jwt-token';
    }

    final Map<String, String> headers = {
      HttpHeaders.userAgentHeader: 'Jugendberufsagentur Worms App',
      HttpHeaders.hostHeader: 'rest.arbeitsagentur.de',
      HttpHeaders.connectionHeader: 'keep-alive',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _jwtToken
    };
    const Map<String, String> params = {
      'wo': 'Worms',
      'pav': 'true',
      'size': '100',
      'page': '1'
    };

    final jobsUri = Uri.https(
        'rest.arbeitsagentur.de', '/jobboerse/jobsuche-service/pc/v4/jobs', params
    );
    debugPrint('jobsUri="${jobsUri.toString()}"');

    try {
      final response = await http.get(jobsUri, headers: headers)
          .timeout(const Duration(seconds: 30));
      // check the response status
      if (response.statusCode == 200) {
        dynamic jobOffers = json.decode(utf8.decode(response.bodyBytes));

        jobOffersInWorms = jobOffers;
        debugPrint('jobOffers="$jobOffersInWorms"');

        return jobOffers;
      } else {
        debugPrint(
            'Stellen konnten nicht abgerufen werden: ${response.statusCode
                .toString()}');

        jobOffersInWorms = 'could-not-get-job-offers';
        return 'could-not-get-job-offers';
      }
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: API-Aufruf hat Zeitfenster überschritten: $e');

      return 'api-timeout';
    } on SocketException catch (e) {
      debugPrint('SocketException: Verbindung zur API nicht möglich: $e');

      return 'api-connection-error';
    }
  }

  static Future<dynamic> getJobOfferDetailsInWorms(String hashId) async {
    // Retrieve new token after expiration
    if (JwtDecoder.isExpired(_jwtToken)) await getJwtToken();
    if (_jwtToken == 'could-not-get-token') return 'missing-jwt-token';

    final String jobDetailsUrl =
        'https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v2/jobdetails/${base64.encode(utf8.encode(hashId))}';
    debugPrint('Decoded Base64-HashId="${base64.encode(utf8.encode(hashId))}"');

    final Map<String, String> headers = {
      HttpHeaders.userAgentHeader: 'Jugendberufsagentur Worms App',
      HttpHeaders.hostHeader: 'rest.arbeitsagentur.de',
      HttpHeaders.connectionHeader: 'keep-alive',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _jwtToken
    };

    try {
      final response = await http.get(Uri.parse(jobDetailsUrl), headers: headers)
          .timeout(const Duration(seconds: 30));
      // check the response status
      if (response.statusCode == 200) {
        dynamic jobOfferDetails = json.decode(utf8.decode(response.bodyBytes));

        currentJobOfferDetails = jobOfferDetails;
        return jobOfferDetails;
      } else {
        debugPrint('Details zu der angegebenen Stelle konnten nicht abgerufen werden: ${response.statusCode.toString()}');

        return 'could-not-get-job-offer-details';
      }
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: API-Aufruf hat Zeitfenster überschritten: $e');

      return 'api-timeout';
    } on SocketException catch (e) {
      debugPrint('SocketException: Verbindung zur API nicht möglich: $e');

      return 'api-connection-error';
    }
  }

  /*
  static Future<void> getAllCompanyCoordsAndTotalNumberOfOffers() async {
    final jobOffers = await getJobOffersInWorms();

    final List<dynamic> companyCoords = jobOffers['stellenangebote'];
    companyCoords.forEach((e) => debugPrint(e.entries['arbeitsort']['koordinaten']['lat']));
  }

  static Future<dynamic> getCompanyLogo(String) async {

  }

  static Future<dynamic> getJobOfferContactDetails() async {

  }
   */
}