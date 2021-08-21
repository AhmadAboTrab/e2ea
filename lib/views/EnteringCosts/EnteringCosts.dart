import '../../models/employee.dart';
import '../../views/MainHome/MainScreen.dart';

import '../../Controller/Api/UploadToFirebase/addCosts.dart';

import '../../counter.dart';
import '../../models/costBill.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EnteringCosts extends StatefulWidget {
  EnteringCosts({Key key, this.employee}) : super(key: key);
  String _valueDrop;
  List<String> listDropDowCosts = [
    "كهرباء",
    "مياه",
    "ضرائب",
    "رواتب موظفين",
    "نفقات "
  ];
  Employee employee;
  String s;
  Counter dropDownValue;

  List<DataRow> dataRowList = [];
  double cost = 0;
  List<List<TextEditingController>> listTextEditingController = [];
  int counter = 0;
  List listCostBill = [];

  @override
  _EnteringCostsState createState() => _EnteringCostsState();
}

class _EnteringCostsState extends State<EnteringCosts> {
  String formattedDate =
      DateFormat('yyyy-MM-dd – h:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    widget.dropDownValue = Provider.of<Counter>(context);
    DataRow dataRowWidget(String formattedDate) {
      return DataRow(
        cells: [
          DataCell(
            DropdownButton<String>(
              value: widget.s,
              onChanged: (String value) {
                setState(() {
                  widget.s = value;
                });
              },
              focusColor: Colors.grey,
              icon: Icon(Icons.arrow_downward),
              items: widget.listDropDowCosts.map((ele) {
                print('in dont kniow : ' + ele.toString());
                return DropdownMenuItem(
                  value: ele,
                  child: Text(ele),
                );
              }).toList(),
              hint: Text('نوع التكلفة'),
            ),
          ),
          DataCell(
            TextFormField(
              controller: widget.listTextEditingController[widget.counter][0],
              validator: (value) {
                if (value.isEmpty) {
                  return 'should insert quantity';
                }
                return null;
              },
              autocorrect: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "قيمة التكلفة",
                hintTextDirection: ui.TextDirection.rtl,
              ),
            ),
          ),
          DataCell(
            TextFormField(
              controller: widget.listTextEditingController[widget.counter][1],
              textDirection: ui.TextDirection.rtl,
              keyboardType: TextInputType.text,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: "ملاحظات",
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: FittedBox(
          child: Text('إدخال التكاليف'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.listTextEditingController.add(
                      new List<TextEditingController>.generate(
                          2, (index) => new TextEditingController()));
                  this.widget.dataRowList.add(dataRowWidget(formattedDate));

                  if (widget.counter != 0) {
                    CostBill costBill = new CostBill(
                        typeOfCost: widget._valueDrop,
                        cost: double.parse(widget
                            .listTextEditingController[widget.counter - 1][0]
                            .text),
                        notes: widget
                            .listTextEditingController[widget.counter - 1][1]
                            .text,
                        formattedDate: formattedDate);
                    widget.cost += double.parse(widget
                        .listTextEditingController[widget.counter - 1][0].text);
                    widget.listCostBill.add(costBill.toJson());
                  }
                  widget.counter++;
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text(
              'نوع التكلفة',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'قيمة التكلفة',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'ملاحظات',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              'تاريخ الإنفاق',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
          ],
          rows: this.widget.dataRowList == null ? [] : this.widget.dataRowList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CostBill costBill = new CostBill(
              typeOfCost: widget._valueDrop,
              cost: double.parse(
                  widget.listTextEditingController[widget.counter - 1][0].text),
              notes:
                  widget.listTextEditingController[widget.counter - 1][1].text,
              formattedDate: formattedDate);
          widget.cost += double.parse(
              widget.listTextEditingController[widget.counter - 1][0].text);
          widget.listCostBill.add(costBill.toJson());

          AddCosts().addCostBill(widget.listCostBill, formattedDate);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("العودة للصفحة الرئيسية"),
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
                        child: Text('go back'),
                      )
                    ],
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
