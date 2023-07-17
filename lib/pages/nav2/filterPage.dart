import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/widgets/dropdownSearchWidget.dart';
import 'package:provider/provider.dart';

import '../../providers/globalProvider.dart';
import '../../widgets/globalwidget.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);



  @override
  State<StatefulWidget> createState() {
    return _FilterPageState();
  }
}

final apiDatasRef = FirebaseFirestore.instance
    .collection('jobTags').get();

class _FilterPageState extends State<FilterPage> {
  TextEditingController controller = TextEditingController();
  List<String> jtags = [];

  @override
  void initState() {
    var offerProvider = context.read<OfferProvider>();
    offerProvider.fetchTagsAndOffers(null).then((value) {
      if(value != null) {
        setState(() {
         // jtags = value;
        });
      }
    });
    super.initState();

  }
  bool _isWorktimeExpanded = false;

  final List<String> _cast = <String>['Vollzeit', 'Teilzeit', 'Minijob'];
  final List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets {
    return _cast.map((String entry) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: FilterChip(
          label: Text(entry),
          selected: _filters.contains(entry),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(entry);
              } else {
                _filters.removeWhere((String name) {
                  return name == entry;
                });
              }
            });
          },
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    var globalProvider = context.read<GlobalProvider>();
    var offerProvider = context.read<OfferProvider>();
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(top: 40),
      decoration:
          BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GlobalWidgets().logoAndBAckButton(context, globalProvider, width: width),
          Text('Filter',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
          ExpansionTile(
              title: Text(
                'Arbeitszeit',
                style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              trailing: Icon(
                _isWorktimeExpanded
                    ? Icons.arrow_circle_up_sharp
                    : Icons.arrow_circle_down_sharp,
                color: Colors.black87,
              ),
              onExpansionChanged: (bool isExpanded) {
                print(isExpanded);
                setState(() {
                  _isWorktimeExpanded = isExpanded;
                });
              },
              children: [Wrap(children: actorWidgets.toList())]),
         GlobalWidgets().dropDownWidget(jtags, controller, offerProvider),

        ],
      ),
    );
  }
}
