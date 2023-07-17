import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/helpers/storagemanager.dart';
import 'package:juba/pages/auth/passwordForgotPage.dart';
import 'package:juba/pages/favoritepage.dart';
import 'package:juba/pages/nav/navigation.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'registerpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  bool isloading = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UserProvider>().checkIfUserAuth());
  }

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    var userProvider = context.watch<UserProvider>();
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return isloading
        ? Center(
            child: GlobalWidgets().circular(context),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: GlobalWidgets().gradient(globalProvider)),
              child: Container(

                padding:  EdgeInsets.symmetric(horizontal:width> 767.0 ? 82 : 20.0),

                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/juba-worms-logo.svg',
                        height: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GlobalWidgets().formField(email, S.of(context).email,
                          S.of(context).addEmail, context, keyboard: TextInputType.emailAddress),
                      GlobalWidgets().formField(password, S.of(context).password,
                          S.of(context).addPassword, context,
                          isPasswort: true),
                      /*
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GlobalWidgets().text(
                                    S.of(context).register, underLine: false, textColor: Colors.white70, padding: 20.0
                                ),
                                GlobalWidgets().text(
                                    S.of(context).forgoPassword, underLine: false, textColor: Colors.white70, padding: 20.0
                                ),
                              ],
                            ),
                          ),
                        ),
                         */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: GlobalWidgets().text(
                              S.of(context).register,
                              underLine: false,
                              textColor: Colors.white70,
                              letterSpacing: 1.0,
                              toUpperCase: false,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordForgotPage(),
                                ),
                              );
                            },
                            child: GlobalWidgets().text(
                              S.of(context).forgotPassw,
                              underLine: false,
                              textColor: Colors.white70,
                              letterSpacing: 1.0,
                              toUpperCase: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GlobalWidgets().ontap(() async {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            isloading = true;
                          });
                          var res = await userProvider.userLogin(
                              email.text, password.text, context);
                          if (res == '') {
                            userProvider.isUserAuth(true);
                          } else if (res == 'user-not-verified') {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return GlobalWidgets().popUp(
                                      S.of(context).notice,
                                      S.of(context).confirmation,
                                      context,
                                      Colors.lightBlue);
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return GlobalWidgets().popUp(
                                      S.of(context).error, '$res', context, kRedColor);
                                });
                          }
                          setState(() {
                            isloading = false;
                          });
                        }
                      }, S.of(context).login,
                          color: globalProvider.getTheme().primaryColor,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
