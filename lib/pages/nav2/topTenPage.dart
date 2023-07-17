import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juba/constants.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/pages/nav/components/startpage.dart';
import 'package:juba/pages/nav2/components/offers/offerItem.dart';
import 'package:juba/pages/nav2/components/offers/offerdetails.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
class TopTenPage extends StatefulWidget {
  @override
  _TopTenPageState createState() => _TopTenPageState();
}

class _TopTenPageState extends State<TopTenPage> {
  final AppinioSwiperController controller = AppinioSwiperController();
  bool isLoading = true;
  List<OfferDetailDto>? topTenOffers;
  OfferDetailDto? offerDetailDto;
  @override
  void initState() {
    var offerProvider = context.read<OfferProvider>();
    offerProvider.topTenOffer(context.read<UserProvider>().currentUser).then((value) {
      setState(() {
        topTenOffers = value;
        isLoading = false;
      });
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    double width = MediaQuery.of(context).size.width;
    return globalProvider.showContactPage == false
        ? StartPage()
        : Container(
              decoration: BoxDecoration(
                gradient: GlobalWidgets().gradient(globalProvider)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalWidgets().logoAndBAckButton(context, globalProvider, width: width),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                    child: Text(
                        'Erkunde deine heutigen Stellen-Empfehlungen', textAlign: TextAlign.center,style: TextStyle(
                      color: kWhiteColor, fontWeight: FontWeight.w900,fontSize: kBigSize
                    ),
                    ),
                  ),
                  Expanded(
                    // ignore: unrelated_type_equality_checks
                    child: isLoading == true ? Center(
                      child:GlobalWidgets().text('lädt ...', textColor: kWhiteColor),
                    ):VxSwiper.builder(
                      height: MediaQuery.of(context).size.height * 0.57,
                      itemCount: topTenOffers!.length,
                      aspectRatio: 1.0,
                      enlargeCenterPage: true,
                      onPageChanged: (index) {
                        setState(() {
                          offerDetailDto = topTenOffers![index];
                        });
                      },
                      itemBuilder: (context, index) {
                        final currentOffer = topTenOffers![index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: InkWell(
                            onTap: () => MainHelper.routeTo(context, OfferDetails(offerDetailDto, false)),
                              child: OfferItem(currentOffer, true, false, true)
                          ),
                        );
                      },
                    ).centered(),
                  ),
                  /*
                  isLoading == true ? SizedBox(): Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 60.0),
                    child: InkWell(
                      onTap: (){
                        MainHelper.routeTo(context, OfferDetails(offerDetailDto, false));
                      },
                      child:  Container(
                        decoration: BoxDecoration(
                            color: kBlueColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Details', textAlign: TextAlign.center,style: TextStyle(
                                  color: kWhiteColor, fontWeight: FontWeight.w900,fontSize: kMediumSize, fontStyle: FontStyle.italic
                              ),
                              ),
                            ),
                             Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_right_alt, size: 30,color: kWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  */
                ],
              ),
            );
  }
  /*
  *    Expanded(
                  child: CupertinoPageScaffold(
                    child: Column(
                      children: [
                        GlobalWidgets().logoAndBAckButton(context, globalProvider),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: AppinioSwiper(

                            controller: controller,
                            cards: cardsWidget(),
                            onSwipe: _swipe,
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 50,
                              bottom: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
  void _swipe(int index) {
    //print("swipe");
  }
  cardsWidget() {
    return List.generate(
        5,
        (index) => Card(
              child: Image.asset('images/144.png'),
            ));
  }
}
