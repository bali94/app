import 'dart:async';
import 'package:flutter/material.dart';
import 'package:juba/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:juba/providers/companyProvider.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/messageProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize Firebase resources
  await Firebase.initializeApp();
  // remove status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  // deactivate landscape
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => OfferProvider()),
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context) => CompanyProvider()),
            ChangeNotifierProvider(create: (context) => GlobalProvider()),
            ChangeNotifierProvider(create: (context) => MessageProvider()),
          ],
          child: const MyApp(),
      ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    var cm = context.watch<GlobalProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: cm.getTheme().copyWith() ,
      locale: cm.locale,

      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Juba App',
      home: const Home(),
    );
  }
}
