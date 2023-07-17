import 'package:flutter/material.dart';
import 'package:juba/constants.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeRow extends StatelessWidget {
  final OfferDetailDto? currentOffer;
  final GlobalProvider? globalProvider;

  TimeRow(this.currentOffer, this.globalProvider);
  @override
  Widget build(BuildContext context) {

    return currentOffer!.eintrittsdatum == null ? SizedBox():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentOffer?.eintrittsdatum ==  null ? SizedBox():Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Icon(Icons.wallet_travel, color:  globalProvider!
                      .getTheme()
                      .colorScheme.primary,),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                     'ab  ' +  MainHelper().formatedDate(currentOffer!.eintrittsdatum!),
                      style: GlobalWidgets().style(
                        textColor:  globalProvider!
                            .getTheme()
                            .colorScheme.primary,fontWeight: FontWeight.w900,fontSize: kSmallSize,italic: true

                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  padding: const EdgeInsets.all( 4.0),
                  decoration: BoxDecoration(
                      color: kBlueColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30)),
                  child: GlobalWidgets().text(currentOffer!.angebotsart  == '1'? 'Job': 'Ausbildung', textColor: globalProvider!
                      .getTheme()
                      .colorScheme.primary, fontWeight: FontWeight.w900, italic: true, fontSize: kMediumSize, underLine: true),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: GlobalWidgets().text(timeago.format(DateTime.parse(currentOffer!.aktuelleVeroeffentlichungsdatum!), locale: 'de'), textColor: globalProvider!
                    .getTheme()
                    .colorScheme.primary, fontWeight: FontWeight.w900, italic: true, fontSize: kSmallSize),
              )
            ],
          ),


      ],
    );
  }
}
