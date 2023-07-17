
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:mailto/mailto.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';
final translator = GoogleTranslator();
FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

class MainHelper{
  void funcOpenMailComposer(String email, String beruf) async {
    final mailtoLink = Mailto(
      to: [email],
      cc: [''],
      subject: beruf,
      body: '',
    );
    await launch('$mailtoLink');
  }
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future<String> createDynamicLink(String offerId) async {
    String rl = 'https://juba.page.link';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: rl,
      link: Uri.parse('$rl/$offerId'),
      androidParameters:  AndroidParameters(
        packageName: 'com.app.juba',
        minimumVersion: 0,
      ),
      iosParameters:  IOSParameters(
        bundleId: 'io.invertase.testing',
        minimumVersion: '0',
      ),
    );
    Uri url;
    final ShortDynamicLink shortLink = await dynamicLinks.buildShortLink(parameters);
    url = shortLink.shortUrl;
    return url.toString();
  }

  String convertToLowercase(String txt){
    return txt.toLowerCase();
  }
  String formatedDate(String Date){
    final f =  DateFormat('dd.MM.yyyy');
    String date = f.format(DateTime.parse(Date));
    return date;

  }
  static void routeTo(BuildContext context, Widget widget,
      {bool fromLeft = false, bool pushAndRemove = false}) {
    var route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = fromLeft ? Offset(-1.0, 0.0) : Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
    if(pushAndRemove == false){
      Navigator.of(context).push(route);

    }else{
      Navigator.of(context).pushAndRemoveUntil(route,(t) => false);

    }
  }
  responsiveWidth(double width){
    return  width>= 768.0 ? width * 0.80 : width * 0.9;
  }
  Future<String?> apiTranslate(String text,String lang)async{
   var res = await text.translate(to: 'fr');
   return res.text;
  }
    Future<void> launchInBrowser(String url) async {
      if (!await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      )) {
        throw 'Could not launch $url';
      }
    }
  Future<void> launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}