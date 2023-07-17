import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/apiHelper.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/helpers/mapHelper.dart';
import 'package:juba/models/companyDTO.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/providers/companyProvider.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../models/user.dart';

class ApplyAndFavoriteRow extends StatefulWidget {
  final GlobalProvider? globalProvider;
  final bool? showDeleteButton;
  final UserProvider? userProvider;
  final OfferDetailDto? offer;
  final bool? showFavoriteButton;

  const ApplyAndFavoriteRow(
      {Key? key,
      this.showDeleteButton,
      this.globalProvider,
      this.userProvider,
      this.offer,
      this.showFavoriteButton})
      : super(key: key);

  @override
  State<ApplyAndFavoriteRow> createState() => _ApplyAndFavoriteRowState();
}

class _ApplyAndFavoriteRowState extends State<ApplyAndFavoriteRow> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  bool _liked = false;

  bool get liked => _liked;

  set liked(bool value) {
    _liked = value;
  }

  @override
  void initState() {
    super.initState();
    _liked = widget.offer!.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            var companyProvider = context.read<CompanyProvider>();

            setState(() {
              isLoading = true;
            });
            await ApiHelper().getJwtToken();
            var res = await ApiHelper().getChallengeId();
            var response = await ApiHelper().getCaptcha(res!);
            File? file = response;
            if (file != null) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return captchaDialog(
                      context,
                      file,
                      controller,
                      widget.offer!.hashId!,
                      res,
                      companyProvider,
                      widget.globalProvider!,
                      kRedColor,
                    );
                  });
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }

            // MainHelper().funcOpenMailComposer('juba@gmail.com', widget.offer?.beruf ?? '');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: kBlueColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(8.0),
              child: isLoading == true
                  ? GlobalWidgets().circular(context)
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              S.of(context).emailApply,
                              style: GlobalWidgets().style(
                                  textColor: widget.globalProvider!
                                      .getTheme()
                                      .colorScheme
                                      .primary,
                                  fontSize: kMediumSize,
                                  fontWeight: FontWeight.w900,
                                  italic: true),
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.send,
                            color: widget.globalProvider!
                                .getTheme()
                                .colorScheme
                                .primary,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
        Row(
          children: [
            widget.showFavoriteButton == false
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      if (widget.userProvider?.currentUser != null) {
                        widget.userProvider!
                            .editUserFavoriteOffers(widget.offer!, !liked);
                        setState(() {
                          liked = !liked;
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return GlobalWidgets().popUp(
                                  S.of(context).notice,
                                  S.of(context).loginNotify,
                                  context,
                                  kRedColor);
                            });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        size: kBigSize,
                        color: liked
                            ? Colors.red
                            : widget.globalProvider!.getTheme().colorScheme.primary
                      ),
                    ),
                  ),
            widget.showDeleteButton == false
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      widget.userProvider!.currentUser!.yourFavoritesOffers!
                          .removeWhere((element) =>
                              element.hashId == widget.offer!.hashId);
                      widget.userProvider!
                          .updateUser(widget.userProvider!.currentUser!);
                      widget.userProvider!
                          .setUser(widget.userProvider!.currentUser!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Icon(
                        Icons.delete,
                        size: kBigSize,
                        color: widget.globalProvider!
                            .getTheme()
                            .colorScheme
                            .primary,
                      ),
                    ),
                  ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () async {
                var res =
                    await MainHelper().createDynamicLink(widget.offer!.hashId!);
                final box = context.findRenderObject() as RenderBox?;
                await Share.share(res,
                    subject: S.of(context).newJobs,
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 8),
                child: Icon(Icons.share_sharp,
                    color:
                        widget.globalProvider!.getTheme().colorScheme.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }

  captchaDialog(
    BuildContext context,
    File file,
    TextEditingController controller,
    String hashId,
    dynamic res,
    CompanyProvider companyProvider,
    GlobalProvider globalProvider,
    Color titleColor, {
    Color textColor = kGreyColor,
  }) {
    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 80, child: Image.file(file)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: S.of(context).captcha,
              hintStyle: GlobalWidgets().style(italic: true)),
        ),
        SizedBox(height: 5),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () async {
              if (controller.text.isNotEmpty) {
                CompanyDTO? resp = await ApiHelper()
                    .getCompanyData(res!, hashId, controller.text);
                companyProvider.setCompanyDTO(resp);
                Navigator.pop(context);
                if (resp == null) {
                  return;
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return companyDetailsDialog(
                          resp,
                          widget.globalProvider!,
                          context,
                          kRedColor,
                        );
                      });
                }
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    color: kBlueColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.of(context).send,
                      style: TextStyle(
                          color: globalProvider.getTheme().colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: kMediumSize)),
                )),
          ),
        )
      ],
    ));
  }

  companyDetailsDialog(
    CompanyDTO companyDTO,
    GlobalProvider globalProvider,
    BuildContext context,
    Color titleColor, {
    Color textColor = kGreyColor,
  }) {
    Festnetznummer? festsNetz =
        companyDTO.angebotskontakt?.festnetznummer ?? null;
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        contentPadding: EdgeInsets.zero,
        backgroundColor: kBlueColor.withOpacity(0.5),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: globalProvider.getTheme().colorScheme.secondary),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                companyDTO.angebotskontakt?.firma == null
                    ? SizedBox()
                    : Text(
                        companyDTO.angebotskontakt?.firma ??
                            '${companyDTO.angebotskontakt!.vorname} ${companyDTO.angebotskontakt!.nachname}',
                        style: TextStyle(
                            color:
                                globalProvider.getTheme().colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: kBigSize,
                            fontStyle: FontStyle.italic)),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.offer?.titel ?? '',
                    style: TextStyle(
                      color: globalProvider.getTheme().colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: kMediumSize,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                companyDTO.agBewerbungUrl == null
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          S.of(context).applyWebsite,
                          style: TextStyle(
                            color:
                                globalProvider.getTheme().colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: kMediumSize,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                companyDTO.agBewerbungUrl == null
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          MainHelper()
                              .launchInBrowser(companyDTO.agBewerbungUrl!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            companyDTO.agBewerbungUrl!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: kBlue2Color,
                                fontWeight: FontWeight.w900,
                                fontSize: kSmallSize,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                companyDTO.angebotskontakt?.strasse == null
                    ? SizedBox()
                    : InkWell(
                        onTap: () async {
                          //LatLng compnayLocation = LatLng(widget.offer.ab, longitude)
                          var res = await MapHelper().setInitialLocation();
                          if (res != null) {
                            // MapHelper().startWebNavigation(res['currentLocation'], .companyLocation)
                          }
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${companyDTO.angebotskontakt?.strasse},\n${companyDTO.angebotskontakt?.plz} ${companyDTO.angebotskontakt?.ort}\n${companyDTO.angebotskontakt?.region}',
                                style: TextStyle(
                                    color: kBlue2Color,
                                    fontSize: kMediumSize,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            /* SizedBox(width: 7),
                      Card(
                        color: kBlueColor.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.route,
                              size: kBigSize,
                              color: widget.globalProvider!
                                  .getTheme()
                                  .colorScheme
                                  .primary),
                        ),
                      ),*/
                          ],
                        ),
                      ),
                festsNetz?.rufnummer == null
                    ? SizedBox()
                    : InkWell(
                        onTap: () async {
                          MainHelper().makePhoneCall(
                              '${festsNetz!.laendervorwahl!}${festsNetz.vorwahl}${festsNetz.rufnummer!}');
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${festsNetz!.laendervorwahl!}${festsNetz.vorwahl}${festsNetz.rufnummer!}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: globalProvider
                                      .getTheme()
                                      .colorScheme
                                      .primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: kMediumSize,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            SizedBox(width: 7),
                            Card(
                              color: kBlueColor.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.call,
                                    size: kBigSize,
                                    color: widget.globalProvider!
                                        .getTheme()
                                        .colorScheme
                                        .primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                companyDTO.angebotskontakt?.email == null
                    ? SizedBox()
                    : InkWell(
                        onTap: () async {
                          MainHelper().funcOpenMailComposer(
                              companyDTO.angebotskontakt!.email!,
                              widget.offer?.beruf ?? '');
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  companyDTO.angebotskontakt!.email!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: globalProvider
                                        .getTheme()
                                        .colorScheme
                                        .primary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: kMediumSize,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: kBlueColor.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.email,
                                    size: kBigSize,
                                    color: widget.globalProvider!
                                        .getTheme()
                                        .colorScheme
                                        .primary),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
