import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:juba/constants.dart' as Constants;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/pages/homepage.dart';
import 'package:juba/pages/nav2/components/custom_drawer_widget.dart';
import 'package:juba/pages/nav2/components/offers/offersList.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:location/location.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:characters/characters.dart';

import '../../../models/company.dart';

// constants required by Google Maps
const LatLng SOURCE_LOCATION = LatLng(49.634756, 8.3546574); // Worms Hbf
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 75;
const double CAMERA_BEARING = 15;

class CompanyMap extends StatefulWidget {
  const CompanyMap({Key? key}) : super(key: key);

  @override
  _CompanyMapState createState() => _CompanyMapState();
}

class _CompanyMapState extends State<CompanyMap> {
  // controlling single instance of google maps
  static late GoogleMapController _googleMapController;
  final Completer<GoogleMapController> _controller = Completer();
  // icons and markers
  BitmapDescriptor? _startIcon;
  Set<BitmapDescriptor> _companyIcons = <BitmapDescriptor>{};
  Set<Circle> _circles = <Circle>{};
  Set<Marker> _markers = <Marker>{};
  // location
  Location _location = Location();
  bool _locationServiceEnabled = false;
  PermissionStatus? _locationPermissionGranted;
  LocationData? _locationData;
  LatLng? _currentLocation;
  // companies
  ClusterManager<Company>? _clusterManager;
  Set<Company>? _selectedCompanyCluster;
  // company info window
  double _customInfoWindowPos = -1000;
  double _customInfoWindowOpacity = 0;
  bool _infoWindowActive = false;
  int _clusterSize = 0;
  // for future builder
  late Future<bool> _asyncDataLoaded;
  // normal custom info window
  //final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    _asyncDataLoaded = fetchAsyncData();
  }

  @override
  void dispose() {
    //_customInfoWindowController.dispose();
    _googleMapController.dispose();
    super.dispose();
  }

  Future<bool> fetchAsyncData() async {
    final amountOfCompanies = await Company.extractCompaniesFromOffers();
    final currentLocation = await fetchLocation();
    _setUpClusterManager();

    if (amountOfCompanies != null && currentLocation != null) return true;
    return false;
  }

  Future<LatLng?> fetchLocation() async {
    _locationServiceEnabled = await _location.serviceEnabled();
    if (!_locationServiceEnabled) {
      _locationServiceEnabled = await _location.requestService();
      if (!_locationServiceEnabled) {
        GlobalWidgets().snackbar(
            context,
            'Um zu sehen, wo du dich gerade befindest, aktiviere deinen Standort',
            Colors.red
        );
        return null;
      }
    }
    _locationPermissionGranted = await _location.hasPermission();
    if (_locationPermissionGranted == PermissionStatus.denied) {
      _locationPermissionGranted = await _location.requestPermission();
      if (_locationPermissionGranted == PermissionStatus.denied) {
        GlobalWidgets().snackbar(
            context,
            'Um zu sehen, wo du dich gerade befindest, navigiere zu den Einstellungen und aktiviere die Standortberechtigungen für die App',
            Colors.red
        );
        return null;
      }
    }

    return await _requestLocation();
  }

  Future<LatLng?> _requestLocation() async {
    try {
      // library bug <=> getLocation() sometimes does not return a value
      _locationData = await _location.getLocation().timeout(
          const Duration(milliseconds: 2000)
      );
      _currentLocation = LatLng(_locationData!.latitude!, _locationData!.longitude!);
      log('Current Location: $_locationData');

    } on TimeoutException catch (e) {
      _locationServiceEnabled = false;
      GlobalWidgets().popUp(
        'Fehler',
        'Leider konnte dein Standort nicht abgerufen werden, versuche es bitte erneut!',
        context,
        Colors.red,
      );
      return null;
    }

    return _currentLocation;
  }

  void _setUpClusterManager() {
    log('attempting to update markers...');
    _clusterManager = ClusterManager<Company>(
      Company.companies,
      _updateMarkers,
      markerBuilder: _markerBuilder,
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    Marker? locationMarker;
    if (_startIcon != null && _locationServiceEnabled) {
      locationMarker = Marker(
        markerId: const MarkerId('userPin'),
        position: _currentLocation!,
        infoWindow: const InfoWindow(
            title: 'Dein Standort'
        ),
        zIndex: 4,
        icon: _startIcon!,
      );
    }

    setState(() {
      _markers = markers;
      if (locationMarker != null) {
        _markers.add(locationMarker);
      }
    });
  }

  BitmapDescriptor _getCompanyIcon(int clusterSize) => clusterSize < 10
      ? _companyIcons.elementAt(clusterSize - 1)
      : _companyIcons.elementAt(9);

  // provide customized markers
  Future<Marker> Function(Cluster<Company>) get _markerBuilder => (cluster) async => Marker(
    markerId: MarkerId(cluster.getId()),
    position: cluster.location,
    onTap: () {
      _showCompanyCircle(cluster.getId(), cluster.location);
      _showCustomInfoWindow(cluster.count, cluster.items.toSet());
    },
    icon: _getCompanyIcon(cluster.count),
  );

  Circle _buildLocationCircle() => Circle(
      circleId: const CircleId('userCircle'),
      radius: _locationData!.accuracy!,
      zIndex: 3,
      strokeColor: Colors.redAccent.withOpacity(.5),
      center: _currentLocation!,
      fillColor: Colors.red.withOpacity(.3)
  );

  Future<void> _updateCameraPositionToCurrentLocation() async {
    _locationData = await _location.getLocation();
    log(_locationData.toString());
    if (_locationData == null) return;
    if (!_locationServiceEnabled) _locationServiceEnabled = true;
    _currentLocation = LatLng(_locationData!.latitude!, _locationData!.longitude!);
    // check if location has been activated after clicking the location button and load location asset and circle
    _startIcon ??= await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'images/start_pin.png'
    );
    // insert location circle as first Set item if not already there
    if (_circles.isNotEmpty && _circles.first.circleId.value != 'userCircle') {
      _circles = {
        _buildLocationCircle(),
        ..._circles
      };
    } else if (_circles.isEmpty) {
      _circles.add(_buildLocationCircle());
    }

    _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                _locationData!.latitude!,
                _locationData!.longitude!
              ),
              zoom: CAMERA_ZOOM,
              bearing: CAMERA_BEARING,
              tilt: CAMERA_TILT
            )
        )
    );
  }

  Future<void> _setUserLocationAndCompanyIcons() async {
    if (_locationServiceEnabled) {
      _startIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/start_pin.png'
      );
    }

    _companyIcons.addAll({
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company.png'
      ),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company2.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company3.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company4.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company5.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company6.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company7.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company8.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/company9.png'),
      await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          'images/companyInfinite.png')
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalProvider = context.watch<GlobalProvider>();

    const initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION
    );

    final translateMapPosition = Matrix4.translationValues(CustomDrawerWidget.xOffset, CustomDrawerWidget.yOffset, 0)
      ..setEntry(3, 2, 0.00075)
      ..rotateY(CustomDrawerWidget.rotateY)
      ..scale(CustomDrawerWidget.scaleFactor);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: !CustomDrawerWidget.drawerIsOpen ? const Align(
              alignment: Alignment.center,
              child: Text(
                'Unternehmenskarte',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              )
          ) : const SizedBox.shrink(),
          leading: CustomDrawerWidget(
            drawerClicked: () => CustomDrawerWidget.drawerIsOpen ? closeCompanyDrawer() : openCompanyDrawer(context)
          ).customIconButton(),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.home_filled),
                onPressed: () => MainHelper.routeTo(context, const Home())
            ),
          ],
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: GlobalWidgets().gradient(globalProvider),
        ),
        child: FutureBuilder(
          future: _asyncDataLoaded,
          builder: (context, snapshot) => snapshot.hasData ? Stack(
            children: [
              SafeArea(child: CustomDrawerWidget(drawerItemTapped: _moveCameraToCompanyCluster)),
              // gradient background
              GestureDetector(
                onTap: closeCompanyDrawer,
                onHorizontalDragStart: (details) => CustomDrawerWidget.isDraggingScreen = true,
                onHorizontalDragUpdate: (details) {
                  if (!CustomDrawerWidget.isDraggingScreen) return;

                  if (details.delta.dx > 1) {
                    openCompanyDrawer(context);
                  } else if (details.delta.dx < -1) {
                    closeCompanyDrawer();
                  }
                  CustomDrawerWidget.isDraggingScreen = false;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: translateMapPosition,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(CustomDrawerWidget.drawerIsOpen ? 40.0 : 0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [.1, .25, .4, .55, .7, .85, .95],
                      colors: CustomDrawerWidget.drawerIsOpen ? Constants.kLighterGradient : Constants.kDarkerGradient
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: translateMapPosition,
                child: SafeArea(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Align(
                        alignment: Alignment.center,
                        widthFactor: 0.97,
                        heightFactor: 0.92,
                        // prevent access on map if drawer is open
                        child: AbsorbPointer(
                          absorbing: CustomDrawerWidget.drawerIsOpen,
                          // setup Google Maps
                          child: GoogleMap(
                            myLocationEnabled: false,
                            myLocationButtonEnabled: false,
                            compassEnabled: false,
                            tiltGesturesEnabled: false,
                            zoomControlsEnabled: false,
                            markers: _markers,
                            mapType: MapType.normal,
                            initialCameraPosition: initialCameraPosition,
                            circles: _circles,
                            // associate provided controller with locally defined controller
                            onMapCreated: (GoogleMapController controller) async {
                              _controller.complete(controller);
                              _googleMapController = controller;
                              _clusterManager?.setMapId(controller.mapId);
                              //_customInfoWindowController.googleMapController = controller;
                              controller.setMapStyle(Constants.kMapStyle);
                              _showLocationPin();
                            },
                            onCameraMove: _clusterManager?.onCameraMove,
                            onCameraIdle: _clusterManager?.updateMap,
                            onTap: _hideCustomInfoWindow,
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /*
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 40,
                width: 40,
                offset: 45,
              ),
               */
              // overlay the map with navbar
              AnimatedPositioned(
                bottom: CustomDrawerWidget.drawerIsOpen ? -100 : 12,
                right: 10,
                duration: const Duration(milliseconds: 300),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    _updateCameraPositionToCurrentLocation();
                    _hideCustomInfoWindow();
                  },
                  label: const Text('Standort'),
                  icon: const Icon(Icons.location_on),
                  backgroundColor: const Color(0xff0f3c5c),
                ),
              ),
              AnimatedPositioned(
                top: _customInfoWindowPos,
                left: 0,
                right: 0,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: _customInfoWindowOpacity,
                  duration: const Duration(milliseconds: 300),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.all(25),
                      height: MediaQuery.of(context).size.height * (_clusterSize > 1 ? 0.68 : 0.28),
                      decoration: BoxDecoration(
                        gradient: GlobalWidgets().gradient(globalProvider),
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.2),
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  padding: const EdgeInsets.only(left: 20.0, top: 25.0),
                                  icon: const Icon(Icons.arrow_back_rounded),
                                  iconSize: 28.0,
                                  color: Constants.kWhiteColor,
                                  onPressed: _hideCustomInfoWindow,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 25.0),
                                alignment: Alignment.center,
                                child: const Center(
                                  child: Text(
                                    'Unternehmen',
                                    style: TextStyle(
                                      color: Constants.kWhiteColor,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2.5,
                                      fontSize: 21,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: 15, bottom: 20),
                                itemCount: _clusterSize,
                                itemBuilder: (BuildContext context, index) => _clusterSize != 0 ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      width: 45,
                                      height: 45,
                                      child: ClipOval(
                                        child: Image.asset(
                                          'images/company.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 25),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OffersList(_selectedCompanyCluster?.elementAt(index).name),
                                              ));
                                            },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                _selectedCompanyCluster?.elementAt(index).name ?? 'ABC GmbH',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Constants.kWhiteColor,
                                                  letterSpacing: 0.7,
                                                ),
                                              ),
                                              _selectedCompanyCluster?.elementAt(index).branche != '/' ? Text(
                                                _shortenDescription(_selectedCompanyCluster?.elementAt(index).branche, 45) ?? 'Handwerk',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white70,
                                                ),
                                              ) : const SizedBox.shrink(),
                                              const SizedBox(height: 3),
                                              Text(
                                                _selectedCompanyCluster?.elementAt(index).fullAddressToString() ??
                                                    'Max Mustermannstraße 12, 99999 Musterstadt',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white70,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              _clusterSize >= 2  && index != (_clusterSize - 1) ? SizedBox(
                                                height: 30.0,
                                                child: Center(
                                                  child: Container(
                                                    width: 350,
                                                    margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                                                    height: 1.2,
                                                    color: Constants.kWhiteColor,
                                                  ),
                                                ),
                                              ) : const SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20, left: 10),
                                      // navigate to details page
                                      child: IconButton(
                                        icon: const Icon(Icons.assistant_navigation),
                                        color: Constants.kWhiteColor,
                                        iconSize: 32,
                                        onPressed: () => _startWebNavigation(_selectedCompanyCluster?.elementAt(index).location),
                                      ),
                                    ),
                                  ],
                                ) : const Text('Es ist ein Fehler aufgetreten', style: TextStyle(color: Constants.kWhiteColor)),
                              )
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ],
          ) : GlobalWidgets().circular(context),
        ),
      ),
    );
  }

  Future<void> _showLocationPin() async {
    await _setUserLocationAndCompanyIcons();
    // use map without location services
    if (!_locationServiceEnabled) return;

    if (mounted) {
      setState(() {
        // add circle to location if available
        _circles.add(_buildLocationCircle());
        // add location pin if available
        if (_startIcon != null) {
          _markers.add(
            Marker(
              markerId: const MarkerId('userPin'),
              position: _currentLocation!,
              infoWindow: const InfoWindow(
                  title: 'Dein Standort'
              ),
              zIndex: 4,
              icon: _startIcon!,
            ),
          );
        }
      });
    }
  }

  void _showCustomInfoWindow(int clusterSize, Set<Company> cluster) {
    // load company information into global variable
    if (CustomDrawerWidget.drawerIsOpen) return;
    _selectedCompanyCluster = cluster;
    _clusterSize = clusterSize;

    setState(() {
      _customInfoWindowOpacity = .94;
      _customInfoWindowPos = 100;
    });
    _infoWindowActive = true;

    /*
    _customInfoWindowController.addInfoWindow!(
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.8),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.assistant_direction),
            padding: EdgeInsets.zero,
            iconSize: 30,
            color: Constants.kWhiteColor,
            onPressed: () {},
          ),
        ),
        LatLng(company.latitude!, company.longitude!)
    );
     */
  }

  void _hideCustomInfoWindow([LatLng clickedLocation = const LatLng(0, 0)]) {
    if (!_infoWindowActive) return;

    setState(() {
      _customInfoWindowPos = -1000;
      _customInfoWindowOpacity = 0;
    });
    _infoWindowActive = false;

    //_customInfoWindowController.hideInfoWindow!();
  }

  Future<void> _startWebNavigation(LatLng? companyLocation) async {
    if (companyLocation == null) {
      log('Error: missing company coordinates');
      return;
    }

    var params = {
      'api': '1',
      'travelmode': 'driving',
      'layer': 'traffic',
      'dir_action': 'navigate',
      'destination': '${companyLocation.latitude},${companyLocation.longitude}',
    };
    if (_locationServiceEnabled) params['origin'] = '${_currentLocation!.latitude},${_currentLocation!.longitude}';

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

  void openCompanyDrawer(BuildContext context) => setState(() {
    if (CustomDrawerWidget.drawerIsOpen) return;

    _hideCustomInfoWindow();
    CustomDrawerWidget.xOffset = MediaQuery.of(context).size.width * 0.82;
    CustomDrawerWidget.yOffset = 125.0;
    CustomDrawerWidget.scaleFactor = 0.65;
    CustomDrawerWidget.rotateY = 0.85;
    CustomDrawerWidget.drawerIsOpen = true;
  });

  void closeCompanyDrawer() => setState(() {
    if (!CustomDrawerWidget.drawerIsOpen) return;

    CustomDrawerWidget.xOffset = 0;
    CustomDrawerWidget.yOffset = 0;
    CustomDrawerWidget.scaleFactor = 1;
    CustomDrawerWidget.rotateY = 0;
    CustomDrawerWidget.drawerIsOpen = false;
  });

  Future<void> _moveCameraToCompanyCluster(Company clickedCompany) async {
    closeCompanyDrawer();
    // search in which cluster the company is located
    final cluster = await _clusterManager!.getMarkers();
    Cluster? matchingCluster;
    for (final clusterItem in cluster) {
      for (final company in clusterItem.items) {
        if (clickedCompany.location == company.location) {
          // navigate to cluster location
          matchingCluster = clusterItem;
        }
      }
    }
    // for some reason sometimes no cluster is found <=> library bug?
    _showCompanyCircle(clickedCompany.arbeitgeberHashId, matchingCluster != null
        ? matchingCluster.location
        : clickedCompany.location
    );
    // use current zoom level
    final currentZoomLevel = await _googleMapController.getZoomLevel();
    // also setState() is being called by the clusterManager
    _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: matchingCluster != null
                    ? matchingCluster.location
                    : clickedCompany.location,
                zoom: currentZoomLevel,
                bearing: CAMERA_BEARING,
                tilt: CAMERA_TILT
            )
        )
    );
  }

  void _showCompanyCircle(String? id, LatLng circleLocation) {
    if (id == null) return;
    // delete previous added circle and keep location circle if available
    _locationServiceEnabled ? _circles = {_circles.first} : _circles = {};
    _circles.add(
        Circle(
          circleId: CircleId('circle-$id'),
          radius: 30.0,
          zIndex: 3,
          strokeColor: Colors.tealAccent.withOpacity(.5),
          center: circleLocation,
          fillColor: Colors.teal.withOpacity(.3),
        )
    );
  }

  String? _shortenDescription(String? branche, int splitAt) =>
      branche == null ? null : (branche.length > splitAt ? '${branche.characters.take(splitAt)}...' : branche);
}