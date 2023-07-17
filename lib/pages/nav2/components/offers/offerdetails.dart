import 'package:flutter/material.dart';
import 'package:juba/constants.dart';
import 'package:juba/helpers/apiHelper.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/pages/homepage.dart';
import 'package:juba/pages/nav2/components/offers/components/addressWidget.dart';
import 'package:juba/pages/nav2/components/offers/components/applyAndFavoriteRow.dart';
import 'package:juba/pages/nav2/components/offers/components/locationAndOfferType.dart';
import 'package:juba/pages/nav2/components/offers/components/timeRow.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class OfferDetails extends StatelessWidget {
  final OfferDetailDto? currentOffer;
  final bool toHome;
  OfferDetails(this.currentOffer, this.toHome);

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    final userPro = context.watch<UserProvider>();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration:
        BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left :width > 767 ? 90:20,right :width > 767 ? 90:20 ,top: 50, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                if (toHome == true) {
                                  MainHelper.routeTo(context, Home(),
                                      pushAndRemove: true, fromLeft: true);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Card(
                                  color: kBlueColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.chevron_left,
                                      size: kBigSize,
                                      color: globalProvider
                                          .getTheme()
                                          .colorScheme
                                          .primary,
                                    ),
                                  ))),
                          InkWell(
                            onTap: () {
                              MainHelper.routeTo(context, Home(),
                                  pushAndRemove: true, fromLeft: true);
                            },
                            child: Container(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.home_filled,
                                  color: globalProvider
                                      .getTheme()
                                      .colorScheme
                                      .secondary,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 8, right: 8),
                        child: Container(
                          width: MainHelper().responsiveWidth(width),

                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(30)),
                              gradient:
                              GlobalWidgets().gradient2(globalProvider)),
                          child: Container(
                            padding: kPadding,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListView(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        currentOffer!.titel ?? '',
                                        style: GlobalWidgets().style(
                                            textColor: globalProvider
                                                .getTheme()
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w900,
                                            fontSize: kBigSize,
                                            italic: true),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        currentOffer!.arbeitgeber
                                            ?.toUpperCase() ??
                                            '',
                                        style: GlobalWidgets().style(
                                            fontWeight: FontWeight.w900,
                                            textColor: globalProvider
                                                .getTheme()
                                                .colorScheme
                                                .primary,
                                            fontSize: kBigSize,
                                            italic: true),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              currentOffer!.beruf ?? '',
                                              style: GlobalWidgets().style(
                                                textColor: globalProvider
                                                    .getTheme()
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //   AddressWidget(currentOffer!, globalProvider),
                                  LocationAndOfferType(
                                      currentOffer, globalProvider),
                                  GlobalWidgets().divider(),
                                  TimeRow(currentOffer, globalProvider),
                                  currentOffer!.stellenbeschreibung == null
                                      ? SizedBox()
                                      : Center(
                                    child: GlobalWidgets().text(
                                        currentOffer!
                                            .stellenbeschreibung!,
                                        textColor: globalProvider
                                            .getTheme()
                                            .colorScheme
                                            .primary, fontSize: 18),
                                  ),
                                  /*       currentOffer!.yourProfile!.length ==  0 ? SizedBox(): showInfos(currentOffer!.yourProfile!, globalProvider),

                                  currentOffer!.tasks!.length ==  0 ? SizedBox():
                                 Center(child:  GlobalWidgets().text('Deine Aufgaben',fontSize: bigSize,textColor: globalProvider
                                     .getTheme()
                                     .colorScheme.primary, fontWeight: FontWeight.w900  ,italic: true),),
                                  currentOffer!.tasks!.length ==  0 ? SizedBox(): showInfos(currentOffer!.tasks!, globalProvider),
                                  currentOffer!.whatWeOffer!.length ==  0 ? SizedBox():
                                 Center(child:  GlobalWidgets().text('Wir bieten',fontSize: bigSize,textColor: globalProvider
                                     .getTheme()
                                     .colorScheme.primary, fontWeight: FontWeight.w900  ,italic: true),),
                                  currentOffer!.whatWeOffer!.length ==  0 ? SizedBox(): showInfos(currentOffer!.whatWeOffer!, globalProvider),
*/
                                  ApplyAndFavoriteRow(
                                      showDeleteButton: false,
                                      globalProvider: globalProvider,
                                      userProvider: userPro,
                                      offer: currentOffer,
                                      showFavoriteButton: false)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
