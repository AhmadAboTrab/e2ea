import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/Product.dart';

class AddNewProductOrUpdate {
  uploadNewProduct(Product product) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('medicins').doc();
    ref.set({
      'Barcode': product.barcode,
      'medicin_id': ref.id,
      'medicin_name': product.name,
      'Theraputic Categories': product.theraputicCategoires,
      'From': product.from,
      'Packing': product.packing,
      // 'ChemicalComposition': textEditingControllerList[5].text,
      'Indications': product.indications,
      'NotUses': product.notUses,
      'Precautions': product.precautions,
      'Warnings': product.warnings,
      'SideRecations': product.sideReactions,
      'ManufactureCompany': product.manufactureCompany,
      //'chemical composition': textEditingControllerList[6].text,
      'Composition': product.composition,
    });
  }

  updateInformation(Product product) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('medicins').doc(product.id);
    ref.set({
      'Barcode': product.barcode,
      'medicin_id': ref.id,
      'medicin_name': product.name,
      'Theraputic Categories': product.theraputicCategoires,
      'From': product.from,
      'Packing': product.packing,
      // 'ChemicalComposition': textEditingControllerList[5].text,
      'Indications': product.indications,
      'NotUses': product.notUses,
      'Precautions': product.precautions,
      'Warnings': product.warnings,
      'SideRecations': product.sideReactions,
      'ManufactureCompany': product.manufactureCompany,
      //'chemical composition': textEditingControllerList[6].text,
      'Composition': product.composition,
    });
  }
}
