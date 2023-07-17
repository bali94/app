import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:uuid/uuid.dart';


class Ome extends StatefulWidget {
  @override
  _OmeState createState() => _OmeState();
  
}

class _OmeState extends State<Ome> {
  StreamSubscription? _getPositionSubscription;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: () {
            },
            child: Padding(
                padding: const EdgeInsets.all(9.0), child: Icon(Icons.menu))),
        title: _isConnected() == false
            ? Row(
          children: [
            Container(height: 40, width: 40, child: GlobalWidgets().circular(context)),
            Text(
              'keine Verbindung zum Internet',
            )
          ],
        )
            :Text('ewrgr')
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Text('regre')
      ),
    );
  }
  @override
  void dispose() {
    try {
      _connectivitySubscription?.cancel();
    } catch (exception) {
      print(exception.toString());
    } finally {
      super.dispose();
    }
  }






  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }
  
  bool _isConnected() {
    return _connectionStatus != 'ConnectivityResult.wifi' &&
        _connectionStatus != 'ConnectivityResult.mobile';
  }
  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}
