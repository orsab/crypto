import 'package:flutter/material.dart';
import 'package:crypto1/drawer.dart';

class LoginPage extends StatefulWidget{
  static String routeName = "/Login";
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    commonContext = context;
    TextEditingController loginController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(title: new Text("Virtual-Crypto | Login"),),
      body: new Center(
        child: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(controller: loginController,
                decoration: new InputDecoration(hintText: "User name"),
                onChanged: (String un) => username = un,
              ),
//                onSubmitted: (String un) => setState((){
//                  print(un);
//                })),
              new TextField(controller: passwordController,
                decoration: new InputDecoration(hintText: "Password"),
                obscureText: true,
                onChanged: (String pass) {
                  setState((){
                    password = pass;
                  });
                },
//                onSubmitted: (String pass) => setState((){
//                  password = pass;
//                }),
              ),
              new RaisedButton(
                onPressed: (){
                  print(username);
                  print(password);
                },
                child: new Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}