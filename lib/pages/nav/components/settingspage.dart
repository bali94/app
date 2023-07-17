import 'package:flutter/material.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {


  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: globalProvider.getTheme().hintColor, //change your color here
        ),
        title: Text(''),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextButton(
                child: Text(globalProvider.isEngl == false ? "de" : 'en'),
                onPressed: () {
                  if (globalProvider.isEngl  == false) {
                    globalProvider.setLanguageCode(Locale.fromSubtags(languageCode: 'de'));
                  } else {
                    globalProvider.setLanguageCode(Locale.fromSubtags(languageCode: 'en'));
                  }
                }),
            TextButton(
                child: Text(globalProvider.getTheme() == globalProvider.darkTheme ? "dark" : 'white'),
                onPressed: () {
                    globalProvider.setThemeMode();
                }),
          ],
        ),
      ),
    );
  }
}
