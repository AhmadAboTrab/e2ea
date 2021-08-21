import './localization/localizations_demo.dart';

import './models/employee.dart';
import './routes/customer_rout.dart';
import './routes/route_names.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import './views/MainHome/MainScreen.dart';
import './counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;

  setLocale(Locale locale) {
    setState(() {
      this.locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    Employee emp = new Employee(
        id: 'q', name: 'Ahmad Abotrab', email: 'ahmad.abotrab2@gmail.com');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmacyApp',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      locale: this.locale,
      localizationsDelegates: [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SY')],
      onGenerateRoute: CustomerRoute.allRoutes,
      initialRoute: homeRoute,
      // home: MainScreen(employee: emp,),
      home: MainScreen(
        employee: emp,
      ),
    );
  }
}
