import 'dart:async';

import '../localization/localizations_demo.dart';

import '../models/Product.dart';

import '../views/PageMedicins/PageMedicins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchByFlutterTypeHead extends StatelessWidget {
  const SearchByFlutterTypeHead({Key key, this.suggestionsCallback})
      : super(key: key);
  final FutureOr<Iterable<Object>> Function(String) suggestionsCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TypeAheadField(
        hideSuggestionsOnKeyboardHide: false,

        //debounceDuration: Duration(milliseconds: 500),
        suggestionsCallback: suggestionsCallback,

        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            // border: OutlineInputBorder(
            //   gapPadding: 3.0,
            //   borderSide: BorderSide(
            //     color: Colors.white,
            //     width: 12,
            //   ),
            //   borderRadius: BorderRadius.circular(25),
            // ),
            hintText:
                DemoLocalizations.of(context).translate('hintTextSearchField'),
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        itemBuilder: (context, suggesstion) {
          final user = suggesstion;
          return ListTile(
            title: Text(user.name),
          );
        },
        noItemsFoundBuilder: (context) => Center(
          child: Text(
            'employee Not found',
            style: TextStyle(fontSize: 20),
          ),
        ),
        onSuggestionSelected: (suggesstion) {
          if (suggesstion is Product) {
            // suggesstion.indications = 'jskjksdja';
            // print("inde is. : : " + suggesstion.indications);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PageMedicins(
                          product: suggesstion,
                        )));
          }
          // Navigator.push(context, route)
        },
      ),
    );
  }
}
