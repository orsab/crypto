import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto1/drawer.dart';
import 'package:http/http.dart' as http;

class VirtualCryptoPage extends StatefulWidget{
  static String routeName = "/VirtualCrypto";
  @override
  VirtualCryptoPageState createState() => new VirtualCryptoPageState();
}

class VirtualCryptoPageState extends State<VirtualCryptoPage> {

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("http://188.166.56.67:3000/data"),
        headers: {"Accept" : "application/json"}
    );

    var data = JSON.decode(response.body);

    return data[0];
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(title: new Text("Virtual-Crypto"),),
      body: new Center(
        child: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(onPressed: getData)
            ],
          ),
        ),
      ),
    );
  }
}