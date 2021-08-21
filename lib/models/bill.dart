import '../models/Product.dart';

class Bill extends Object {
  String idBill;

  String idEmployee;
  String idCustomer;
  String typeBill; //type of employee (عاجلة آو آجلة)
  String dateTimeBill;
  double totalCost;
  var products;

  Bill({
    this.idBill,
    this.idEmployee,
    this.idCustomer,
    this.totalCost,
    this.typeBill,
    this.dateTimeBill,
    this.products,
  });
}
