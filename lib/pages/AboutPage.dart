import 'package:flutter/material.dart';
import 'package:crypto1/drawer.dart';

class AboutPage extends StatefulWidget{
  static String routeName = "/About";
  @override
  AboutPageState createState() => new AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(title: new Text("Virtual-Crypto | About"),),
      body: new Center(
        child: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}