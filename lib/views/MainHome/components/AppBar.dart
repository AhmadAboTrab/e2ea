//import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:e2ea/Controller/search/allSearch.dart';

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
import '../../../views/screen_PopUpMenu/MonthyInventory.dart';
import '../../../views/screen_PopUpMenu/YearInventory.dart';
import '../../../views/screen_PopUpMenu/createAccount.dart';
import '../../../views/screen_PopUpMenu/detailsOfBox.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//import 'package:flutter_typeahead/flutter_typeahead.dart';

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
        // Container(
        //   child: PopupMenuButton<Language>(
        //     icon: Icon(Icons.language),
        //     onSelected:
        //       choiceLanguage,

        //     itemBuilder: (BuildContext context) {
        //       return Language.langList().map<PopupMenuItem<Language>>((e) {
        //         return PopupMenuItem(
        //             child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [Text(e.name), Text(e.flag)],
        //         ));
        //       }).toList();
        //     },
        //   ),
        // )
        // Center(
        //   child: Container(
        //     margin:
        //         EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
        //     child: Center(
        //       child: DropdownButton(
        //         icon: Icon(
        //           Icons.language,
        //           color: Colors.black,
        //         ),
        //         onChanged: (value) {
        //           choiceLanguage(value);
        //         },
        //         items: Language.langList().map<DropdownMenuItem<Language>>((e) {
        //           return DropdownMenuItem(
        //               value: e,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [Text(e.name), Text(e.flag)],
        //               ));
        //         }).toList(),
        //       ),
        //     ),
        //   ),
        // ),
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

  void choicePopButton(String text) {
    if (text == DemoLocalizations.of(context).translate('showDetielsclacBox')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsOfBox()),
      );
      return;
    }
    if (text == DemoLocalizations.of(context).translate('newACCOUNT')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAccount(),
        ),
      );
      return;
    }
    if (text == DemoLocalizations.of(context).translate('DeleteAccount')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DeleteAccount(mediaQueryData: widget.mediaQueryData),
        ),
      );

      return;
    }
    if (text == DemoLocalizations.of(context).translate('jareddMonthly')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MonthlyInventory(),
        ),
      );

      return;
    }
    if (text == DemoLocalizations.of(context).translate('jarddYear')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YearInventory(),
        ),
      );

      return;
    }
    if (text == DemoLocalizations.of(context).translate('EnteringCost')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnteringCosts(employee: widget.employee,),
        ),
      );

      return;
    }
    if (text == DemoLocalizations.of(context).translate('addOrupdateMed')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddOrUpdateMed(
            mediaQueryData: widget.mediaQueryData,
          ),
        ),
      );

      return;
    }
  }
}
