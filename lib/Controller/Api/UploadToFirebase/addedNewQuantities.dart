import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/quantity.dart';




import 'package:flutter/material.dart';



class AddedQuantity {
  void addNewQuantities(List<Quantity> products, BuildContext context) async {
    for (Quantity product in products) {

      DocumentReference ref =
           FirebaseFirestore.instance.collection('quantity').doc();
      ref.set({
     
        'medicin_id': product.idProduct,
        'quantity_id': ref.id,
        'medicin_name': product.nameProduct,
        'Barcode': product.barCode,
        'buyPrice': product.buyPrice,
        'salePrice': product.salePrice,
        'dateExpire': product.dataExpire,
        'whereIsIt': product.whereIsIt,
        'minOfQuantity': product.minOfQuantity,
        'endDate': product.endDate,
        'quantity': product.quantity,
      });
    }
  }
  addToOrderBill(var map ,double costOfBill)async{
         DocumentReference ref =
           FirebaseFirestore.instance.collection('OrderBill').doc();
      ref.set({
        'id' : ref.id,
        'quan':map
      });
  }
}
