import 'package:flutter/material.dart';
import 'package:crypto1/drawer.dart';
import 'package:crypto1/widgets.dart';

class SellPage extends StatefulWidget{
  static String routeName = "/Sell";
  @override
  SellPageState createState() => new SellPageState();
}

class SellPageState extends State<SellPage> {
  Chart chart = new Chart();

  _chartStateChanger(){
    setState((){
      chart = new Chart();
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(title: new Text("Virtual-Crypto | Sell"),),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              color: Colors.green,
              onPressed: _chartStateChanger,
              child: new Text("Refresh"),
            ),
            new Text(
              'BTC week graph:',
            ),
            new Expanded(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Expanded(
                      child:  chart,
                    ),
                  ],
                )
            )
          ],
        ),
      )
    );
  }
}