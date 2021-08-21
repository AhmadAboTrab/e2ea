import 'package:flutter/cupertino.dart';

class Purchases {
  final String purchaseName;
  final double amount;
  DateTime date;
  double price;
  Purchases({
   @required this.amount,
   @required this.purchaseName,
   @required this.price,
   @required this.date});
}