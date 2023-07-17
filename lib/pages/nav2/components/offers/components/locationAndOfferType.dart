import 'package:flutter/material.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/widgets/globalwidget.dart';

class LocationAndOfferType extends StatelessWidget {
  final OfferDetailDto? currentOffer;
  final GlobalProvider? globalProvider;

  LocationAndOfferType(this.currentOffer, this.globalProvider);
  @override
  Widget build(BuildContext context) {
    return currentOffer?.arbeitsorte == null ? SizedBox():showInfos(currentOffer!.arbeitsorte!, globalProvider!);
  }
}
showInfos(List<Arbeitsorte> list, GlobalProvider globalProvider){
  return Wrap(
    children: List.generate(
        list.length, (int i){
      var data = list[i];
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.ort?? '' ,
            style: GlobalWidgets().style(
              textColor: globalProvider
                  .getTheme()
                  .colorScheme.primary,italic: true

            ),
          ),
        ),
      );
    }),
  );
}
/*
*     Row(
          children: [
            Icon(Icons.wallet_travel_rounded, color: globalProvider!
                .getTheme()
                .colorScheme.primary,),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Job'  ,
                  style: GlobalWidgets().style(
                    textColor:  globalProvider!
                        .getTheme()
                        .colorScheme.primary,
//
                  ),
                ),
              ),
            ),
          ],
        ),*/