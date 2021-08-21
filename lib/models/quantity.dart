class Quantity {
  String idQuantity;
  String idProduct;
  String barCode;
  String nameProduct;
  double salePrice;
  double buyPrice;
  String dataExpire;
  int quantity;
  String whereIsIt;
  String endDate;
  int minOfQuantity;

  Quantity({
    this.barCode,
    this.idProduct,
    this.nameProduct,
    this.buyPrice,
    this.dataExpire,
    this.salePrice,
    this.quantity,
    this.idQuantity,
    this.whereIsIt,
    this.endDate,
    this.minOfQuantity,
  });
  printQ() {
    print('barcode is. : ' + barCode + '\n');
    print('name is. : ' + nameProduct + '\n');
    print('date ex is. : ' + dataExpire + '\n');
    print('buy  is. : ' + buyPrice.toString() + '\n');
    print('sale  is. : ' + salePrice.toString() + '\n');
    print('quantity  is. : ' + quantity.toString() + '\n');
  }

  Map<String, dynamic> toJson() => {
        'id': this.idQuantity,
        'idProduct': this.idProduct,
        'nameProduct': this.nameProduct,
        'buyPrice': this.buyPrice,
        'dataExpire': this.dataExpire,
        'salePrice': this.salePrice,
        'quantity': this.quantity,
        'barcode': this.barCode,
        'whereIsIt': this.whereIsIt,
        'endDate': this.endDate,
        'minOfQuantity': this.minOfQuantity
      };
  factory Quantity.fromJson(dynamic json) {
    return Quantity(
      barCode: json['barcode'] as String,
      idProduct: json['idProduct'] as String,
      nameProduct: json['nameProduct'] as String,
      buyPrice: json['buyPrice'] as double,
      dataExpire: json['dataExpire'] as String,
      salePrice: json['salePrice'] as double,
      quantity: json['quantity'] as int,
      idQuantity: json['barcode'] as String,
      whereIsIt: json['whereIsIt'] as String,
      endDate: json['endDate'] as String,
      minOfQuantity: json['minOfQuantity'] as int,
    );
  }
}
