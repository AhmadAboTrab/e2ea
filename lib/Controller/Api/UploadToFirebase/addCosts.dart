import 'package:cloud_firestore/cloud_firestore.dart';



class AddCosts {
  List result = [];
  List indexKeyTemp = [];
  List indexKey = [];
  addCostBill(List costsBill, String date) async {
     DocumentReference ref =
        FirebaseFirestore.instance.collection('CostBill').doc();
    await ref.set({
      'costBill_id': ref.id,
      'Date': date,
      'Costs': costsBill,
    });
  }
}
