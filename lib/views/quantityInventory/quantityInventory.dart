// import 'package:e2ea/Controller/reports.dart';
// import 'package:e2ea/Widgets/BottomNavTab.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class QuantityIneventory extends StatefulWidget {
//   QuantityIneventory({Key key, this.mediaQueryData}) : super(key: key);

//   final MediaQueryData mediaQueryData;

//   bool daily = false, monthly = false, yearly = false;

//   bool checkPresentTime = true;
//   DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
//   TextEditingController dailyDate;

//   DateTime firstDateMonthly = new DateTime(0, 0, 0, 0, 0, 0),
//       secondDateMonthly = new DateTime(0, 0, 0, 0, 0, 0);
//   String whatController;

//   List resultFinincalSearch = [];
//   static double top = 0.19;
//   static double right = 0.015;
//   static double width = 0.97;
//   static double height = 0.24;

//   @override
//   _QuantityIneventoryState createState() => _QuantityIneventoryState();
// }

// class _QuantityIneventoryState extends State<QuantityIneventory> {
//   @override
//   void initState() {
//     widget.daily = false;
//     widget.monthly = false;
//     widget.yearly = false;
//     widget.pickedDate = new DateTime.now();
//     widget.dailyDate = new TextEditingController();
//     widget.firstDateMonthly = new DateTime.now();
//     widget.secondDateMonthly = new DateTime.now();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var Daily_Monthly_Yearly = Positioned(
//       top: widget.mediaQueryData.size.height * 0.19,
//       right: widget.mediaQueryData.size.width * 0.015,
//       child: Container(
//         width: widget.mediaQueryData.size.width * 0.97,
//         height: widget.mediaQueryData.size.height * 0.24,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.09),
//               blurRadius: 8,
//               spreadRadius: 3,
//               offset: Offset(0, 10),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Container(
//           margin:
//               EdgeInsets.only(left: widget.mediaQueryData.size.width * 0.001),
//           child: Row(
//             children: [
//               Expanded(
//                 child: ButtonToChoiceFillter(
//                   mediaQueryData: widget.mediaQueryData,
//                   color: Colors.green.withOpacity(0.5),
//                   hintText: 'daily',
//                   onPressed: () => setState(
//                     () {
//                       widget.daily = true;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: widget.mediaQueryData.size.width * 0.001),
//               Expanded(
//                 child: ButtonToChoiceFillter(
//                   mediaQueryData: widget.mediaQueryData,
//                   color: Color(0xff2ac3ff),
//                   hintText: 'monthly',
//                   onPressed: () => setState(
//                     () {
//                       widget.monthly = true;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: widget.mediaQueryData.size.width * 0.0001),
//               Expanded(
//                 child: ButtonToChoiceFillter(
//                   mediaQueryData: widget.mediaQueryData,
//                   color: Color(0xffff6968),
//                   hintText: 'yearly',
//                   onPressed: () => setState(
//                     () {
//                       widget.yearly = true;
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     var backGroundBoard = Column(
//       children: [
//         Container(
//           child: Center(
//             child: MaterialButton(
//               onPressed: () => setState(() {
//                 widget.daily = false;
//                 widget.monthly = false;
//                 widget.yearly = false;
//               }),
//               child: Text(
//                 'Quantity Ineventory',
//                 style: TextStyle(
//                     fontSize: widget.mediaQueryData.size.width * 0.06),
//               ),
//             ),
//           ),
//           height: widget.mediaQueryData.size.height * 0.25,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(8),
//               bottomRight: Radius.circular(8),
//             ),
//             gradient: LinearGradient(
//               colors: [
//                 Colors.blue.withOpacity(0.5),
//                 Colors.blue.withOpacity(0.5),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );

//     ///here this varaible is finincal day
//     var finincalDaily = Positioned(
//       top: widget.mediaQueryData.size.height * 0.19,
//       right: widget.mediaQueryData.size.width * 0.015,
//       child: Container(
//         width: widget.mediaQueryData.size.width * 0.97,
//         height: widget.mediaQueryData.size.height * 0.24,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.09),
//               blurRadius: 8,
//               spreadRadius: 3,
//               offset: Offset(0, 10),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Container(
//           child: widget.checkPresentTime
//               ? Row(
//                   children: [
//                     Row(
//                       children: [
//                         Checkbox(
//                             value: widget.checkPresentTime,
//                             onChanged: (value) {
//                               setState(() {
//                                 widget.checkPresentTime = value;
//                               });
//                             }),
//                         Text('present Date')
//                       ],
//                     ),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black)),
//                         child: MaterialButton(
//                           onPressed: () async {
//                             widget.resultFinincalSearch = await Reports()
//                                 .makeDayReport(
//                                     widget.pickedDate.day,
//                                     widget.pickedDate.month,
//                                     widget.pickedDate.year);
//                           },
//                           child: Text('Get'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               : Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(
//                                 value: widget.checkPresentTime,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     widget.checkPresentTime = value;
//                                   });
//                                 }),
//                             Text('present Date')
//                           ],
//                         ),
//                         choiceDate(),
//                       ],
//                     ),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.black)),
//                         child: MaterialButton(
//                           onPressed: () async {
//                             widget.resultFinincalSearch = await Reports()
//                                 .makeDayReport(
//                                     widget.pickedDate.day,
//                                     widget.pickedDate.month,
//                                     widget.pickedDate.year);
//                           },
//                           child: Text('Get'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );

//     ///here this varaible is finincal month
//     var finincalMonthly = Positioned(
//       top: widget.mediaQueryData.size.height * 0.19,
//       right: widget.mediaQueryData.size.width * 0.015,
//       child: Container(
//         width: widget.mediaQueryData.size.width * 0.97,
//         height: widget.mediaQueryData.size.height * 0.24,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.09),
//               blurRadius: 8,
//               spreadRadius: 3,
//               offset: Offset(0, 10),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Container(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   choiceDateFirst(),
//                   choiceDateSecond(),
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.black)),
//                   child: MaterialButton(
//                     onPressed: () async {
//                       widget.resultFinincalSearch = await Reports()
//                           .makeMonthReport(widget.firstDateMonthly.month,
//                               widget.firstDateMonthly.year);
//                     },
//                     child: Text('Get'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     ///here this varaible is finincal year
//     var finincalYearly = Positioned(
//       top: widget.mediaQueryData.size.height * 0.19,
//       right: widget.mediaQueryData.size.width * 0.015,
//       child: Container(
//         width: widget.mediaQueryData.size.width * 0.97,
//         height: widget.mediaQueryData.size.height * 0.24,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.09),
//               blurRadius: 8,
//               spreadRadius: 3,
//               offset: Offset(0, 10),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Container(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   choiceDateFirst(),
//                   choiceDateSecond(),
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.black)),
//                   child: MaterialButton(
//                     onPressed: () async {
//                       // widget.resultFinincalSearch = await Reports()
//                       //     .makeYearReport(widget.firstDateMonthly.year);
//                     },
//                     child: Text('Get'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     ///
//     ///
//     var table = Positioned(
//         top: widget.mediaQueryData.size.height * 0.55,
//         left: widget.mediaQueryData.size.width * 0.55,
//         child: Container(
//           height: 50,
//           width: 60,
//           decoration: BoxDecoration(color: Colors.black),
//         ));

//     ///Here is my scaffold

//     return Scaffold(
//       body: Stack(
//         children: [
//           backGroundBoard,
//           table,
//           widget.daily && !widget.monthly && !widget.yearly
//               ? finincalDaily
//               : !widget.daily && widget.monthly && !widget.yearly
//                   ? finincalMonthly
//                   : !widget.daily && !widget.monthly && widget.yearly
//                       ? finincalYearly
//                       : Daily_Monthly_Yearly,
//         ],
//       ),
//     );
//   }

//   ///_________________________________________________________
//   ///normal case chose one date
//   Expanded choiceDate() {
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.only(
//           top: widget.mediaQueryData.size.height * 0.04,
//           bottom: widget.mediaQueryData.size.height * 0.05,
//           right: widget.mediaQueryData.size.height * 0.01,
//           left: widget.mediaQueryData.size.height * 0.01,
//         ),
//         //     bottom: widget.mediaQueryData.size.height * 0.06),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           children: <Widget>[
//             ListTile(
//               title: FittedBox(
//                 child: Text(
//                   '${widget.pickedDate.year},${widget.pickedDate.month},${widget.pickedDate.day}',
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ),
//               trailing: Icon(Icons.keyboard_arrow_down),
//               onTap: () {
//                 pickDate();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   pickDate() async {
//     DateTime datetime = await showDatePicker(
//         context: context,
//         firstDate: DateTime(DateTime.now().year - 70),
//         lastDate: DateTime(DateTime.now().year + 75),
//         initialDate: widget.pickedDate);

//     setState(() {
//       widget.pickedDate = datetime;
//     });
//   }

//   //___________________________________________________________________________
// //for first date
//   Expanded choiceDateFirst() {
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.only(
//           top: widget.mediaQueryData.size.height * 0.04,
//           bottom: widget.mediaQueryData.size.height * 0.05,
//           right: widget.mediaQueryData.size.height * 0.01,
//           left: widget.mediaQueryData.size.height * 0.01,
//         ),
//         //     bottom: widget.mediaQueryData.size.height * 0.06),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           children: <Widget>[
//             ListTile(
//               title: FittedBox(
//                 child: Text(
//                   '${widget.firstDateMonthly.year},${widget.firstDateMonthly.month},${widget.firstDateMonthly.day}',
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ),
//               trailing: Icon(Icons.keyboard_arrow_down),
//               onTap: () {
//                 // launch(
//                 pickDateFirst();

//                 // );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   pickDateFirst() async {
//     DateTime datetime = await showDatePicker(
//         context: context,
//         firstDate: DateTime(DateTime.now().year - 70),
//         lastDate: DateTime(DateTime.now().year + 75),
//         initialDate: widget.firstDateMonthly);

//     setState(() {
//       widget.firstDateMonthly = datetime;
//     });
//   }

//   //___________________________________________________________________________
//   ///For scond date
//   Expanded choiceDateSecond() {
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.only(
//           top: widget.mediaQueryData.size.height * 0.04,
//           bottom: widget.mediaQueryData.size.height * 0.05,
//           right: widget.mediaQueryData.size.height * 0.01,
//           left: widget.mediaQueryData.size.height * 0.01,
//         ),
//         //     bottom: widget.mediaQueryData.size.height * 0.06),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           children: <Widget>[
//             ListTile(
//               title: FittedBox(
//                 child: Text(
//                   '${widget.secondDateMonthly.year},${widget.secondDateMonthly.month},${widget.secondDateMonthly.day}',
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ),
//               trailing: Icon(Icons.keyboard_arrow_down),
//               onTap: () {
//                 // launch(
//                 pickDateSecond();

//                 // );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   pickDateSecond() async {
//     DateTime datetime = await showDatePicker(
//         context: context,
//         firstDate: DateTime(DateTime.now().year - 70),
//         lastDate: DateTime(DateTime.now().year + 75),
//         initialDate: widget.secondDateMonthly);

//     setState(() {
//       widget.secondDateMonthly = datetime;
//     });
//   }
//   //_________________________________________________________________
// }

// class ButtonToChoiceFillter extends StatelessWidget {
//   const ButtonToChoiceFillter({
//     Key key,
//     @required this.mediaQueryData,
//     @required this.color,
//     @required this.hintText,
//     @required this.onPressed,
//   }) : super(key: key);

//   final MediaQueryData mediaQueryData;
//   final Color color;
//   final String hintText;
//   final Function onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: onPressed,
//       child: Container(
//         width: mediaQueryData.size.height * 0.139,
//         height: mediaQueryData.size.height * 0.15,
//         decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(.09),
//                 blurRadius: 8,
//                 spreadRadius: 5,
//                 offset: Offset(0, 10),
//               )
//             ]),
//         child: Center(
//           child: Text(hintText),
//         ),
//       ),
//     );
//   }
// }
