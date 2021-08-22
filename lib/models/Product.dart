import '../models/quantity.dart';

class Product extends Object {
  String id;
  String name;
  String barcode;
  String theraputicCategoires;
  String manufactureCompany;
  String indications;
  List notUses;
  String warnings;
  String sideReactions;
  bool ifCanUseWithoutPrescription;
  String precautions;
  String from;
  int packing;
  int indexing;
  List composition;
  int basicQuantity;
  String urlImage;

  Quantity quantity;
  Product.product();

  Product({
    this.id,
    this.name,
    this.barcode,
    this.theraputicCategoires,
    this.composition,
    this.packing,
    this.from,
    this.manufactureCompany,
    this.quantity,
    this.indexing,
    this.indications,
    this.ifCanUseWithoutPrescription,
    this.notUses,
    this.sideReactions,
    this.warnings,
    this.precautions,
    this.urlImage,
  });
  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'barCode': this.barcode,
        'theraputicCategoires': this.theraputicCategoires,
        'composition': this.composition,
        'packing': this.packing,
        'from': this.from,
        'manufacture_company': this.manufactureCompany,
        'quentity': this.quantity.toJson(),
        'indexing': this.indexing,
        'indications': this.indications,
        'ifCanUseWithoutPrescription': this.ifCanUseWithoutPrescription,
        'notUses': this.notUses,
        'sideReactions': this.sideReactions,
        'warnings': this.warnings,
        'precautions': this.precautions,
        'urlImage':this.urlImage,
      };
}
