import 'package:flutter/material.dart';

class DetailsOfBox extends StatefulWidget {
  DetailsOfBox({Key key}) : super(key: key);

  @override
  _DetailsOfBoxState createState() => _DetailsOfBoxState();
}

class _DetailsOfBoxState extends State<DetailsOfBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: IconButton(
            icon: Icon(Icons.access_alarm_outlined),
            onPressed: () async {

            },
          ),
        ),
      ),
    );
  }
}
