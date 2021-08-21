import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class AlertDialoge extends StatefulWidget {
  const AlertDialoge({
    Key key,
    this.title,
    this.descriptions,
    this.text,
  }) : super(key: key);
  final String title;
  final String descriptions;
  final String text;

  @override
  _AlertDialogeState createState() => _AlertDialogeState();
}

class _AlertDialogeState extends State<AlertDialoge> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ), // bottom part
        Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                // child: Image.asset("assets/model.jpeg")),
                child: Icon(Icons.flip_outlined),
              ),
            )), // top part
      ],
    );
  }
}
