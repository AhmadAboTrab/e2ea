import '../../../models/employee.dart';

import '../../Controller/Api/Search/SearchWithAbstractMedicen/SearchByBarcode.dart';

import '../../Widgets/SearchBy_flutterTypeHead.dart';
import '../../localization/localizations_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'components/Body.dart';

// ignore: must_be_immutable
class AddOrUpdateMed extends StatefulWidget {
  AddOrUpdateMed({
    this.mediaQueryData,
    this.employee,
    key,
  }) : super(key: key);
  MediaQueryData mediaQueryData;
  List<TextEditingController> textEditingControllerList =
      List<TextEditingController>.generate(
          20, (index) => new TextEditingController());
  bool isSearching = true;
  Employee employee;

  @override
  _AddOrUpdateMedState createState() => _AddOrUpdateMedState();
}

class _AddOrUpdateMedState extends State<AddOrUpdateMed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isSearching
            ? Container(
                child: FittedBox(
                  child: Text(
                    DemoLocalizations.of(context)
                        .translate('titleAppbarEditiingPage'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DancingScript',
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SearchByFlutterTypeHead(
                suggestionsCallback: SearchByBarcode().getUserSugesstions,
              ), //trade name search

        actions: [
          !widget.isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      widget.isSearching = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      widget.isSearching = false;
                    });
                  },
                ),
          IconButton(
              onPressed: () {
                setState(() {
                  for (int i = 0;
                      i < widget.textEditingControllerList.length;
                      i++) {
                    widget.textEditingControllerList[i].text = '';
                  }
                });
              },
              icon: Icon(Icons.delete_sharp)),
        ],
      ),
      body: BodyAddedPage(
        employee:widget.employee,
        textEditingControllerList: widget.textEditingControllerList,
      ),
    );
  }
}
