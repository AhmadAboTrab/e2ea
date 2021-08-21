import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Controller/Api/Search/SearchApi.dart';
import '../../../../models/Product.dart';



class AbstractSearch implements SearchApi {

  @override
  Future<List<Object>> getUserSugesstions(String query) async {

    
    List<Product> result = [];
    return await FirebaseFirestore.instance.collection('medicins').get()
        // ignore: missing_return
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          Product product = new Product.product();
          product.id = doc.data()['medicin_id'];
          product.name = doc.data()['medicin_name'];
          product.barcode = doc.data()['Barcode'];
          product.composition = doc.data()['Composition'];
          product.from = doc.data()['From'];
          product.manufactureCompany = doc.data()['ManufactureCompany'];
          product.packing = doc.data()['Packing'];
          product.theraputicCategoires = doc.data()['Theraputic Categories'];
          product.indexing = doc.data()['indexing'];
          product.indications = doc.data()['Indications'];
          product.notUses = doc.data()['NotUses'];
          product.precautions = doc.data()['Precautions'];
          product.sideReactions = doc.data()['SideRecations'];
          product.ifCanUseWithoutPrescription =
              doc.data()['ifCanUseWithoutPrescription'];
          product.sideReactions = doc.data()['Warnings'];
          result.add(product);
        });

        return result;
      }
    });
  }
}
