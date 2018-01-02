import 'package:flutter/material.dart';
import 'package:crypto1/pages/MainPage.dart' as mainPage;
import 'package:crypto1/pages/LoginPage.dart' as loginPage;
import 'package:crypto1/pages/BuyPage.dart' as buyPage;
import 'package:crypto1/pages/SellPage.dart' as sellPage;
import 'package:crypto1/pages/AboutPage.dart' as aboutPage;
import 'package:crypto1/pages/VirtualCryptoPage.dart' as vcPage;


void main(){

  runApp(new MaterialApp(
    theme: new ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange,
    ),
    home: new mainPage.MainPage(),
    routes: <String, WidgetBuilder>{
      buyPage.BuyPage.routeName: (BuildContext context) => new buyPage.BuyPage(),
      loginPage.LoginPage.routeName: (BuildContext context) => new loginPage.LoginPage(),
      sellPage.SellPage.routeName: (BuildContext context) => new sellPage.SellPage(),
      aboutPage.AboutPage.routeName: (BuildContext context) => new aboutPage.AboutPage(),
      vcPage.VirtualCryptoPage.routeName: (BuildContext context) => new vcPage.VirtualCryptoPage(),
    },
  ));
}