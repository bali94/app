import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/apiHelper.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/models/jobTags.dart';
import 'package:juba/models/offerdetailDTO.dart';
import 'package:juba/pages/nav/components/searchPage.dart';
import 'package:juba/pages/nav2/components/offers/offerItem.dart';
import 'package:juba/pages/nav2/components/offers/offerdetails.dart';
import 'package:juba/pages/select_list_controller.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OffersList extends StatefulWidget {
  final String? companyName;

   OffersList( this.companyName);
  @override
  State<OffersList> createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  ScrollController _scrollController = new ScrollController();
  List<OfferDetailDto>? stellenList = [];
  TextEditingController searchController = TextEditingController();

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  var controller = Get.put(SelectedListController());

  List<JobTags> jtags = [];
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  int count = 20;
  bool isLoading = false;
  bool addSearchQuery = false;
  bool areTagsLoading = false;



  bool isUserScrolling = false;
  String sortBy = 'branche';

  @override
  void initState() {
    var offerProvider = context.read<OfferProvider>();
    if(widget.companyName == null && offerProvider.stellen != null && offerProvider.stellen!.isNotEmpty == true){
      setState(() {
        stellenList = offerProvider.stellen;
      });
    }else{
      fetchMyOffers();
    }
    _scrollController.addListener(_onScroll);
    super.initState();

  }
_scrollToPop(){

  _scrollController.animateTo(
    _scrollController.position.minScrollExtent,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 500),
  );

}
  void _onScroll() {
    final offset = _scrollController.offset;
    final minOffset = _scrollController.position.minScrollExtent;
    final maxOffset = _scrollController.position.maxScrollExtent;
    final isOutOfRange = _scrollController.position.outOfRange;

    final hasReachedTheEnd = offset >= maxOffset && !isOutOfRange;
    final hasReachedTheStart = offset <= minOffset && !isOutOfRange;
    final isScrolling = maxOffset > offset && minOffset < offset;

    if (isScrolling) {
      setState(() {
        isUserScrolling = true;
      });
    } else if (hasReachedTheStart) {
        setState(() {
          isUserScrolling = false;
        });
    } else if (hasReachedTheEnd && widget.companyName == null) {
     if( addSearchQuery == false ){
       setState(() {
         count += 10;
       });
       fetchMyOffers();
     }
    }
  }

  Future<void> fetchMyOffers() async {
    setState(() {
      isLoading = true;
    });
    List<OfferDetailDto> stll = [];
    stll = await getList();
    setState(() {
      stellenList = stll;
    });
    setState(() {
      isLoading = false;
    });
  }
  Future<List<OfferDetailDto>> getList()async{
    var offerProvider = context.read<OfferProvider>();
      return await offerProvider.fetchOffers(companyName: widget.companyName, limit:  widget.companyName != null ? 0:count) ?? [];

  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    try {
      _connectivitySubscription?.cancel();
    } catch (exception) {
      print(exception.toString());
    }
    super.dispose();
  }



  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  bool _isConnected() {
    return _connectionStatus != 'ConnectivityResult.wifi' &&
        _connectionStatus != 'ConnectivityResult.mobile';
  }
  void openFilterDialog(context, OfferProvider offerProvider) async {
    var res =  await offerProvider.fetchTagsAndOffers('');
    await FilterListDialog.display<JobTags>(context,
        listData: res!,
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
          offerProvider.setTagsOffers();
          offerProvider.fetchTagJobsByMultipleId(list);
          setState(() {
            addSearchQuery = true;
            areTagsLoading = false;
          });
          Navigator.of(context).pop();
        });

  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var offerProvider = context.watch<OfferProvider>();
    var globalProvider = context.watch<GlobalProvider>();

    return Scaffold(
      floatingActionButton: isUserScrolling == false ? SizedBox():FloatingActionButton(
        onPressed: () {
        _scrollToPop();
        },
        backgroundColor:globalProvider.getTheme().colorScheme.primary,
        child:  Icon(Icons.vertical_align_top_outlined,color: globalProvider.getTheme().colorScheme.secondary, ),
      ),
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            widget.companyName != null ?  Padding(
        padding:  EdgeInsets.only(left :width > 767 ? 90:20,right :width > 767 ? 90:20 ,top: 50, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
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
                        color: globalProvider
                            .getTheme()
                            .colorScheme
                            .primary,
                      ),
                    ))),
            Flexible(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.companyName!, overflow: TextOverflow.ellipsis, maxLines: 1 ,style: GlobalWidgets().style(textColor: kWhiteColor, fontSize: kBigSize,fontWeight: FontWeight.w900),
                    )
                )
            ),
          ],
        ),

      ):GlobalWidgets().logoAndBAckButton(context, globalProvider,
                withFilterButton: true, width: width),
              Expanded(
                child: Container(
                  width: MainHelper().responsiveWidth(width),
                  child: Center(
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          gradient: GlobalWidgets().gradient2(globalProvider)),
                      child: stellenList == null
                          ? GlobalWidgets().linear(context)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.companyName != null ? SizedBox():Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      addSearchQuery == true
                                          ? Expanded(child:  TypeAheadFormField(
                                        hideOnEmpty: true,
                                        hideOnLoading: false,
                                        autoFlipDirection: true,
                                        suggestionsCallback: (pattern) async {
                                          offerProvider.setTagsOffers();
                                          var response = await offerProvider.fetchTagsAndOffers(pattern) ?? [];

                                          return response.toList();
                                        },
                                        itemBuilder: (context, dynamic suggestion) {
                                          return Container(
                                            child: ListTile(
                                              leading: const Icon(
                                                Icons.wallet_travel_outlined,
                                                color: kGreyColor,
                                              ),
                                              title: Text(
                                                suggestion!.name!,
                                                style: GlobalWidgets()
                                                    .style(textColor: kGreyColor),
                                              ),
                                            ),
                                          );
                                        },
                                        onSuggestionSelected: ( dynamic suggestion) {
                                          setState(() {
                                            searchController.text = suggestion!.name!;
                                          });
                                         offerProvider.setSearchQuery(suggestion.name);
                                          offerProvider.getTagJobsById(suggestion.id);
                                        },
                                        textFieldConfiguration: TextFieldConfiguration(
                                            onTap: () => searchController.selection =
                                                TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset:
                                                    searchController.value.text.length),
                                            autofocus: false,
                                            cursorColor: ThemeData().colorScheme.primary,
                                            controller: searchController,
                                            style: TextStyle(
                                              color: kBlackColor,
                                            ),
                                            decoration: InputDecoration(

                                                contentPadding: EdgeInsets.all(9.0),
                                                filled: true,
                                                fillColor: kWhiteColor.withOpacity(0.5),
                                                labelText: S.of(context).job,
                                                labelStyle: GlobalWidgets()
                                                    .style(fontWeight: FontWeight.w900,textColor: globalProvider.getTheme().colorScheme.primary, italic: true))),
                                        noItemsFoundBuilder: (ctx) {
                                          return Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                             S.of(context).noResults,
                                              style: GlobalWidgets()
                                                  .style(fontWeight: FontWeight.w900),
                                            ),
                                          );
                                        },
                                      ),)
                                          : isLoading == true ? SizedBox(): Row(

                                            children: [
                                                      InkWell(
                                                onTap: () {
                                                  showMaterialModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          SingleChildScrollView(
                                                        controller:
                                                            ModalScrollController.of(
                                                                context),
                                                        child: Column(
                                                          children: [
                                                            GlobalWidgets().text(
                                                                S.of(context).sort,
                                                                textColor: globalProvider
                                                                    .getTheme()
                                                                    .colorScheme
                                                                    .primary,
                                                                italic: true,
                                                                fontWeight:
                                                                    FontWeight.w900,
                                                                fontSize: kBigSize),
                                                            radio(
                                                                globalProvider,
                                                                1,
                                                                false,
                                                                S.of(context).entryDate),
                                                            radio(
                                                                globalProvider,
                                                                2,
                                                                false,
                                                                S.of(context).companySize),
                                                            radio(globalProvider, 3,
                                                                false, S.of(context).publication),
                                                            radio(
                                                                globalProvider,
                                                                4,
                                                                false,
                                                                S.of(context).employer),
                                                          ],
                                                        ),
                                                      ),
                                                  );
                                                },
                                                child: Card(
                                                      color: kBlueColor.withOpacity(0.4),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Icon(
                                                          Icons.filter_alt_rounded,
                                                          size: kBigSize,
                                                          color: globalProvider
                                                              .getTheme()
                                                              .colorScheme
                                                              .secondary,
                                                        ),
                                                      ))),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      areTagsLoading = true;
                                                    });
                                                    openFilterDialog(context, offerProvider);
                                                  },
                                                  child: Card(
                                                      color: kBlueColor.withOpacity(0.4),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(8.0),
                                                        child: areTagsLoading == true ? GlobalWidgets().circular(context): Icon(
                                                          Icons.sort,
                                                          size: kBigSize,
                                                          color: globalProvider
                                                              .getTheme()
                                                              .colorScheme
                                                              .secondary,
                                                        ),
                                                      ))),
                                                    ],
                                          ),
                                      GestureDetector(
                                        onTap: () {
                                         offerProvider.setSearchQuery(null);
                                         searchController.clear();
                                         setState(() {
                                           addSearchQuery = !addSearchQuery;
                                         });
                                         offerProvider.setTagsOffers();
                                          //MainHelper.routeTo(context, SearchOfferPage());

                                        },
                                        child:  Card(
                                            color: kBlueColor.withOpacity(0.4),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(addSearchQuery == true ? Icons.clear :Icons.search,
                                                  color:addSearchQuery == true ? globalProvider.getTheme().colorScheme.primary :   globalProvider.getTheme().colorScheme.secondary, size: kBigSize),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                  addSearchQuery == false? SizedBox(): Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                  child: Text("${ offerProvider.tagOffers.length } Ergebnisse", style: GlobalWidgets().style(textColor: globalProvider.getTheme().colorScheme.primary,fontWeight: FontWeight.w900, italic: true),),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.only(top:6),
                                      separatorBuilder: (ctx, i) {
                                        return SizedBox(
                                          height: 20,
                                        );
                                      },
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      itemCount: offerProvider.tagOffers.isNotEmpty == true && widget.companyName == null ? offerProvider.tagOffers.length: stellenList!.length,
                                      itemBuilder: (ctx, i) {
                                        var currentStelle = offerProvider.tagOffers.isNotEmpty == true && widget.companyName == null ? offerProvider.tagOffers[i] : stellenList![i];
                                        return InkWell(
                                          onTap: () {
                                            MainHelper.routeTo(context,
                                                OfferDetails(currentStelle, false));
                                          },
                                          child:
                                              OfferItem(currentStelle, true, false, false),
                                        );
                                      }),
                                ),
                                isLoading == false
                                    ? SizedBox()
                                    : Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: GlobalWidgets().linear(context))
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
      ),
    );
  }

  radio(GlobalProvider globalProvider, int number, bool selected, String txt) {
    var offerProvider = context.read<OfferProvider>();
    return RadioListTile(
      value: number,
      groupValue: globalProvider.selectedRadioTile,
      title: GlobalWidgets().text(txt,
          textColor: globalProvider.getTheme().colorScheme.primary,
          italic: true),
      onChanged: (val) {
        globalProvider.setSelectedRadioTile(val);
        switch (val) {
          case 1:
            offerProvider.setSortQuery('eintrittsdatum');
            fetchMyOffers();
            Navigator.pop(context);
            return;
          case 2:
            offerProvider.setSortQuery('betriebsgroesse');
            fetchMyOffers();
            Navigator.pop(context);
            return;
          case 3:
            offerProvider.setSortQuery('aktuelleVeroeffentlichungsdatum');
            fetchMyOffers();
            Navigator.pop(context);
            return;
          case 4:
            offerProvider.setSortQuery('arbeitgeber');
            fetchMyOffers();
            Navigator.pop(context);
            return;
        }
      },
      activeColor: globalProvider.getTheme().colorScheme.primary,
      selected: selected,
    );
  }
}
/*
* Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),

                      gradient: GlobalWidgets().gradient2(globalProvider)
                  ),
                  child: Column(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.chevron_left)),
                      Expanded(child:   ListView.separated(
                        separatorBuilder: (ctx, i){
                          return SizedBox(height: 20,);
                        },
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: stellenList!.length,
                          itemBuilder: (ctx, i){
                            var currentStelle = stellenList![i];
                            return GestureDetector(
                              onTap: () {
                                MainHelper.routeTo(context, OfferDetails(currentStelle));

                              },
                              child:OfferItem(currentStelle, true, false),
                            );}),),
                      isLoading == false ? SizedBox(): Padding(padding: EdgeInsets.only(top:10),
                         child: GlobalWidgets().circular(context))
                    ],
                  ),
                ),*/
//#2BA8FF #33A3F1 #2B93DC #238CD5 #1E6B9F #195781 #0F3C5C
