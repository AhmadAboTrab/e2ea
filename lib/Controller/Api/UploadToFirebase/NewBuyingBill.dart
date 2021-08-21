import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Product.dart';
import '../../../models/bill.dart';

import '../../../models/quantity.dart';

class NewBuyingBill {
  Future<Quantity> getQuantity(Product product) async {
    Quantity quantity = new Quantity();
    return await FirebaseFirestore.instance
        .collection("quantity")
        .where("Barcode", isEqualTo: product.barcode)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) async {
          quantity = new Quantity();
          quantity.idQuantity = element.data()['quantity_id'];
          quantity.idProduct = element.data()['medicin_id'];
          quantity.barCode = element.data()['Barcode'];
          quantity.buyPrice = element.data()['buyPrice'];
          quantity.salePrice = element.data()['salePrice'];
          quantity.quantity = element.data()['quantity'];
          quantity.nameProduct = element.data()['medicin_name'];
          quantity.dataExpire = element.data()['dateExpire'];
        });
      }
      return quantity;
    });
  }

  Future<List<Quantity>> getQuantities(List<Product> products) async {
    List<Quantity> result = [];
    for (Product product in products) {
      result.add(await getQuantity(product));
    }
    return result;
  }

  Future<void> addBill(Bill bill) async {
    List<Quantity> myResult =
        await getQuantities(bill.products.values.toList());



    for (int i = 0; i < bill.products.length; i++) {
      await FirebaseFirestore.instance
          .collection('quantity')
          .doc(
              bill.products[bill.products.keys.toList()[i]].quantity.idQuantity)
          .update({
        'quantity':
            bill.products[bill.products.keys.toList()[i]].quantity.quantity,
      });
    }

    Map<String, Product> map = new Map.from(bill.products);
    int i = 0;
    for (Product product in map.values.toList()) {
      product.quantity.quantity =
          myResult[i].quantity - product.quantity.quantity;
      i++;
    }

    var finalMap = {};
    for (Product product in map.values.toList()) {
      finalMap[product.barcode] = product.toJson();
    }
    DocumentReference ref = await FirebaseFirestore.instance.collection('Bill').doc();
    await ref.set({
      'Bill_id': ref.id,
      'totalCost': bill.totalCost,
      'idEmployee': bill.idEmployee,
      'idCustomer': bill.idCustomer,
      'prooducts': finalMap,
    });
    finalMap.clear();
    map.clear();
    bill.products.clear();
  }
}

    // // for (int i = 0; i < bill.products.length; i++) {
    // //   FirebaseFirestore.instance
    // //       .collection('quantity')
    // //       .doc(
    // //           bill.products[bill.products.keys.toList()[i]].quantity.idQuantity)
    // //       .update({
    // //     'quantity':
    // //         bill.products[bill.products.keys.toList()[i]].quantity.quantity,
    // //   });
    // // }
    // bool check;
    // do {
    //   check = quantity.remove(0);
    // } while (check);
    // var products = {};
    // for (int i = 0; i < min(bill.products.length, quantity.length); i++) {
    //   bill.products[bill.products.keys.toList()[i]].quantity.quantity =
    //       quantity[i];
    //   products[bill.products.keys.toList()[i]] =
    //       bill.products[bill.products.keys.toList()[i]].toJson();
    // }