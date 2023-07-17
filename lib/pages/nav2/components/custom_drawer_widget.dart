import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:juba/models/company.dart';

import 'package:juba/constants.dart' as Constants;

typedef DrawerItemTappedCallback = void Function(Company clickedCompany);

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key, this.drawerClicked, this.drawerItemTapped}) : super(key: key);

  final VoidCallback? drawerClicked;
  final DrawerItemTappedCallback? drawerItemTapped;
  static double xOffset = 0.0, yOffset = 0.0, scaleFactor = 1.0, rotateY = 0.0;
  static bool isDraggingScreen = false, drawerIsOpen = false;

  @override
  Widget build(BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          Expanded(
            child: _buildCompanyList(context),
          ),
        ],
      ),
  );

  Widget _buildCompanyList(BuildContext context) => ListView.builder(
    itemCount: Company.companies.length,
    itemBuilder: (BuildContext context, index) => Company.companies.isNotEmpty
        ? Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 7.0),
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              constraints: const BoxConstraints(
                minHeight: 65.0,
              ),
              decoration: BoxDecoration(
                color: Constants.kWhiteColor,
                borderRadius: BorderRadius.circular(21.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  Align(
                    heightFactor: 1.5,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${Company.companies.elementAt(index).name}',
                      style: _companyListTileTextStyle(fontSize: 19.0),
                    ),
                  ),
                  Company.companies.elementAt(index).branche != '/' ? Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${Company.companies.elementAt(index).branche}',
                      style: _companyListTileTextStyle(),
                    ),
                  ) : const SizedBox.shrink(),
                  const SizedBox(height: 15.0)
                ],
              ),
            ),
            onTap: () => drawerItemTapped!(Company.companies.elementAt(index)),
            onLongPress: () {},
          ),
    ) : const Text('Keine Unternehmen gefunden', style: TextStyle(color: Constants.kWhiteColor))
  );

  IconButton customIconButton() => IconButton(
    icon: drawerIsOpen
        ? const Icon(Icons.map_rounded)
        : const Icon(Icons.business_rounded),
    splashColor: Colors.transparent,
    iconSize: 26.0,
    onPressed: drawerClicked,
  );

  Widget _buildTitle() => Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, bottom: 10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Liste der Unternehmen',
          style: _companyListTileTextStyle(fontSize: 23.0),
        ),
      ),
  );

  TextStyle _companyListTileTextStyle({double fontSize = 15.0}) => TextStyle(
    color: fontSize == 23.0 ? Constants.kWhiteColor : Constants.kBlackColor,
    letterSpacing: fontSize == 23.0 ? 1.5 : 0,
    fontSize: fontSize,
    fontWeight: fontSize == 19.0 ? FontWeight.w500 : FontWeight.normal,
  );
}