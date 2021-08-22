import 'package:e2ea/views/MainHome/MainScreen.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../Controller/Api/Search/CustomerSearch/CustomerSearchByName.dart';
import '../../Controller/Api/UploadToFirebase/NewBuyingBill.dart';
import '../../Controller/assistentController/ScanCodeByCamera.dart';

import '../../Widgets/CategoryItem.dart';
import '../../models/Custormer.dart';
import '../../models/Product.dart';
import '../../models/bill.dart';
import '../../models/employee.dart';
import '../../views/AddCustomer/AddCustomer.dart';
import '../../counter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../localization/localizations_demo.dart';
import '../../Controller/Api/mobile.dart';

// ignore: must_be_immutable
class SaleMed extends StatefulWidget {
  SaleMed({Key key, this.products, this.mediaQueryData, this.employee})
      : super(key: key);
  Map<String, dynamic> products;
  Employee employee;

  Map<String, Product> tempBody = {};
  List quantity = [];

  double totalCostOfProducts = 0;
  String barCode;
  MediaQueryData mediaQueryData;
  bool isSearching = false;
  Customer customer = new Customer();
  TextEditingController textEditingController;

  @override
  _SaleMedState createState() => _SaleMedState();
}

class _SaleMedState extends State<SaleMed> {
  @override
  void initState() {
    super.initState();
    widget.quantity = new List.generate(widget.products.length, (index) => 0);
    widget.tempBody = new Map.from(widget.products);
    widget.tempBody.clear();
  }

  @override
  void dispose() {
    widget.products.clear();
    widget.quantity.clear();
    widget.tempBody.clear();
    widget.totalCostOfProducts = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Counter counterproduct = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(
        title: !widget.isSearching
            ? FittedBox(
                //
                child: Text(
                    DemoLocalizations.of(context).translate('titleAppbar')))
            : TypeAheadField(
                hideSuggestionsOnKeyboardHide: false,
                textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                        hintText: DemoLocalizations.of(context)
                            .translate('hintTextSearchField'))),
                suggestionsCallback: CustomerSearchByName().getUserSugesstions,
                itemBuilder: (context, suggestion) {
                  final user = suggestion;
                  return ListTile(
                    title: Text(user.name),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  widget.customer = suggestion;
                },
                // ignore: missing_return
                noItemsFoundBuilder: (context) {
                  return Center(
                    child: FittedBox(
                      child: Text(
                        'إذا أردت إضافة مريض اضغط على الزر بلس',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
        actions: [
          //search button
          widget.isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => setState(() => widget.isSearching = false))
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => setState(() => widget.isSearching = true)),
          //qrcode Button
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () async {
              widget.barCode = await ScanCodeByCamera().scanBarcodeNormal();
              if (widget.barCode == '-1') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('warnings'),
                    content: Text('this product is not there'),
                    actions: [
                      MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('okay'))
                    ],
                  ),
                );
              } else {
                Product temp = widget.products[widget.barCode];

                setState(() {
                  widget.tempBody[widget.barCode] = temp;
                });
              }
            },
          ),
          //add new Customer Button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCustomer()));
            },
          ),
        ],
      ),
      body: widget.tempBody.length == 0 || widget.tempBody == null
          ? Container(
              child: Center(
                child: Text('No add product to to basket'),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: widget.mediaQueryData.size.width * 0.01,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 23,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount:
                        widget.tempBody.length, //here to ceate list of grid
                    itemBuilder: (context, index) {
                      return CategoryItem(
                        mediaQueryData: widget.mediaQueryData,
                        product: widget
                            .tempBody[widget.tempBody.keys.toList()[index]],
                        index: index,
                        // bodyOfPage: widget.bodyOfBage,
                        quantity: widget.quantity,
                        mapBody: widget.tempBody,
                        totaleCost: widget.totalCostOfProducts,
                        callbackToChangeQuantityPropertyProduct: (object) =>
                            setState(() => widget.tempBody[
                                widget.tempBody.keys.toList()[index]] = object),
                        callbackToChangeTotalyCost: (object) =>
                            setState(() => widget.totalCostOfProducts = object),
                        callback: (object) =>
                            setState(() => widget.tempBody = object),
                        callbackNewQuantity: (object) =>
                            setState(() => widget.quantity = object),
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingButton(
            heroTag: 'btnSale',
            customer: widget.customer,
            tempBody: widget.tempBody,
            employee: widget.employee,
            totalCostOfProducts: widget.totalCostOfProducts,
            counterproduct: counterproduct,
          ),
          FloatingActionButton(
            heroTag: 'btn_PDF',
            onPressed: () async {

            },
            child: Text('pdf'),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key key,
    @required this.employee,
    @required this.customer,
    @required this.totalCostOfProducts,
    @required this.counterproduct,
    @required this.tempBody,
    @required this.heroTag,
  }) : super(key: key);

  final Employee employee;
  final String heroTag;
  final Customer customer;
  final double totalCostOfProducts;
  final tempBody;
  final Counter counterproduct;

  Future<void> press_createPdf(BuildContext context) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
      'Welcome to PDF succinctly?',
      PdfStandardFont(PdfFontFamily.helvetica, 30),
    );

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  pressButon_Stay(BuildContext context) {
    Navigator.pop(context);
  }

  pressButton_GoToMain(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          employee: employee,
        ),
      ),
    );
  }

  onPressed(BuildContext context) async {
    Bill bill = new Bill(
      idEmployee: employee.id,
      idCustomer: customer.id,
      products: tempBody,
      totalCost: totalCostOfProducts,
      dateTimeBill: DateFormat().format(
        DateTime.now(),
      ),
    );
    print('after make bill');

    await NewBuyingBill().addBill(bill);
    print('after asign');
    showDialogAfterSale(context);
    counterproduct.counterProduct = 0;
  }

  Future<dynamic> showDialogAfterSale(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("what you want do ??"),
        content: Text("Each button tells you what it does"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButtonOnSalePage(
                text: "Go To Main",
                press: () => pressButton_GoToMain(context),
              ),
              MaterialButtonOnSalePage(
                text: "pdf",
                press: () => press_createPdf(context),
              ),
              MaterialButtonOnSalePage(
                text: 'Stay',
                press: () => pressButon_Stay(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print(totalCostOfProducts);
      },
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: () => onPressed(context),
        child: Container(
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  counterproduct.counterProduct.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialButtonOnSalePage extends StatelessWidget {
  const MaterialButtonOnSalePage({
    Key key,
    this.press,
    this.text,
  }) : super(key: key);

  final Function press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: press,
        child: Container(
          margin: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.withOpacity(0.252),
                Colors.blueGrey.withOpacity(0.2)
              ]),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: FittedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
