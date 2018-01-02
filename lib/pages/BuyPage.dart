import 'dart:async';

import 'package:crypto1/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto1/drawer.dart';
import 'package:async_loader/async_loader.dart';
import 'package:qrcode_reader/QRCodeReader.dart';

class BuyPage extends StatefulWidget {
  static String routeName = "/Buy";

  @override
  BuyPageState createState() => new BuyPageState();
}

class BuyPageState extends State<BuyPage> {

  var step2Visibility = 0.0;
  String amount = "0.0";
  String currency = "";
  bool processOK = false;
  Future<String> walletAddress = null;
  TextEditingController amountCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var calculatedAmount = new CalculateAmount();
    commonContext = context;

    return new Scaffold(
        drawer: drawer,
        appBar: new AppBar(title: new Text("Virtual-Crypto | Buy"),),
        body: new Container(
            padding: new EdgeInsets.all(15.0),
            child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "Chose coin to buy",
                        style: new TextStyle(fontSize: 30.0),)
                    ],
                  ),
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new MaterialButton(
                        color: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            currency = 'BTC';
                            step2Visibility = 1.0;
                            CalculateAmount.currency = 'BTC';
                            CalculateAmount.oldAmount = double.parse(amount);

                            calculatedAmount.reload();
                          });
                        },
                        child: new Image(
                          image: new AssetImage('images/bitcoin.png'),
                          width: 100.0,),
                      ),
                      new MaterialButton(
                          color: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              currency = 'ETH';
                              step2Visibility = 1.0;

                              CalculateAmount.currency = 'ETH';
                              CalculateAmount.oldAmount = double.parse(amount);
                              calculatedAmount.reload();
                            });
                          },
                          child: new Image(
                            image: new AssetImage('images/ethereum.png'),
                            width: 100.0,)
                      ),
                    ],
                  ),
                  new Opacity(
                    opacity: step2Visibility,
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          "Chose amount:",
                          style: new TextStyle(fontSize: 30.0),
                        ),
                        new ListTile(
                          leading: new Icon(Icons.attach_money),
                          title: new TextField(
                            controller: amountCtrl,
                            onChanged: (String amount) {
                              this.amount = amount;
                            },
                            onSubmitted: (String amount) {
                              this.amount = amount;
                              CalculateAmount.oldAmount = double.parse(amount);
                              calculatedAmount.reload();
                            },
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              hintText: "Amount",
                            ),
                          ),
                          subtitle: new Text(
                              "Set amount you want to invest"),
                        ),
                        new Divider(),
                        calculatedAmount,
                      ],
                    ),
                  ),
                  new Opacity(
                    opacity: amount == '0.0' || amount.isEmpty ? 0.0 : 1.0,
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          "Set Wallet address:",
                          style: new TextStyle(fontSize: 30.0),
                        ),
                        new MaterialButton(
                          onPressed: () {
                            setState(() {
                              walletAddress = new QRCodeReader()
                                  .setAutoFocusIntervalInMs(200)
                                  .setForceAutoFocus(true)
                                  .setTorchEnabled(true)
                                  .setHandlePermissions(true)
                                  .setExecuteAfterPermissionGranted(true)
                                  .scan();
                            });
                          },
                          color: Colors.orangeAccent,
                          child: new Text("Scan QRCode"),
                        ),
                        new FutureBuilder<String>(
                            future: walletAddress,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.data != null) {
                                processOK = true;
                                return new Column(
                                  children: <Widget>[
                                    new Text(snapshot.data,
                                        style: new TextStyle(
                                            color: Colors.orange,
                                            fontStyle: FontStyle.italic)),
                                    new MaterialButton(
                                      onPressed: processOK ? () {
                                        showDialog(
                                          context: context,
                                          child: new AlertDialog(
                                            title: const Text(
                                                "Payment received successfuly!"),
                                            content: new Text(
                                                "Your payment has accepted and transaction of "+CalculateAmount.calculatedAmount.toStringAsFixed(8)+CalculateAmount.currency+" confirmed to wallet: " +
                                                    snapshot.data.toString()),
                                            actions: [
                                              new FlatButton(
                                                child: const Text("Ok"),
                                                onPressed: () {
                                                  Navigator.pop(context);
//                                                  Navigator.pop(commonContext);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      } : null,
                                      color: Colors.green,
                                      child: new Text("Process"),
                                    )
                                  ],
                                );
                              }
                              else
                                return new Text("No wallet setted");
                            }),
                      ],
                    ),
                  ),
                ]
            )
        )
    );
  }
}
