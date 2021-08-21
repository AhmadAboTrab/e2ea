import '../../Widgets/AppBarPhrmacy.dart';

import 'package:flutter/material.dart';

class BillCreator extends StatefulWidget {
  BillCreator({Key key}) : super(key: key);

  @override
  _BillCreatorState createState() => _BillCreatorState();
}

class _BillCreatorState extends State<BillCreator> {
  MediaQueryData mediaQueryData;

  List actions = [];
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBarPharmacy(
        title: 'Bill',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: mediaQueryData.size.height,
            width: mediaQueryData.size.width,
          ),
        ),
      ),
    );
  }
}
