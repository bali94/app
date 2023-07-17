import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/pages/nav/components/sharedOfferDetails.dart';
import 'package:juba/pages/nav/navigation.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver{
  bool finishLoading = false;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  String? link;
  @override
  void initState() {
    var offerProvider = context.read<OfferProvider>();
    WidgetsBinding.instance!.addObserver(this);


    super.initState();
  }
  @override
  void dispose() {

    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var offerProvider = context.read<OfferProvider>();
    var userProvider = context.read<UserProvider>();

    if (state == AppLifecycleState.resumed) {
      // resumed mean you open the App after specific time
      handleDynamicLinks(context);
      if(userProvider.isAuth == false) userProvider.checkIfUserAuth();
    } else if (state == AppLifecycleState.inactive) {
      print('Inactive');
    }
  }
  Future<void> handleDynamicLinks(BuildContext context) async{
    dynamicLinks.onLink.listen((dynamicLinkData) {
      List<String>  elements =  dynamicLinkData.link.toString().split('/');
      setState(() {
        finishLoading = true;
        link = elements[3];
      });
      MainHelper.routeTo(context, ShardeOfferDetails(offerId: link,));
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });

    PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data, context);
  }
  void _handleDeepLink(PendingDynamicLinkData? data, BuildContext context) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      setState(() {
        finishLoading = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return finishLoading == true ? ShardeOfferDetails(offerId: link,):Navigation();
  }
}
