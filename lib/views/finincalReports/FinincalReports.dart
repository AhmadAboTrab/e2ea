import 'package:e2ea/Widgets/BottomNavTab.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FinincalReports extends StatefulWidget {
  FinincalReports({Key key, this.mediaQueryData}) : super(key: key);
  final MediaQueryData mediaQueryData;

  bool daily = false, monthly = false, yearly = false;

  bool checkPresentTime = true;
  DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
  TextEditingController dailyDate;

  @override
  _FinincalReportsState createState() => _FinincalReportsState();
}

class _FinincalReportsState extends State<FinincalReports> {
  @override
  void initState() {
    widget.daily = false;
    widget.monthly = false;
    widget.yearly = false;
    widget.pickedDate = new DateTime.now();
    widget.dailyDate = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Daily_Monthly_Yearly = Positioned(
      top: widget.mediaQueryData.size.height * 0.25,
      right: widget.mediaQueryData.size.width * 0.015,
      child: Container(
        width: widget.mediaQueryData.size.width * 0.97,
        height: widget.mediaQueryData.size.height * 0.19,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin:
              EdgeInsets.only(left: widget.mediaQueryData.size.width * 0.001),
          child: Row(
            children: [
              ButtonToChoiceFillter(
                mediaQueryData: widget.mediaQueryData,
                color: Colors.green.withOpacity(0.5),
                hintText: 'daily',
                onPressed: () => setState(
                  () {
                    widget.daily = true;
                  },
                ),
              ),
              SizedBox(width: widget.mediaQueryData.size.width * 0.001),
              ButtonToChoiceFillter(
                mediaQueryData: widget.mediaQueryData,
                color: Color(0xff2ac3ff),
                hintText: 'monthly',
                onPressed: () => setState(
                  () {
                    widget.daily = true;
                  },
                ),
              ),
              SizedBox(width: widget.mediaQueryData.size.width * 0.0001),
              ButtonToChoiceFillter(
                mediaQueryData: widget.mediaQueryData,
                color: Color(0xffff6968),
                hintText: 'yearly',
                onPressed: () => setState(
                  () {
                    widget.daily = true;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    var backGroundBoard = Column(
      children: [
        Container(
          child: Center(
            child: Text(
              'Finical Reports Day',
              style:
                  TextStyle(fontSize: widget.mediaQueryData.size.width * 0.06),
            ),
          ),
          height: widget.mediaQueryData.size.height * 0.35,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.5),
                Colors.blue.withOpacity(0.5),
              ],
            ),
          ),
        ),
      ],
    );

    ///here this varaible is finincal day
    var finincalDaily = Positioned(
      top: widget.mediaQueryData.size.height * 0.25,
      right: widget.mediaQueryData.size.width * 0.015,
      child: Container(
        width: widget.mediaQueryData.size.width * 0.97,
        height: widget.mediaQueryData.size.height * 0.19,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          child: widget.checkPresentTime
              ? Row(
                  children: [
                    Checkbox(
                        value: widget.checkPresentTime,
                        onChanged: (value) {
                          setState(() {
                            widget.checkPresentTime = value;
                          });
                        }),
                    Text('present Date')
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: widget.checkPresentTime,
                            onChanged: (value) {
                              setState(() {
                                widget.checkPresentTime = value;
                              });
                            }),
                        Text('present Date')
                      ],
                    ),
                    choiceDate(),
                  ],
                ),
        ),
      ),
    );

    ///here this varaible is finincal day
    var finincalMonthly = Positioned(
      top: widget.mediaQueryData.size.height * 0.25,
      right: widget.mediaQueryData.size.width * 0.015,
      child: Container(
        width: widget.mediaQueryData.size.width * 0.97,
        height: widget.mediaQueryData.size.height * 0.19,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(),
      ),
    );

    ///Here is my scaffold
    return Scaffold(
      body: Stack(
        children: [
          backGroundBoard,
          widget.daily && !widget.monthly && !widget.yearly
              ? finincalDaily
              : !widget.daily && widget.monthly && !widget.yearly
                  ? Text('monthly')
                  : !widget.daily && !widget.monthly && widget.yearly
                      ? Text('yealy')
                      : Daily_Monthly_Yearly,
        ],
      ),
      bottomNavigationBar: BottomNavBar(mediaQueryData: widget.mediaQueryData),
    );
  }

  Expanded choiceDate() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: widget.mediaQueryData.size.height * 0.04,
          bottom: widget.mediaQueryData.size.height * 0.04,
          right: widget.mediaQueryData.size.height * 0.01,
          left: widget.mediaQueryData.size.height * 0.01,
        ),
        //     bottom: widget.mediaQueryData.size.height * 0.06),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  '${widget.pickedDate.year},${widget.pickedDate.month},${widget.pickedDate.day}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // launch(
                pickDate();
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  pickDate() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: widget.pickedDate,
    );
    if (widget.dailyDate != null && datetime != null) {
      setState(() {
        widget.pickedDate = datetime;
      });
    }
  }
}

class ButtonToChoiceFillter extends StatelessWidget {
  const ButtonToChoiceFillter({
    Key key,
    @required this.mediaQueryData,
    @required this.color,
    @required this.hintText,
    @required this.onPressed,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;
  final Color color;
  final String hintText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        width: mediaQueryData.size.height * 0.139,
        height: mediaQueryData.size.height * 0.15,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(.09),
                blurRadius: 8,
                spreadRadius: 5,
                offset: Offset(0, 10),
              )
            ]),
        child: Center(
          child: Text(hintText),
        ),
      ),
    );
  }
}
