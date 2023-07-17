import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:juba/constants.dart';
import 'package:juba/helpers/storagemanager.dart';
class GlobalProvider extends ChangeNotifier{
  Locale locale = Locale.fromSubtags(languageCode: 'de');
  bool isEngl = false;
  int? selectedRadioTile = 3;
  bool showList = false;
  bool showContactPage = false;

  setLanguageCode(Locale lc){
    locale = lc;
    isEngl = !isEngl;
    notifyListeners();
  }
  showListOrMap(){
    showList = !showList;
    notifyListeners();
  }
  showContactOrStart(bool val){
    showContactPage = val;
    notifyListeners();
  }
  setSelectedRadioTile(dynamic val){
   selectedRadioTile = val;
    notifyListeners();
  }
  final darkTheme = ThemeData(fontFamily: kFontFamily,
    primaryColor:  Colors.black12,
    backgroundColor: const Color(0xFFffffff),
    hintColor: const Color(0xFF016064),
    brightness: Brightness.dark,
    colorScheme:
    ColorScheme.fromSwatch().copyWith(primary: Color(0xFFffffff), brightness: Brightness.dark, secondary:Color(0xFFffffff) ),
  );
  final lightTheme = ThemeData(
      fontFamily: kFontFamily,
    primaryColor: const Color(0xFF13486C),
    backgroundColor: const Color(0xFFffffff),
    hintColor: const Color(0xFF2BA8FF),
    cardColor: Color(0xFF58d6fc),
    brightness: Brightness.light,
    colorScheme:
    ColorScheme.fromSwatch().copyWith(primary:  Color(0xFF13486C), secondary: Color(0xFFffffff)),
  );
  ThemeData? _themeData;

  ThemeData getTheme() => _themeData ?? lightTheme;

  void setThemeMode() async {
    if (_themeData == darkTheme) {
      _themeData = lightTheme;
      StorageManager.saveData('themeMode', 'light');
    } else {
      _themeData = darkTheme;
      StorageManager.saveData('themeMode', 'dark');
    }
    notifyListeners();
  }

  void setDarkMode(bool isDarkMode) async {
    if (isDarkMode ) {
      _themeData = darkTheme;
      StorageManager.saveData('themeMode', 'dark');
    } else {
      _themeData = lightTheme;
      StorageManager.saveData('themeMode', 'light');
    }
    notifyListeners();
  }

  bool isDarkMode() {
    return _themeData == darkTheme;
  }
}
