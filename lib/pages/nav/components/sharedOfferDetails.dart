import 'package:flutter/material.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/pages/nav2/components/offers/offerdetails.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/widgets/globalwidget.dart';

class ShardeOfferDetails extends StatefulWidget {
  final String? offerId;

  const ShardeOfferDetails({Key? key, this.offerId}) : super(key: key);
  @override
  _ShardeOfferDetailsState createState() => _ShardeOfferDetailsState();
}

class _ShardeOfferDetailsState extends State<ShardeOfferDetails> {
  OfferDetailDto? offer;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
   getOfferById(widget.offerId!);
  }
  getOfferById(String offerId) async  {
    var offerT = await fullOffersDatasRef.doc(offerId).get().then((snapshot) => snapshot.data()!);
    if(offerT.hashId != null){
      setState(() {
        offer = offerT;
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return isLoading == true ? GlobalWidgets().circular(context):OfferDetails(offer, true);
  }
}
