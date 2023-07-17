import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/jobTags.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/pages/nav2/components/offers/offerItem.dart';
import 'package:juba/pages/nav2/components/offers/offerdetails.dart';
import 'package:juba/pages/select_list_controller.dart';
import 'package:juba/providers/companyProvider.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Favorite extends StatefulWidget {

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var controller = Get.put(SelectedListController());

  List<JobTags> jtags = [];
  @override
  void initState() {
    var offerProvider = context.read<OfferProvider>();
    var userProvider = context.read<UserProvider>();
    var userTags = userProvider.currentUser?.tags ?? [];

    offerProvider.fetchTagsAndOffers(null).then((value) {
      if (value != null) {
        setState(() {
          jtags = value;
          controller.setSelectedList(userTags);
        });
      }
    });
    super.initState();
  }

  void openFilterDialog(context, UserProvider userProvider) async {
    await FilterListDialog.display<JobTags>(context,
        listData: jtags,
        selectedListData: controller.getSelectedList(),
        headlineText: 'Dein Berufsfeld',
        closeIconColor: Colors.grey,
        applyButtonTextStyle: TextStyle(fontSize: 20),
        searchFieldHintText: 'Suche',
        choiceChipLabel: (item) => item!.name,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (list, text) {
          if (list!.any((element) =>
              element.name!.toLowerCase().contains(text.toLowerCase()))) {
            return list
                .where((element) =>
                    element.name!.toLowerCase().contains(text.toLowerCase()))
                .toList();
          } else
            return [];
        },
        onApplyButtonClick: (list) {
          controller.setSelectedList(List<JobTags>.from(list!));
          userProvider.currentUser!.tags = list;
          userProvider.updateUser(userProvider.currentUser!);

          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    var globalProvider = context.watch<GlobalProvider>();

    var cpProvider = context.watch<CompanyProvider>();
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: _body(userProvider,globalProvider,width),
    ); //Scaffold
  }
  _body(UserProvider userProvider, GlobalProvider globalProvider , width){
    return userProvider.currentUser?.yourFavoritesOffers == null
        ? GlobalWidgets().circular(context)
        : Container(
      decoration: BoxDecoration(
          gradient: GlobalWidgets().gradient(globalProvider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlobalWidgets().logoAndBAckButton(context, globalProvider, width: width),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: MainHelper().responsiveWidth(width),

              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient:
                    GlobalWidgets().gradient2(globalProvider)),
                child: userProvider.currentUser?.yourFavoritesOffers!
                    .isEmpty ==
                    true
                    ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Center(
                      child: Text(
                        'Hey ${newText(userProvider.currentUser!.displayName!)},\n${S.of(context).noDataSaved}!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: kWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      )
                    ))
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 20,
                            ),
                            child: RichText(
                              text: TextSpan(
                                  text:
                                  'Hey, ${newText(userProvider.currentUser!.displayName!)}',
                                  style: const TextStyle(
                                      fontSize: kBigSize,
                                      letterSpacing: 0.8,
                                      color: kWhiteColor,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: kFontFamily,
                                      fontWeight:
                                      FontWeight.w900),
                                  children: [
                                    TextSpan(
                                        text:
                                        '\nHier siehst du deine Favoriten',
                                        style: TextStyle(
                                          fontStyle:
                                          FontStyle.italic,
                                          fontFamily: kFontFamily,
                                          fontSize: kMediumSize,
                                          color: kWhiteColor,
                                        ))
                                  ]),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Tap');
                            openFilterDialog(context, userProvider);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add,
                                  size: kMediumSize,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                          padding:
                          const EdgeInsets.only(bottom: 20.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: userProvider.currentUser!
                                .yourFavoritesOffers!.length,
                            itemBuilder: (ctx, i) {
                              var currentOffer = userProvider
                                  .currentUser!
                                  .yourFavoritesOffers![i];
                              return GestureDetector(
                                onTap: () {
                                  MainHelper.routeTo(
                                      context,
                                      OfferDetails(
                                          currentOffer, false));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: 10),
                                  child: OfferItem(
                                      currentOffer, false, true, false),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
  newText(String text) {
    return text.length > 20 ? " ${text.substring(0, 20)} ..." : text;
  }
}
