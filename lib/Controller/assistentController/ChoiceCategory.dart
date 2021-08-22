import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Controller/Api/Search/SearchWithAbstractMedicen/AbstrachSearch.dart';

import '../../models/Product.dart';

import '../../models/quantity.dart';

class ChoiceCategory {
  Map<String, Product> result = {};
  List quantityResult = [];

  List quan = [];

  Future<Object> getAllDrugsQuantity(Product product) async {
    quantityResult.clear();
    Product productNew;
    // print('here get quantity' + product.id);
    return await FirebaseFirestore.instance
        .collection('quantity')
        .where('medicin_id', isEqualTo: product.id)
        .get()
        // ignore: missing_return
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) async {
          Quantity quantity = new Quantity();

          quantity.idQuantity = element.data()['quantity_id'];
          quantity.idProduct = element.data()['medicin_id'];
          quantity.barCode = element.data()['Barcode'];
          quantity.buyPrice = element.data()['buyPrice'];
          quantity.salePrice = element.data()['salePrice'];
          quantity.quantity = element.data()['quantity'];
          quantity.nameProduct = element.data()['medicin_name'];
          quantity.dataExpire = element.data()['dateExpire'];
          productNew = product;
          productNew.basicQuantity = quantity.quantity;
          productNew.quantity = quantity;
        });
        // print("in get all drugs. " + productNew.name);
        return productNew;
      }
    });
  }

  tester() async {
    
    Map<String, Product> resultAfterSearchQuantity = {};
    List valuesPrpduct = await AbstractSearch().getUserSugesstions('query');
    // print("i get all product form firebase ");
    for (Product product in valuesPrpduct) {
      print(product.name);
    }

    for (int i = 0; i < valuesPrpduct.length; i++) {
      // print("here in " + i.toString() + "th values ");
      Product object = new Product.product();
      object = await getAllDrugsQuantity(valuesPrpduct[i]);

      if (object != null) {
        resultAfterSearchQuantity[object.barcode] = object;
      } else {
        resultAfterSearchQuantity[valuesPrpduct[i].barcode] = valuesPrpduct[i];
      }
    }

    return resultAfterSearchQuantity;
  }

  makeMission(Map<String, Product> rest) {
    if (rest == null) {
      return null;
    }

    Map<String, List<Product>> classification =
        new Map<String, List<Product>>();

    for (int i = 0; i < rest.length; i++) {
      if (classification[rest.values.toList()[i].theraputicCategoires] ==
          null) {
        classification[rest.values.toList()[i].theraputicCategoires] =
            List<Product>.empty(growable: true);
      }
      classification[rest.values.toList()[i].theraputicCategoires]
          .add(rest.values.toList()[i]);
    }
    return classification;
  }
}
