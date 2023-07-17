import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
Location _location = Location();
bool _locationServiceEnabled = false;
late PermissionStatus _locationPermissionGranted;
late LocationData _locationData;
late LatLng _currentLocation;
class MapHelper{
  Map<String , dynamic> data = {};
  Future<Map<String , dynamic>?> setInitialLocation() async {
    _locationData = await _location.getLocation();
    _currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
    data = {
      "location" : _locationData,
      "currentLocation" : _currentLocation,
    };
    print('Current Location: $_locationData');
    if (_locationData == null) return null;
    return data;
    /*
    _location.onLocationChanged.listen((LocationData newLocationData) {
      _currentLocation = LatLng(newLocationData.latitude!, newLocationData.longitude!);
      debugPrint('Location Changed: $newLocationData');
    });
     */
  }

  Future<void> startWebNavigation(LatLng currentLocation , LatLng? companyLocation) async {
    if (companyLocation == null) {
      log('Error: missing company coordinates');
      return;
    }
    var params = {
      'api': '1',
      'travelmode': 'driving',
      'layer': 'traffic',
      'dir_action': 'navigate',
      'origin': '${currentLocation.latitude},${currentLocation.longitude}',
      'destination': '${companyLocation.latitude},${companyLocation.longitude}',
    };
    final mapsUri = Uri.https(
        'www.google.com',
        '/maps/dir/',
        params
    );
    log('launch ${mapsUri.toString()} ...');
    if (!await launch(mapsUri.toString())) {
      throw 'could not launch ${mapsUri.toString()}';
    }
  }


}
