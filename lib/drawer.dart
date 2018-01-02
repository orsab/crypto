import 'package:crypto1/pages/MainPage.dart';
import 'package:crypto1/pages/LoginPage.dart';
import 'package:crypto1/widgets.dart';
import 'package:flutter/material.dart';

BuildContext commonContext;

ListView drawerItems = new ListView(
  children: <Widget>[
    new DrawerHeader(
      child: new Logo(),
    ),
    new ListTile(
      leading: new Icon(Icons.home),
      title: new Text("Home"),
      onTap: () {
        Navigator.of(commonContext).pushReplacementNamed(MainPage.routeName);
      },
    ),
    new ListTile(
      leading: new Icon(Icons.account_box),
      title: new Text("Login"),
      onTap: () {
        Navigator.of(commonContext).pushReplacementNamed(LoginPage.routeName);
      },
    )
  ],
);
Drawer drawer = new Drawer(child: drawerItems);