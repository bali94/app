
import 'package:flutter/material.dart';
import 'package:juba/pages/auth/loginpage.dart';
import 'package:juba/pages/favoritepage.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:provider/provider.dart';

class FavoriteOrLoginPage extends StatefulWidget {
  @override
  _FavoriteOrLoginPageState createState() => _FavoriteOrLoginPageState();
}

class _FavoriteOrLoginPageState extends State<FavoriteOrLoginPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  bool isloading = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<UserProvider>().checkIfUserAuth()
    );
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    double height = MediaQuery.of(context).size.height;
    return  userProvider.currentUser != null ? Favorite():LoginPage();
  }
}
