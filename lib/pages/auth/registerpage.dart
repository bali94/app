import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/storagemanager.dart';
import 'package:juba/models/user.dart';
import 'package:juba/pages/auth/loginpage.dart';
import 'package:juba/pages/nav/navigation.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../helpers/mainHelper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController displayName = TextEditingController();

  bool isloading = false;
  bool _checkboxChecked = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var globalProvider = context.watch<GlobalProvider>();
    var userProvider = context.watch<UserProvider>();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                  gradient: GlobalWidgets().gradient(globalProvider)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kSizedBox,
                  GlobalWidgets()
                      .simpleBackButton(context, globalProvider, width),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width > 767.0 ? 82 : 20.0,
                      ),
                      child: Form(
                        key: formkey,
                        child: ListView(
                          children: [
                            SvgPicture.asset(
                              'images/juba-worms-logo.svg',
                              height: 120,
                            ),
                            const SizedBox(height: 25.0),
                            GlobalWidgets().formField(
                                displayName,
                                S.of(context).addUsername,
                                S.of(context).addUsername,
                                context),
                            const SizedBox(height: 4.0),
                            GlobalWidgets().formField(
                                email,
                                S.of(context).addEmail,
                                S.of(context).addEmail,
                                context,
                                keyboard: TextInputType.emailAddress
                            ),
                            const SizedBox(height: 4.0),
                            GlobalWidgets().formField(
                                password,
                                S.of(context).addPassword,
                                S.of(context).addPassword,
                                context,
                                isPasswort: true),
                            CheckboxListTile(
                              title: GlobalWidgets().text(
                                  S.of(context).dataProtection,
                                  textColor: globalProvider
                                      .getTheme()
                                      .colorScheme
                                      .secondary),
                              value: _checkboxChecked,
                              onChanged: (newValue) => setState(
                                  () => _checkboxChecked = !_checkboxChecked),
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                            const SizedBox(height: 15.0),
                            isloading == true
                                ? GlobalWidgets().circular
                                : GlobalWidgets().ontap(() async {
                                    if (formkey.currentState!.validate()) {
                                      if (!_checkboxChecked) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return GlobalWidgets().popUp(
                                                  S.of(context).notice,
                                                  S.of(context).acceptDataProtection,
                                                  context,
                                                  Colors.lightBlue);
                                            });
                                      } else {
                                        setState(() {
                                          isloading = true;
                                        });
                                        var res =
                                            await userProvider.registerUser(
                                                displayName.text,
                                                email.text,
                                                password.text,
                                                context);
                                        if (res == '') {
                                          /*
                                          //userProvider.isUserAuth(true);
                                          MainHelper.routeTo(
                                              context, const Navigation());
                                          */
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return GlobalWidgets().popUp(
                                                    S.of(context).success,
                                                    S.of(context).successReg,
                                                    context,
                                                    Colors.greenAccent);
                                              });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return GlobalWidgets().popUp(
                                                    S.of(context).error,
                                                    '$res',
                                                    context,
                                                    kRedColor);
                                              });
                                        }
                                        setState(() {
                                          isloading = false;
                                        });
                                      }
                                    }
                                  }, S.of(context).register,
                                    color:
                                        globalProvider.getTheme().primaryColor,
                                    fontSize: kMediumSize,
                                    fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
