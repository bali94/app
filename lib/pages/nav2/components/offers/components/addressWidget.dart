import 'package:flutter/material.dart';
import 'package:juba/constants.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/widgets/globalwidget.dart';

class AddressWidget extends StatelessWidget {
  final OfferDetailDto currentOffer;
  final GlobalProvider? globalProvider;

  AddressWidget(this.currentOffer, this.globalProvider);

  @override
  Widget build(BuildContext context) {
    return  currentOffer.arbeitgeberAdresse?.plz == null ? SizedBox(): Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(

          children: [
            Icon(Icons.add_location, color: globalProvider!
                 .getTheme()
                 .colorScheme.primary,),
            Text(
              ' ${currentOffer.arbeitgeberAdresse!.plz ?? '' } , ${currentOffer.arbeitgeberAdresse!.ort?? ''}, ${currentOffer.arbeitgeberAdresse!.region ?? ''} ' ,
              overflow: TextOverflow.ellipsis, maxLines: 1, style: GlobalWidgets().style(
                textColor: globalProvider!
                    .getTheme()
                    .colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
