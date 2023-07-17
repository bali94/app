import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juba/constants.dart';
import 'package:juba/helpers/apiHelper.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/companyDTO.dart';
import 'package:juba/pages/auth/loginpage.dart';
import 'package:juba/pages/homepage.dart';
import 'package:juba/pages/nav/components/profile.dart';
import 'package:juba/pages/nav/navigation.dart';
import 'package:juba/providers/companyProvider.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class GlobalWidgets {
  divider() {
    return Divider(
      indent: 40,
      endIndent: 40,
    );
  }

  logoAndBAckButton(BuildContext context, GlobalProvider globalProvider,
      {bool withFilterButton = false, double width = 768.0}) {
    return Container(
      padding:  EdgeInsets.only(left :width > 767 ? 90:20,right :width > 767 ? 90:20 ,top: 50, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              globalProvider.showContactPage = false;
              MainHelper.routeTo(context, Home(),
                  pushAndRemove: true, fromLeft: true);
            },
            child: SvgPicture.asset(
              'images/juba-worms-logo.svg',
              height: 80,
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  globalProvider.showContactPage = false;
                  MainHelper.routeTo(context, Home(),
                      pushAndRemove: true, fromLeft: true);
                },
                child: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(
                      Icons.home_filled,
                      color: globalProvider.getTheme().colorScheme.secondary,
                      size: kBigSize,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
  backButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          MainHelper.routeTo(context, Navigation(), pushAndRemove: true);
        },
        icon: const Icon(Icons.home_filled, color: kBlueColor));
  }
  gradient(GlobalProvider globalProvider) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.1,
        0.9,
      ],
      colors: [
        globalProvider.getTheme().hintColor,
        globalProvider.getTheme().primaryColor
      ],
    );
  }

  gradient2(GlobalProvider globalProvider) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.1,
        0.9,
      ],
      colors: [kBlueColor, Color(0xFF477EA3)],
    );
  }

  tab(String text, IconData iconData, GlobalProvider globalProvider) {
    return Tab(
        child: Container(
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              child: Icon(
                iconData,
                color: globalProvider.getTheme().colorScheme.secondary,
              )),
          Text(text,
              style: GlobalWidgets().style(
                textColor: globalProvider.getTheme().colorScheme.secondary,
              ))
        ],
      ),
    ));
  }
  simpleBackButton(BuildContext context, GlobalProvider globalProvider, double width){
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: width >= 768.0 ? 80 : 20.0),
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Card(
              color: kBlueColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.chevron_left,
                  size: kBigSize,
                  color: globalProvider.getTheme().colorScheme.primary,
                ),
              ))),
    );
  }
  jubaLogoWidget(double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.2,
        child: Image.asset('images/juba_worms_logo.png'),
      ),
    );
  }

  toAuthOrProfile(context, UserProvider userProvider) {
    return InkWell(
      onTap: () {
        if (userProvider.isAuth == false) {
          MainHelper.routeTo(context, LoginPage());
        } else {
          MainHelper.routeTo(context, Profile());
        }
      },
      child: userProvider.isAuth == true
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: kBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(160),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    'BB',
                    style: TextStyle(
                        color:
                            provider(context).getTheme().colorScheme.primary),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.perm_identity,
                color: provider(context).getTheme().colorScheme.primary,
              ),
            ),
    );
  }

  noInternetDialog(
    String message,
    BuildContext context,
    Color titleColor, {
    Color textColor = kGreyColor,
  }) {
    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 80, child: Image.asset('images/internet.jpg')),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Oooops',
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w900,
                fontSize: kBigSize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            message,
            style: TextStyle(color: textColor, fontSize: kMediumSize),
          ),
        ),

      ],
    ));
  }



  popUp(
    String title,
    String message,
    BuildContext context,
    Color titleColor, {
    Color textColor = kGreyColor,
  }) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Okay',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
            )
          )
        )
      ],
      title: Text(
        title,
        style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w900,
            fontSize: kBigSize),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: textColor, fontSize: kBigSize),
          ),
            /*
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Zum Login',
                        style: TextStyle(
                            color: titleColor,
                            fontWeight: FontWeight.w900,
                            fontSize: kBigSize))),
              ),
            )
             */
          ],
        ),
    );
  }

  ontap(dynamic onTap, String title,
      {bool underLine = false,
      double fontSize = kNormalSize,
      Color color = kWhiteColor,
      Color backColor = kBlueColor,
      FontWeight fontWeight = FontWeight.normal}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 150,
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: style(
                  textColor: color, fontSize: fontSize, fontWeight: fontWeight),
            )),
      ),
    );
  }

  circular(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: provider(context).getTheme().colorScheme.primary,
      color: kWhiteColor,
      strokeWidth: 6.0,
    ));
  }

  linear(BuildContext context) {
    return Center(
        child: LinearProgressIndicator(
      backgroundColor: provider(context).getTheme().colorScheme.primary,
      color: kWhiteColor,
      minHeight: 2,
    ));
  }

  text(String text,
      {double fontSize = kNormalSize,
      Color textColor = kGreyColor,
      FontWeight fontWeight = FontWeight.normal,
      bool underLine = false,
      bool italic = false,
      bool toUpperCase = false,
      double letterSpacing = 0.0}) {

    return Padding(
      padding: kPadding,
      child: Text(
        toUpperCase ? text.toUpperCase() : text,
        style: style(
            textColor: textColor,
            fontSize: fontSize,
            underLine: underLine,
            fontWeight: fontWeight,
            italic: italic,
            letterSpacing: letterSpacing),
      ),
    );
  }

  formField(TextEditingController textEditingController, String hinText,
      String errorText, BuildContext context,
      {bool isPasswort = false, TextInputType? keyboard}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: isPasswort,
        keyboardType: keyboard,
        onTap: () => textEditingController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingController.value.text.length),
        onChanged: (text) {},
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GlobalWidgets().style(),
        cursorColor: provider(context).getTheme().colorScheme.primary,
        decoration:
            GlobalWidgets().textFormStyle(Icons.lock, hintText: hinText),
        controller: textEditingController,
        validator: (dynamic value) {
          if (value.isEmpty) {
            return errorText;
          } else
            return null;
        },
      ),
    );
  }

  style(
      {double fontSize = kNormalSize,
      bool withBackColor = false,
      Color textColor = Colors.grey,
      FontWeight fontWeight = FontWeight.normal,
      bool underLine = false,
      bool italic = false,
      double letterSpacing = 0.0}) {
    return TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration:
          underLine == false ? TextDecoration.none : TextDecoration.underline,
      fontStyle: italic == false ? FontStyle.normal : FontStyle.italic,
      letterSpacing: letterSpacing,
    );
  }

  textFormStyle(IconData? icon,
      {String hintText = '', bool isRightBorderRadiusZero = false}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      errorStyle: const TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: kNormalSize,
          fontWeight: FontWeight.w100,
          fontFamily: kFontFamily),
      fillColor: kWhiteColor,
      filled: true,
      labelText: hintText,
      labelStyle: style(),
      border: isRightBorderRadiusZero
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
              ),
            )
          : OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }

  GlobalProvider provider(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    return globalProvider;
  }

  dropDownWidget(List<String> list, TextEditingController controller,
      OfferProvider offerProvider) {
    return DropdownSearch<String>.multiSelection(
      mode: Mode.MENU,
      showSelectedItems: true,
      selectedItems: [],
      showClearButton: true,
      showSearchBox: true,
      //scrollbarProps: ScrollbarProps(isAlwaysShown: true, thickness: 7),
      items: list,
      dropdownSearchBaseStyle: TextStyle(color: Colors.red),
      onFind: (String? filter) => findTags(list, filter!, offerProvider),
    );
  }

  Future<List<String>> findTags(
      List<String> list, String query, OfferProvider offerProvider) async {
    var res = await offerProvider.fetchTagsAndOffers(null);
    return  [];
  }

  checkbox(String title, {bool value = false}) {
    bool? currentValue = value;

    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) => currentValue = newValue,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }

  snackbar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
    ));
  }
}
