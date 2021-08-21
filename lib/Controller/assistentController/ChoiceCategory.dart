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

          //   productNew = new Product(
          //     id: product.id,
          //     name: product.name,
          //     barcode: product.barcode,
          //     theraputicCategoires: product.theraputicCategoires,
          //     composition: product.composition,
          //     packing: product.packing,
          //     from: product.from,
          //     manufactureCompany: product.manufactureCompany,
          //     quantity: quantity,
          //     indexing: product.indexing,
          //     indications: product.indications,
          //     ifCanUseWithoutPrescription: product.ifCanUseWithoutPrescription,
          //     notUses: product.notUses,
          //     sideReactions: product.sideReactions,
          //     warnings: product.warnings,
          //     precautions: product.precautions,
          //   );
        });
        print("in get all drugs. " + productNew.name);
        return productNew;
      }
    });
  }

  tester() async {
    // Map<String, Product> getALllDruges = await getAllDrugs();
    Map<String, Product> resultAfterSearchQuantity = {};
    List valuesPrpduct = await AbstractSearch().getUserSugesstions('query');
    print("i get all product form firebase ");
    for (Product product in valuesPrpduct) {
      print(product.name);
    }

    for (int i = 0; i < valuesPrpduct.length; i++) {
      print("here in " + i.toString() + "th values ");
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

    // List<Map<String, List<Product>>> classification = [];

    // List theraputicCategories = [];
    // for (int i = 0; i < rest.length; i++) {
    //   if (theraputicCategories.isEmpty) {
    //     theraputicCategories.add(rest[i].theraputicCategoires);
    //   } else {
    //     if (!theraputicCategories.contains(rest[i].theraputicCategoires)) {
    //       theraputicCategories.add(rest[i].theraputicCategoires);
    //     }
    //   }
    // }
    // for (String type in theraputicCategories) {
    //   Map<String, List<Product>> temp = {type: []};
    //   classification.add(temp);
    // }

    // for (Product value in rest) {
    //   // print('ghhgghjhjg');
    //   String tempForSearc = value.theraputicCategoires;
    //   for (int i = 0; i < classification.length; i++) {
    //     if (tempForSearc == classification[i].keys.toList()[0]) {
    //       classification[i][tempForSearc].add(value);
    //       break;
    //     }
    //   }
    // }

    // // print(classification[0]['مسكنات الآلم وخافضات الحرارة'].length);

    // // print('here in make mission : ' + classification.length.toString());
    // return classification;
  }

  getListResult() => this.result;
}
