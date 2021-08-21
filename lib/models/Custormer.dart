import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String id;
  String name;

  DateTime date;
  String insurance;
  List notes;

  uploadata(Customer customer) async {
    List indexlist = new List();
    List indexkey = new List();
    DocumentReference ref =
         FirebaseFirestore.instance.collection('customer').doc();
    for (int i = 1; i < customer.name.length + 1; i++) {
      indexlist.add(customer.name.substring(0, i).toLowerCase());
    }
    for (int i = 1; i < customer.insurance.length + 1; i++) {
      indexkey.add(customer.insurance.substring(0, i).toLowerCase());
    }
    ref.set({
      'index_name': indexlist,
      'index_man': indexkey,
      'customer_id': ref.id,
      'customer_name': customer.name,
      'insurance_company': customer.insurance
    });
  }

  Customer({this.id, this.name, this.date, this.notes});
}
