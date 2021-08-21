import '../../Controller/assistentController/ChoiceCategory.dart';
import '../../models/Product.dart';
import '../../models/employee.dart';

import '../../views/CategoriesOfMedicen.dart/CateOfMedicen.dart';
import '../../views/MainHome/components/AppBar.dart';
import '../../views/MainHome/components/Body.dart';

import 'package:flutter/material.dart';
import '../../Widgets/DrawerPharma.dart';

//import 'dart:ui' as ui;

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  Employee employee;
  MainScreen({Key key, this.employee}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin, ChangeNotifier {
  List color = [
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
  ];
  Map<String, List<Product>> lengthTabBar = {};

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBarMainScreen(
          mediaQueryData: mediaQueryData,
          employee: widget.employee,
        ),
        drawer: DrawerPharma(
          mediaQueryData: mediaQueryData,
          image: "assets/images/profile.png",
          name: widget.employee.name,
          email: widget.employee.email,
        ),
        body: Body(
          mediaQueryData: mediaQueryData,
          color: color,
          employee: widget.employee,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //ChoiceCategory().tester();
            lengthTabBar =
                ChoiceCategory().makeMission(await ChoiceCategory().tester());
            print(lengthTabBar.length);

            if (lengthTabBar == null) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('you didnt connect with internet'),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text('okay'),
                          )
                        ],
                      ));
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesOfMedicen(
                    cat: lengthTabBar,
                  ),
                ),
              );
            }
          },
          child: Icon(
            Icons.arrow_forward_sharp,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
        // bottomNavigationBar: BottomNavBar(
        //   mediaQueryData: mediaQueryData,
        // ),
        );
  }
}
