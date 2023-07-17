import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/apiHelper.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/helpers/storagemanager.dart';
import 'package:juba/pages/auth/loginpage.dart';
import 'package:juba/pages/favoritepage.dart';
import 'package:juba/pages/nav/components/questionAnswer.dart';
import 'package:juba/pages/nav/components/favoriteOrLoginpage.dart';
import 'package:juba/pages/nav/components/settingTestUi.dart';
import 'package:juba/pages/nav/components/settingspage.dart';
import 'package:juba/pages/nav/components/startpage.dart';
import 'package:juba/pages/nav2/components/maps.dart';
import 'package:juba/pages/nav2/topTenPage.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';

import 'components/contact.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with WidgetsBindingObserver  {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static  final List<Widget> _widgetOptions = <Widget>[
    TopTenPage(),
    QandA(),
    FavoriteOrLoginPage(),
    //Personal(),
  ];

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance!.addObserver(this);
   // ApiHelper().callApiOneTimePerDay();
  }

  void onSelectTab(int index) {
    var globalProvider = context.read<GlobalProvider>();
    setState(() {
      _selectedTab = index;
    });
    if(index == 0){
      globalProvider.showContactOrStart(true);
    }

  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if(_isConnected() == false){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return GlobalWidgets().noInternetDialog(
                   S.of(context).noInternet, context, kRedColor);
            });
      }
    });
  }
  bool _isConnected() {
    return _connectionStatus.name == 'wifi' ||
        _connectionStatus.name == 'mobile';
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var userProvider = context.watch<OfferProvider>();

    return Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return Scaffold(
            backgroundColor: globalProvider.getTheme().primaryColor,
            body: Container(
              decoration:  BoxDecoration(
                gradient: GlobalWidgets().gradient(globalProvider),
              ),
              child:   Stack(
                children: [
                  _isConnected() == true ? SizedBox(): Positioned(
                      left: 30.0,
                      top: height * 0.1,
                      child: InkWell(
                        onTap: (){
                          MainHelper.routeTo(context, SettingPage());
                        },
                        child:  Container(
                          child: Row(
                            children: [
                              Container(height: 40, width: 40, child: GlobalWidgets().circular(context)),
                              GlobalWidgets().text(S.of(context).noInternet, fontSize: 12,textColor: globalProvider.getTheme().colorScheme.secondary)
                            ],
                          )
                        ),
                      )
                  ),
                  Positioned(
                      left: 40.0,
                      top: height < 781 ? height * 0.06: height * 0.1,
                      child:  Container(
                        width: 250.0,
                        height: 250.0,
                        child: SvgPicture.asset('images/juba-worms-logo.svg', height: 120,),
                      )
                  ),
                  Positioned(
                      right: 20.0,
                      top: height * 0.06,
                      child: InkWell(
                        onTap: (){
                          MainHelper.routeTo(context, SettingPage());
                        },
                        child:  Container(
                          child: Icon(Icons.settings, color: globalProvider.getTheme().colorScheme.secondary,),
                        ),
                      )
                  ),
                  Positioned(
                      right: 10.0,
                      top: height * 0.1,
                      child:  Container(
                        width: 150.0,
                        height: 120.0,
                        child: SvgPicture.asset('images/Drache.svg', height: 120,),
                      )
                  ),

                  _widgetOptions[_selectedTab],
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(

              onPressed: () {
                MainHelper.routeTo(context, MSG());
            // Add your onPressed code here!
          },
          child: Icon(Icons.chat),
          backgroundColor:  globalProvider.getTheme().primaryColor,
          ),
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 28,
              selectedFontSize: 18,
              selectedItemColor: globalProvider.getTheme().colorScheme.secondary,
              unselectedItemColor: globalProvider.getTheme().colorScheme.secondary,
              currentIndex: _selectedTab,
              showUnselectedLabels: false,
              backgroundColor: globalProvider.getTheme().primaryColor,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: globalProvider.getTheme().primaryColor,
                  icon: const Icon(Icons.mode_comment),
                  label: S.of(context).featured,
                ),
                BottomNavigationBarItem(
                  backgroundColor: globalProvider.getTheme().primaryColor,
                  icon: Icon(Icons.help),
                  label: 'Juba',
                ),
                BottomNavigationBarItem(
                  backgroundColor: globalProvider.getTheme().primaryColor,
                  icon: const Icon(Icons.favorite),
                  label: S.of(context).favorite,
                ),

              ],
              onTap: onSelectTab,
            ),
          );});
  }
}
