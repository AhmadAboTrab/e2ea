//import 'package:e2ea/views/Entering/Entring.dart';

import '../../../Controller/assistentController/ChoiceCategory.dart';
import '../../../localization/localizations_demo.dart';
import '../../../models/Product.dart';
import '../../../models/employee.dart';
import '../../../views/SaleMed/SaleMed.dart';

import '../../../models/quantity.dart';

import '../../../views/enteringMedicen/enteringMedicen.dart';

import '../../../Widgets/MainOperationCard.dart';
import '../../../Controller/assistentController/constantForPopMenu.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body(
      {Key key,
      @required this.mediaQueryData,
      @required this.color,
      @required this.employee})
      : super(key: key);

  final MediaQueryData mediaQueryData;
  final List color;
  Employee employee;
  List<Quantity> productsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mediaQueryData.size.width * 0.008,
            ),
            Container(
              height: 500,
              width: mediaQueryData.size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  itemCount: color.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return MainOpCard(
                      color: color,
                      data: ConstantsMainPage.opGridView(context),
                      index: index,
                      mediaQueryData: mediaQueryData,
                      press: () async {
                        // if (ConstantsMainPage.opGridView(context)[index]
                        //             .keys
                        //             .toString() ==
                        //         '(حساب الصندوق اليوم)' ||
                        //     ConstantsMainPage.opGridView(context)[index]
                        //             .keys
                        //             .toString() ==
                        //         '(sale)') {
                        //   //Here should make Calaculate about box and get result
                        //   final snackBar = SnackBar(
                        //     content: Text('Yay! A SnackBar!'),
                        //     duration: Duration(milliseconds: 1000),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     backgroundColor: Colors.blueGrey,
                        //     behavior: SnackBarBehavior.fixed,
                        //   );
                        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // }
                        if (ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(شراء الأدوية)' ||
                            ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(buy Med)') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnteringMedicen(
                                        productsList: productsList,
                                        employee:employee,
                                      )));
                        }
                        if (ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(بيع أدوية)' ||
                            ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(sale)') {
                          Map<String, Product> products =
                              await ChoiceCategory().tester();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SaleMed(
                                        mediaQueryData: mediaQueryData,
                                        products: products,
                                        employee: employee,
                                      )));
                        }
                      },
                      pressInformation: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context, index),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, int index) {
    return new AlertDialog(
      title: Text(
        DemoLocalizations.of(context).translate('titleAlertDialoge'),
        textDirection: ui.TextDirection.rtl,
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            ConstantsMainPage.opGridView(context)[index]
                .values
                .toString()
                .substring(
                    1,
                    ConstantsMainPage.opGridView(context)[index]
                            .values
                            .toString()
                            .length -
                        1),
            textDirection: ui.TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          // ignore: deprecated_member_use
          child: new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ),
      ],
    );
  }
}
