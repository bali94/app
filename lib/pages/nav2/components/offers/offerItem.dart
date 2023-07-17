import 'package:flutter/material.dart';
import 'package:juba/constants.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/company.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/models/user.dart';
import 'package:juba/pages/nav2/components/offers/components/addressWidget.dart';
import 'package:juba/pages/nav2/components/offers/components/applyAndFavoriteRow.dart';
import 'package:juba/pages/nav2/components/offers/components/locationAndOfferType.dart';
import 'package:juba/pages/nav2/components/offers/components/timeRow.dart';
import 'package:juba/pages/nav2/components/offers/offerdetails.dart';
import 'package:juba/providers/companyProvider.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class OfferItem extends StatelessWidget {
  final OfferDetailDto? currentOffer;
  final bool? showFavoriteButton;
  final bool? showDeleteButton;
  final bool? withMoreDetails;

  OfferItem(this.currentOffer, this.showFavoriteButton,this.showDeleteButton, this.withMoreDetails);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var globalProvider = context.watch<GlobalProvider>();
    final userPro = context.watch<UserProvider>();

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: globalProvider
            .getTheme()
            .colorScheme.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            currentOffer?.arbeitgeber == null ? SizedBox():Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      currentOffer?.arbeitgeber?.toUpperCase() ?? '',
                      style: GlobalWidgets().style(
                          textColor: globalProvider
                              .getTheme()
                              .colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: kBigSize, italic: true,),
                    ),
                  ),
                )),
              ],
            ),
            currentOffer?.beruf == ''||  currentOffer?.beruf == '/' ? SizedBox():Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentOffer?.beruf ?? '',
                          style: GlobalWidgets().style(
                            textColor: globalProvider
                                .getTheme()
                                .colorScheme.primary,
                            fontWeight: FontWeight.w900,
                             italic: true,),
                        ),
                      ),
                    )),
              ],
            ),
            currentOffer?.titel == ''||  currentOffer?.titel == '/' ? SizedBox():Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentOffer?.titel ?? '',
                          style: GlobalWidgets().style(
                            textColor: globalProvider
                                .getTheme()
                                .colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            italic: true,),
                        ),
                      ),
                    )),
              ],
            ),
          //  LocationAndOfferType(currentOffer!,globalProvider),
            GlobalWidgets().divider(),
            TimeRow(currentOffer, globalProvider),
            currentOffer!.stellenbeschreibung == null || withMoreDetails == false
                ? SizedBox()
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
              child: Text(currentOffer!.stellenbeschreibung!,overflow: TextOverflow.ellipsis, maxLines: 2, style: GlobalWidgets().style(textColor: globalProvider.getTheme().colorScheme.primary, italic: true),)
            ),
                ),
            ApplyAndFavoriteRow(showDeleteButton: showDeleteButton, globalProvider:globalProvider, userProvider: userPro, offer: showFavoriteButton == false ? currentOffer: checkIfOfferIsInMyFavoritList(currentOffer!, userPro.currentUser), showFavoriteButton: showFavoriteButton,)

          ],
        ),
      ),
    );
  }
  OfferDetailDto checkIfOfferIsInMyFavoritList(OfferDetailDto offer, User? currentUser){
    if(currentUser == null ) return offer;
    int index = currentUser.yourFavoritesOffers!.indexWhere((element) => element.hashId == offer.hashId);
    if(index >= 0){
      offer.isFavorite = true;
    }
    return offer;
  }
}
