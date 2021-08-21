import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class MainOpCard extends StatelessWidget {
  const MainOpCard({
    Key key,
    this.data,
    this.color,
    this.index,
    this.pressInformation,
    this.press,
    this.mediaQueryData,
    this.textGridView,
  }) : super(key: key);

  final List color;
  final List<Map<String, String>> data;
  final int index;
  final Function pressInformation;
  final Function press;
  final MediaQueryData mediaQueryData;
  final String textGridView;

  @override
  Widget build(BuildContext context) {
    String contentOfMainBox;
    contentOfMainBox = data[index]
        .keys
        .toString()
        .substring(1, data[index].keys.toString().length - 1)
        .trim();

    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        margin:
            EdgeInsets.symmetric(horizontal: mediaQueryData.size.width * 0.002),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            // color: Color(0xFFB0BCC5).withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.withOpacity(0.5),
                      Colors.grey.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                onPressed: pressInformation,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mediaQueryData.size.height * 0.05,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text(
                                contentOfMainBox,
                                textAlign: TextAlign.center,
                                textDirection: ui.TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  //fontFamily: 'DancingScript',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
