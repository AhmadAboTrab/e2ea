//import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:e2ea/Controller/search/allSearch.dart';

import '../../../Controller/Api/deleteFromFirebase.dart';

import 'package:e2ea/views/Register/Register.dart';
import '../../../views/finincalReports/FinincalReports.dart';


import '../../../models/employee.dart';

import '../../../Controller/Api/Search/EmployeeSearch/EmployeeSearchByCharacter.dart';

import '../../../Controller/Api/Search/SearchWithAbstractMedicen/SearchByBarcode.dart';
import '../../../Controller/Api/Search/SearchWithAbstractMedicen/TradMedicen.dart';
import '../../../Controller/Api/Search/SearchWithAbstractMedicen/scientificMedicen.dart';
import '../../../Controller/assistentController/ScanCodeByCamera.dart';

import '../../../localization/localizations_demo.dart';
import '../../../main.dart';
import '../../../models/Language.dart';

import '../../../Widgets/SearchBy_flutterTypeHead.dart';
import '../../../models/Product.dart';
import '../../../Controller/assistentController/constantForPopMenu.dart';
import '../../../views/AddOrUpdateToMed/AddOrUpdateToMed.dart';
import '../../../views/DeleteAccount/deleteAccount.dart';
import '../../../views/EnteringCosts/EnteringCosts.dart';
import '../../../views/PageMedicins/PageMedicins.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Constants {
  Constants._();
  static const double padding = 30;
  static const double avatarRadius = 45;
}

//Notes
//title use FittedBox to make responseve text

// ignore: must_be_immutable
class AppBarMainScreen extends StatefulWidget
    with ChangeNotifier
    implements PreferredSizeWidget {
  MediaQueryData mediaQueryData;
  AppBarMainScreen({
    Key key,
    this.mediaQueryData,
    this.employee,
  }) : super(key: key);

  String barcode;
  Employee employee;

  @override
  _AppBarMainScreenState createState() => _AppBarMainScreenState();
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarMainScreenState extends State<AppBarMainScreen>
    with TickerProviderStateMixin {
  bool isSearching = true;
  String codeProduct;
  TextEditingController textEditingController;
  int typeOfSearch;

  void changedLang(Language lang) {
    print(lang.name);
  }

  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //nested function to choice what is screen should go to it

    //return widget AppBar
    return AppBar(
      title: isSearching
          ? Container(
              child: FittedBox(
                child: Text(
                  DemoLocalizations.of(context)
                      .translate('mainScreenTitleAppbar'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DancingScript',
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : typeOfSearch == 0 //employee
              ? SearchByFlutterTypeHead(
                  suggestionsCallback:
                      EmployeeSearchByCharacter().getUserSugesstions,
                ) //employee name search
              : typeOfSearch == 1 //scientific name
                  ? SearchByFlutterTypeHead(
                      suggestionsCallback:
                          ScientificMedicienSearchApi().getUserSugesstions,
                    ) //scientific name search
                  : typeOfSearch == 2 // trade name
                      ? SearchByFlutterTypeHead(
                          suggestionsCallback:
                              TradeMedicienSearchApi().getUserSugesstions,
                        ) //trade name search
                      : typeOfSearch == 3 // dont
                          ? SearchByFlutterTypeHead()
                          : Container(
                              child: FittedBox(
                                child: Text(
                                  DemoLocalizations.of(context)
                                      .translate('mainScreenTitleAppbar'),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DancingScript',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

      //this all action in appbar
      actions: <Widget>[
        //search button
        isSearching
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onSelected: choiceSearch,
                  offset: Offset(10, 45),
                  itemBuilder: (BuildContext context) {
                    return ConstantsMainPage.searchBy(context)
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        child: Text(
                          choice,
                          textAlign: TextAlign.end,
                          textDirection: ui.TextDirection.rtl,
                          style: TextStyle(color: Colors.black),
                        ),
                        value: choice,
                      );
                    }).toList();
                  },
                ),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                icon: Icon(Icons.cancel),
                color: Colors.white,
              ),
        //barcode button
        IconButton(
          onPressed: pressQrCodeIcon,
          icon: Icon(Icons.qr_code),
          color: Colors.white,
        ),

        //pop up button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: choicePopButton,
            offset: Offset(10, 45),
            itemBuilder: (BuildContext context) {
              return ConstantsMainPage.choices(context).map((String choice) {
                return PopupMenuItem<String>(
                  child: Text(
                    choice,
                    textAlign: TextAlign.start,
                    textDirection: ui.TextDirection.rtl,
                    style: TextStyle(color: Colors.black),
                  ),
                  value: choice,
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }

  pressQrCodeIcon() async {
    String barcode = await ScanCodeByCamera().scanBarcodeNormal();

    if (!mounted) return () {};
    setState(() {
      widget.barcode = barcode;
    });

    List nameProductAfterSearch =
        await SearchByBarcode().getUserSugesstions(barcode);

    if (nameProductAfterSearch != null) {
      if (nameProductAfterSearch != null) {
        Product product = nameProductAfterSearch[0];

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageMedicins(
                      product: product,
                    )));
      } else {
        print('i am in else\n');
      }
    }
  }

  void choiceSearch(String text) {
    if (text == DemoLocalizations.of(context).translate('SearchByEmployee')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 0;
      });

      return;
    }
    if (text == DemoLocalizations.of(context).translate('SearchBy_TradMed')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 2;
      });
      return;
    }
    if (text ==
        DemoLocalizations.of(context).translate('SearchBy_ScientificMed')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 1;
      });
      return;
    }
    if (text == DemoLocalizations.of(context).translate('SearchBy..')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 3;
      });
      return;
    }
  }

  void choiceLanguage(Language language) {
    Locale tempLocale;

    switch (language.languageCode) {
      case 'en':
        {
          tempLocale = Locale(language.languageCode, 'US');

          break;
        }
      case 'ar':
        {
          tempLocale = Locale(language.languageCode, 'SY');

          break;
        }
      default:
        {
          tempLocale = Locale(language.languageCode, 'US');

          break;
        }
    }
    MyApp.setLocale(context, tempLocale);
  }

  void choicePopButton(String choice) {
    if (choice ==
        DemoLocalizations.of(context).translate('showDetielsclacBox')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FinincalReports()),
      );
      return;
    }
    if (choice == DemoLocalizations.of(context).translate('newACCOUNT')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ),
      );
      return;
    }
    if (choice == DemoLocalizations.of(context).translate('DeleteAccount')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DeleteAccount(mediaQueryData: widget.mediaQueryData),
        ),
      );

      return;
    }
    if (choice == DemoLocalizations.of(context).translate('finincalReports')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinincalReports(
            mediaQueryData: widget.mediaQueryData,
          ),
        ),
      );

      return;
    }
    if (choice ==
        DemoLocalizations.of(context).translate('quantityInventory')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ),
      );

      return;
    }

    if (choice == DemoLocalizations.of(context).translate('EnteringCost')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnteringCosts(
            employee: widget.employee,
            mediaQueryData: widget.mediaQueryData,
          ),
        ),
      );

      return;
    }
    if (choice == DemoLocalizations.of(context).translate('addOrupdateMed')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddOrUpdateMed(
            employee:widget.employee,
            mediaQueryData: widget.mediaQueryData,
          ),
        ),
      );

      return;
    }
    if (choice == DemoLocalizations.of(context).translate('deleteProduct')) {
      deleteProduct();
      return;
    }
  }

  deleteProduct() async {
    String barcode = await ScanCodeByCamera().scanBarcodeNormal();
    List resultSearch = await SearchByBarcode().getUserSugesstions(barcode);
    Product product = resultSearch[0];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context, product),
      ),
    );
  }

  contentBox(context, Product product) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FittedBox(
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                DemoLocalizations.of(context).translate('contentDeleteProduct'),
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () async {
                      await DeleteFromFirebase()
                          .deleteFormFirebase(product, 'medicins');
                      Navigator.pop(context);
                    },
                    child: Text(
                      DemoLocalizations.of(context).translate('OkayButton'),
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 30,
          right: 45,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.avatarRadius)),
              child: Image.asset("assets/images/panadol.png"),
            ),
          ),
        ),
      ],
    );
  }
}
