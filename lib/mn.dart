import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:juba/constants.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:juba/pages/nav2/components/maps.dart';
import 'package:juba/providers/companyProvider.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/messageProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/test.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:translator/translator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:juba/providers/jobsucheProvider.dart';
import 'package:juba/pages/auth/passwordForgotPage.dart';

import 'generated/l10n.dart';
import 'pages/auth/loginpage.dart';
import 'pages/auth/registerpage.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize Firebase resources
  await Firebase.initializeApp();
  // Keep the splash screen until firebase has initialized and API data has loaded
  FlutterNativeSplash.removeAfter(initialization);
  // remove status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  /*
  // DEBUG
  debugPrint('jobOffers="${JobsucheProvider.jobOffersInWorms}"');
  JobsucheProvider.getJobOfferDetailsInWorms(
    JobsucheProvider.jobOffersInWorms['stellenangebote'][0]['hashId']
  );
  debugPrint('jobOfferDetailsExample="${JobsucheProvider.currentJobOfferDetails}"');
   */

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => OfferProvider()),
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context) => CompanyProvider()),
            ChangeNotifierProvider(create: (context) => GlobalProvider()),
            ChangeNotifierProvider(create: (context) => MessageProvider()),
          ],
          child: const MyApp() /*const MaterialApp(home: PasswordForgotPage())*/
      )
  );
}

Future<void> initialization(BuildContext? context) async {
  // fetch API data
  //await JobsucheProvider.getJwtToken();
  //JobsucheProvider.getJobOffersInWorms();
  /*
  // DEBUG
  debugPrint('jobOffers="${JobsucheProvider.jobOffersInWorms}"');
  JobsucheProvider.getJobOfferDetailsInWorms(
      JobsucheProvider.jobOffersInWorms['stellenangebote'][0]['hashId']
  );
  debugPrint('jobOfferDetailsExample="${JobsucheProvider.currentJobOfferDetails}"');
   */
  /*
   * ToDo: Ask for location permissions
   */
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
      home:  Home(),
    );
  }
}
