import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/helpers/storagemanager.dart';
import 'package:juba/pages/auth/loginpage.dart';
import 'package:juba/pages/auth/passwordForgotPage.dart';
import 'package:juba/pages/favoritepage.dart';
import 'package:juba/pages/homepage.dart';
import 'package:juba/pages/impressum.dart';
import 'package:juba/pages/nav/components/contact.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool valNotify1 = false;

  onChangeFunction1(GlobalProvider globalProvider, bool value) {
    setState(() {
      valNotify1 = value;
      globalProvider.setDarkMode(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    var userProvider = context.watch<UserProvider>();
    double width = MediaQuery.of(context).size.width;

    bool getEnglVal(GlobalProvider globalProvider) {
      valNotify1 = globalProvider.isDarkMode();
      return valNotify1;
    }

    getEnglVal(globalProvider);

    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GlobalWidgets()
                  .logoAndBAckButton(context, globalProvider, width: width),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width > 767.0 ? 100 : 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Container(
                      padding: kPadding,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: kBlueColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  S.of(context).legal,
                                  style: GlobalWidgets().style(
                                      textColor: globalProvider
                                          .getTheme()
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: kBigSize,
                                      italic: true),
                                ),
                              ],
                            ),
                            Divider(
                              height: 20,
                              thickness: 1,
                              color: kBlueColor,
                            ),


                            /*IconButton(
                              icon: globalProvider.isEngl == false ? Image.asset('images/germany')
                              : Image.asset('images/germany'),
                                iconSize: 20,
                                onPressed: () {
                                  if (globalProvider.isEngl  == false) {
                                    globalProvider.setLanguageCode(Locale.fromSubtags(languageCode: 'de'));
                                  } else {
                                    globalProvider.setLanguageCode(Locale.fromSubtags(languageCode: 'en'));
                                  }
                                },
                            ),*/
                            buildAccountOption(
                              context,
                              S.of(context).legalNotice,
                              ImpressumDatenschutz(
                                isImpressum: true,
                              ),
                            ),
                            buildAccountOption(
                              context,
                              S.of(context).privacy,
                              ImpressumDatenschutz(
                                isImpressum: false,
                              ),
                            ),
                            //
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Icon(Icons.more, color: kBlueColor),
                                SizedBox(width: 10),
                                Text(
                                  S.of(context).language,
                                  style: GlobalWidgets().style(
                                      textColor: globalProvider
                                          .getTheme()
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: kBigSize,
                                      italic: true),
                                )
                              ],
                            ),
                            Divider(
                              height: 20,
                              thickness: 1,
                              color: kBlueColor,
                            ),
                            SizedBox(height: 10),
                            /*buildNotificationOption(
                                "Darkmode",
                                valNotify1,
                                onChangeFunction1,
                                globalProvider
                                    .getTheme()
                                    .colorScheme
                                    .secondary),
                            SizedBox(height: 50),*/
                            FloatingActionButton(

                                child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: globalProvider.isEngl== false
                                        ? AssetImage("images/germany.png"
                                    ): AssetImage('images/engl.png')

                                ),
                                onPressed: () {
                                  if (globalProvider.isEngl == true) {
                                    globalProvider.setLanguageCode(
                                        Locale.fromSubtags(languageCode: 'de'));
                                  } else {
                                    globalProvider.setLanguageCode(
                                        Locale.fromSubtags(languageCode: 'en'));
                                  }
                                }),
                            SizedBox(height: 50),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kBlueColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                    onTap: () {
                                      if (userProvider.isAuth == false){
                                        MainHelper.routeTo(context, LoginPage(),
                                          fromLeft: false
                                        );
                                      }
                                      else {
                                        FirebaseAuth.instance.signOut();
                                        userProvider.isUserAuth(false);
                                        StorageManager.deleteData('userId');
                                        userProvider.setUser(null);
                                        MainHelper.routeTo(context, Home(),
                                            pushAndRemove: true);
                                      }
                                    },
                                    child: GlobalWidgets().text(userProvider.isAuth == false ? S.of(context).login
                                    : S.of(context).logout,
                                        textColor: kWhiteColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangeMethod, Color color) {
    var globalProvider = context.watch<GlobalProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: kMediumSize,
                  fontWeight: FontWeight.w500,
                  color: color)),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: kBlueColor,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(globalProvider, newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(
      BuildContext context, String title, Widget widget) {
    var globalProvider = context.watch<GlobalProvider>();

    return GestureDetector(
      onTap: () {
        MainHelper.routeTo(context, widget);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: globalProvider.getTheme().colorScheme.secondary)),
            Icon(
              Icons.arrow_forward_ios,
              color: kBlueColor,
            )
          ],
        ),
      ),
    );
  }
}
