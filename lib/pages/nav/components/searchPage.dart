// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:juba/pages/nav/components/questionAnswer.dart';

import 'package:provider/provider.dart';

import '../../../providers/globalProvider.dart';
import '../../../widgets/globalwidget.dart';


class SearchPage extends SearchDelegate<String>  {


  final cities = [
    'Ausbildung',
    'Bewerbung',
    'Referenzen',
    'Praktikum',
    'Jugendliche',
  ];


  final recentCities = [
    'Ausbildung',
    'Bewerbung',
    'Jugendliche',
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null!);
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    )
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.of(context).pop(),
  );

  @override
  Widget buildResults(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_city, size: 120),
        const SizedBox(height: 48),
        Text(
          query,
          style: TextStyle(
            color: Colors.black,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities.where((city) {
      final cityLower = city.toLowerCase();
      final queryLower = query.toLowerCase();

      return cityLower.startsWith(queryLower);
    }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      final suggestion = suggestions[index];
      final queryText = suggestion.substring(0, query.length);
      final remainingText = suggestion.substring(query.length);

      return ListTile(
        onTap: () {
          query = suggestion;

          // 1. Show Results
          showResults(context);

          // 2. Close Search & Return Result
          // close(context, suggestion);

          // 3. Navigate to Result Page
          //  Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ResultPage(suggestion),
          //   ),
          // );
        },
        leading: Icon(Icons.location_city),
        // title: Text(suggestion),
        title: RichText(
          text: TextSpan(
            text: queryText,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: remainingText,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

/*  @override
  Widget buildSuggestions(BuildContext context) {

    final _question = query.isEmpty ? question : [];
    return ListView.builder(
      itemCount: _question.length,ber
      itemBuilder: (content, index) => ListTile(
          onTap: () {
            query = _question[index];
            // Make your API call to get the result
            // Here I'm using a sample result
            showResults(context);
          },
          title: Text(_question[index])),
    );

  }*/
}