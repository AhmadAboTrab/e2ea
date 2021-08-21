import '../models/quantity.dart';

class ObjectCostBill {
  String barcode;
  Quantity quantity;

  ObjectCostBill({this.barcode, this.quantity});

  Map<String, dynamic> toJson() => {
        'barcode': barcode,
        'quantity': quantity.toJson(),
      };
}
