import '../../Controller/Api/Search/SearchWithAbstractMedicen/SearchByBarcode.dart';
import '../../Controller/Api/UploadToFirebase/addedNewQuantities.dart';
import '../../Controller/assistentController/ScanCodeByCamera.dart';


import '../../models/employee.dart';




import '../../counter.dart';
import '../../models/Product.dart';
import '../../models/quantity.dart';
import '../../views/MainHome/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EnteringMedicen extends StatefulWidget {
  List<Quantity> productsList;
  EnteringMedicen({Key key, this.productsList, this.employee})
      : super(key: key);
  Employee employee;
  String barcode = '';
  @override
  _EnteringMedicenState createState() => _EnteringMedicenState();
}

class _EnteringMedicenState extends State<EnteringMedicen>
    with SingleTickerProviderStateMixin {
  List<DataRow> widetDataRow = [];
  var mapProduct = {};
  Counter controllerFileds;
  int currentCounter = 0;

  String nameProduct = '';
  int rerere = 0;
  double costOfBill = 0;
  List<Product> products = [];
  DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    pickedDate = DateTime.now();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controllerFileds = Provider.of<Counter>(context);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – h:mm a').format(now);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: FittedBox(child: Text("إدخال فاتورة شراء")),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (controllerFileds.counterAddingMedicens == 0) {
                  controllerFileds
                      .addElementToList(controllerFileds.counterAddingMedicens);

                  this.widetDataRow.add(dataRowWidget(formattedDate));
                  currentCounter = controllerFileds.counterAddingMedicens;
                  controllerFileds.increaseCounterAddingMed();
                  print(currentCounter);
                } else {
                  Quantity quantity = new Quantity(
                    barCode: controllerFileds.barCodeProducts[
                        controllerFileds.counterAddingMedicens - 1],
                    nameProduct: controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[0]]
                        .text,
                    idProduct: controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[4]]
                        .text,
                    buyPrice: double.parse(controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[2]]
                        .text),
                    salePrice: double.parse(controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[3]]
                        .text),
                    quantity: int.parse(controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[1]]
                        .text),
                    dataExpire: formattedDate,
                    endDate:
                        DateFormat('yyyy-MM-dd – h:mm a').format(pickedDate),
                    minOfQuantity: int.parse(controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[7]]
                        .text),
                    whereIsIt: controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[5]]
                        .text,
                  );
                  rerere++;
                  costOfBill += quantity.buyPrice * quantity.quantity;
                  mapProduct[quantity.barCode] = quantity.toJson();
                  widget.productsList.add(quantity);
                  controllerFileds
                      .addElementToList(controllerFileds.counterAddingMedicens);

                  this.widetDataRow.add(dataRowWidget(formattedDate));
                  controllerFileds.increaseCounterAddingMed();
                  pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
                }
              });
            },
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.add,
                color: Colors.blueGrey,
              ),
            ),
          ),
          //bar code buttton
          IconButton(
            onPressed: () async {
              if (controllerFileds.counterAddingMedicens != 0) {
                String barcode = await ScanCodeByCamera().scanBarcodeNormal();

                if (!mounted) return;
                setState(() {
                  widget.barcode = barcode;
                  controllerFileds.barCodeProducts.add(widget.barcode);
                });
                List nameProductAfterSearch =
                    await SearchByBarcode().getUserSugesstions(widget.barcode);
                if (nameProductAfterSearch != null) {
                  String nameProduct = nameProductAfterSearch[0].name;
                  String idProduct = nameProductAfterSearch[0].id;
                  setState(() {
                    controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[0]]
                        .text = nameProduct;
                    controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[4]]
                        .text = idProduct;
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                                'الدواء غير موجود في الداتا بيز ، عند ضغطك على زر موافق سنقوم بمسح الباركود الخاص بالدواء'),
                            actions: [
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("yes")),
                            ],
                          ));
                }
              } else {
                String barcode =
                    await ScanCodeByCamera().scanBarcodeNormal();
                if (!mounted) return;
                setState(() {
                  widget.barcode = barcode;
                });
              }
            },
            icon: Icon(Icons.qr_code),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Form(
            key: formKey,
            child: DataTable(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blueGrey.withOpacity(0.4),
                Colors.blueGrey.withOpacity(0.9),
              ])),
              sortAscending: true,
              columns: [
                DataColumn(label: Container(child: Text("اسم الدواء"))),
                DataColumn(label: Text("الكمية")),
                DataColumn(label: Text("سعر الشراء")),
                DataColumn(label: Text("سعر المبيع")),
                DataColumn(label: Text("مكان التوضع في الصيدلية")),
                DataColumn(label: Text("تاريخ انتهاء الصلاحية")),
                DataColumn(label: Text("الحد الأدنى اللازم توافره")),
                DataColumn(label: Text("التاريخ")),
              ],
              rows: (controllerFileds.counterAddingMedicens >= 0)
                  ? this.widetDataRow.toList()
                  : [],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          if (formKey.currentState.validate()) {
            Quantity quantity = new Quantity(
              barCode: controllerFileds
                  .barCodeProducts[controllerFileds.counterAddingMedicens - 1],
              nameProduct: controllerFileds
                  .textEditingController[
                      controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[0]]
                  .text,
              idProduct: controllerFileds
                  .textEditingController[
                      controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[4]]
                  .text,
              buyPrice: checkIfNull(controllerFileds.textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[2]])
                  ? double.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[2]]
                      .text)
                  : 0,
              salePrice: checkIfNull(controllerFileds.textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[3]])
                  ? double.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[3]]
                      .text)
                  : 0,
              quantity: checkIfNull(controllerFileds.textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[1]])
                  ? int.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[1]]
                      .text)
                  : 0,
              dataExpire: formattedDate,
              endDate: DateFormat('yyyy-MM-dd – h:mm a').format(pickedDate),
              minOfQuantity: checkIfNull(controllerFileds.textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[2]])
                  ? int.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[2]]
                      .text)
                  : 0,
              whereIsIt: controllerFileds
                  .textEditingController[
                      controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[5]]
                  .text,
            );
            mapProduct[quantity.barCode] = quantity.toJson();
            widget.productsList.add(quantity);
            controllerFileds
                .addElementToList(controllerFileds.counterAddingMedicens);
            costOfBill += quantity.buyPrice * quantity.quantity;
            AddedQuantity().addNewQuantities(widget.productsList, context);

            var map = {};
            widget.productsList.forEach((element) {
              map[element.barCode] = element.toJson();
            });
            AddedQuantity().addToCostBill(mapProduct, costOfBill);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'تمت تسجيل الأدوية بنجاح',
                  style: TextStyle(fontSize: 10),
                  textDirection: ui.TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen(
                                    employee: widget.employee,
                                  )));
                    },
                    child: Text("انتقل للصفحة الرئيسية"),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  bool checkIfNull(object) {
    bool check;
    object == null ? check = false : check = true;
    return check;
  }

  Column choiceDate() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: Text(
              '${pickedDate.year},${pickedDate.month},${pickedDate.day}',
              style: TextStyle(fontSize: 10),
            ),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () {
              // launch(
              pickDate();
              // );
            },
          ),
        ),
      ],
    );
  }

  pickDate() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 75),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: DateTime(2020),
    );
    if (controllerFileds.textEditingController[
                    controllerFileds.counterAddingMedicens - 1]
                [controllerFileds.temp[5]] !=
            null &&
        datetime != null) {
      setState(() {
        pickedDate = datetime;
        print('thia is pickdate ' + pickedDate.toIso8601String());
      });
    }
  }

  //To create Data Row For Data Table , formatted Data parameter for Date now but make formate for it

  DataRow dataRowWidget(String formattedDate) {
    return DataRow(
      cells: [
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[0]],
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "اسم الدواء",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            validator: (value) => value.isEmpty ? 'عبي الحقل' : null,
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[1]],
            autocorrect: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "عدد القطع",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[2]],
            autocorrect: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "سعر الشراء",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[3]],
            keyboardType: TextInputType.number,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "سعر المبيع",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[5]],
            keyboardType: TextInputType.text,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "مكان التوضع في الصيدلية",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          choiceDate(),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[7]],
            keyboardType: TextInputType.number,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "الحد الأدنى",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          Text(formattedDate),
        ),
      ],
    );
  }
}
