import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:ui' as ui;
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class Logo extends StatelessWidget {
  final Image image = new Image(
    image: new AssetImage("images/pp-trans.png"), width: 200.0,);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          padding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          child: new Column(
            children: <Widget>[
              image
            ],
          ),
        )
    );
  }
}

class CalculateAmount extends StatelessWidget {
  static final GlobalKey<AsyncLoaderState> _asyncLoaderState = new GlobalKey<
      AsyncLoaderState>();
  static double oldAmount = 0.0;
  static double calculatedAmount = 0.0;
  static String currency = '';
  static const Duration TIMEOUT = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await calculateAmount(),
        renderLoad: () => new CircularProgressIndicator(),
        renderError: ([error]) =>
        new Text('Sorry, there was an error loading your joke'),
        renderSuccess: ({data}) {
          calculatedAmount = oldAmount * data;
          return new ListTile(
            leading: new Icon(Icons.monetization_on),
            title: new Text(
                (calculatedAmount).toStringAsFixed(8) + " $currency"),
          );
        }
    );
  }

  reload() {
    _asyncLoaderState.currentState.reloadState();
  }

  calculateAmount() {
    if (oldAmount == 0.0)
      return new Future.value(0.0);

    if (currency == 'BTC') {
      return new Future.delayed(TIMEOUT, () => 0.0023);
    }
    if (currency == 'ETH') {
      return new Future.delayed(TIMEOUT, () => 0.06);
    }

    return new Future.delayed(TIMEOUT, () => 0.0);
  }
}


class Chart extends StatefulWidget {
  final Future<http.Response> data = http.get(
      Uri.encodeFull("http://188.166.56.67:3000/data"),
      headers: {"Accept": "application/json"}
  );

  @override
  State<StatefulWidget> createState() => new ChartState(this.data);
}

class ChartState extends State<Chart> {
  LineChartOptions _lineChartOptions;
  ChartData _chartData;
  bool isReady = false;
  var data;
  Future<http.Response> resp;

  ChartState(this.resp){

    this.resp.then((http.Response resp){
      print('charts state');
      data = JSON.decode(resp.body);
      print(data);
    });
  }

  defineOptionsAndData() {
//    http.Response response = await http.get(
//        Uri.encodeFull("http://188.166.56.67:3000/data"),
//        headers: {"Accept": "application/json"}
//    );
//
//    var data = JSON.decode(response.body);

//    _chartData = new RandomChartData(useUserProvidedYLabels: _lineChartOptions.useUserProvidedYLabels);
  setState((){
    _lineChartOptions = new LineChartOptions();
    _chartData = new ChartData();
    _chartData.dataRowsLegends = this.data != null ? this.data['legend'] : ['1','2','3'];

    _chartData.dataRows = this.data != null ? this.data['points'] :[
      [1000.0,3000.0,7000.0,15000.0,19300.01,13400.01],
      [100.0,120.0,200.0,300.0,350.0,250.0],
      [200.0,350.0,430.0,700.0,850.0,800.0]
    ];
    _chartData.xLabels = this.data != null ? this.data['xlabels'] :[
      "1-2","3-4","5-6","7-8","9-10","11-12"
    ];
    _chartData.dataRowsColors = [
      Colors.green,
      Colors.red,
      Colors.blue,
    ];
    _lineChartOptions.useUserProvidedYLabels = true; // use labels below
    _chartData.yLabels = [
      "0","10000","20000"
    ];
  });
    return 'ok';
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    ui.Size windowLogicalSize = mediaQueryData.size;
    double logicalToDevicePixelSize = mediaQueryData.devicePixelRatio;
    double fontScale = mediaQueryData.textScaleFactor;
    final ui.Size chartLogicalSize = new Size(windowLogicalSize.width, windowLogicalSize.height / 2);

    defineOptionsAndData();

    return new LineChart(
      painter: new LineChartPainter(),
      layouter: new LineChartLayouter(
          chartData: _chartData,
          chartOptions: _lineChartOptions),
    );
  }
}
