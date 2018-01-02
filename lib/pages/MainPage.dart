import 'dart:async';

import 'package:crypto1/pages/AboutPage.dart';
import 'package:crypto1/pages/BuyPage.dart';
import 'package:crypto1/pages/LoginPage.dart';
import 'package:crypto1/pages/SellPage.dart';
import 'package:crypto1/pages/VirtualCryptoPage.dart';
import 'package:flutter/material.dart';
import 'package:crypto1/drawer.dart';
import 'package:qrcode_reader/QRCodeReader.dart';

class MainPage extends StatefulWidget {
  static String routeName = "/";

  @override
  State<StatefulWidget> createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  Future<String> _barcodeString;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    commonContext = context;
    Color buyBtnColor = new Color.fromARGB(200, 146, 10, 0);
    Color sellBtnColor = new Color.fromARGB(200, 40, 80, 255);
    Color aboutBtnColor = new Color.fromARGB(200, 130, 85, 0);
    Color vcBtnColor = new Color.fromARGB(200, 170, 170, 170);
    BorderSide bs = new BorderSide(
        color: new Color.fromARGB(255, 146, 10, 0), width: 2.0);
    Border border = new Border(top: bs, bottom: bs, left: bs, right: bs);
    String ratesText = "BTC: 14,234.66\$ LTC: 234.23\$ ETH: 764.33\$";

    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(title: new Text("Virtual-Crypto | Main"),),
      body: new Center(
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('images/bitcoin.png'),
                fit: BoxFit.contain
            ),
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  border: border,
                ),
                child: new MaterialButton(
                    height: 150.0,
                    color: buyBtnColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(BuyPage.routeName);
                    },
                    child: new Text(
                      "BUY", style: new TextStyle(fontSize: 90.0),)
                ),
              ),
              new Container(
                decoration: new BoxDecoration(
                  border: border,
                ),
                child: new MaterialButton(
                    height: 150.0,
                    color: sellBtnColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(SellPage.routeName);
                    },
                    child: new Text(
                      "SELL", style: new TextStyle(fontSize: 90.0),)
                ),
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                      border: border,
                    ),
                    child: new MaterialButton(
                        minWidth: 175.0,
                        height: 160.0,
                        color: aboutBtnColor,
                        onPressed: () {
                          Navigator.of(context).pushNamed(AboutPage.routeName);
                        },
                        child: new Text(
                          "ABOUT\nATM", style: new TextStyle(fontSize: 40.0),
                          textAlign: TextAlign.center,)
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      border: border,
                    ),
                    child: new MaterialButton(
                      child: new Image(
                        image: new AssetImage('images/pp-trans.png'),
                        width: 140.0,
                        height: 160.0,),
                      minWidth: 176.0,
                      height: 160.0,
                      color: vcBtnColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(VirtualCryptoPage.routeName);
                      },
                    ),
                  ),
                ],
              ),
              new Container(
                child: new Text(ratesText,
                overflow: TextOverflow.ellipsis,style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0,color: Colors.white70)),
              )
            ],
          ),
        ),
      ),
    );
  }
}