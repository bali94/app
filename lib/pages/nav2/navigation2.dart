import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/pages/nav2/components/maps.dart';
import 'package:juba/pages/nav2/components/offers/offersList.dart';
import 'package:juba/pages/nav2/components/offers/offerItem.dart';
import 'package:juba/pages/nav2/topTenPage.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';

import 'filterPage.dart';

class Navigation2 extends StatefulWidget {
  @override
  _Navigation2State createState() => _Navigation2State();
}

class _Navigation2State extends State<Navigation2> {
  int _selectedTab = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    OffersList(null),
     CompanyMap(),
  ];
  void onSelectTab(int index) {
    var globalProvider = context.read<GlobalProvider>();
    setState(() {
      _selectedTab = index;
    });
    if (index == 0) {
      globalProvider.showListOrMap();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, globalProvider, child) {
      return Scaffold(
        backgroundColor: globalProvider.getTheme().primaryColor,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Center(
            child: _widgetOptions[_selectedTab],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 28,
          selectedFontSize: 18,
          selectedItemColor: globalProvider.getTheme().colorScheme.secondary,
          unselectedItemColor: globalProvider.getTheme().colorScheme.secondary,
          currentIndex: _selectedTab,
          backgroundColor: globalProvider.getTheme().primaryColor,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              backgroundColor: globalProvider.getTheme().primaryColor,
              icon: const Icon(Icons.list),
              label:  S.of(context).list,
            ),
            BottomNavigationBarItem(
              backgroundColor: globalProvider.getTheme().primaryColor,
              icon: const Icon(Icons.map),
              label: S.of(context).map,
            ),
          ],
          onTap: onSelectTab,
        ),
      );
    });
  }
}
