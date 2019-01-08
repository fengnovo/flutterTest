import 'dart:async';

/**
 *http
 */
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './http.dart';

void main() {
  runApp(new MaterialApp(
      title: "input",
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("输入事件"),
          ),
          body: new MyWeather())));
}

class MyWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyWeatherState();
}

class MyWeatherState extends State<MyWeather> with NetListener {
  var weather = "delay" ;
  httpManager manager = new httpManager();

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new RaisedButton(
            child: new Text("获取实时天气"),
            onPressed: () {
              _getWeather();
            },
          ),
          new Expanded(
              child: new Center(
            child: new Text("$weather"),
          )),
        ],
      ),
    );
  }

  /**
   * 获取三天的预报 and 天气实况
   */
  _getWeather() async {
    await manager.getForecast(this, "闵行区");
    await manager.getNewWeather(this, "浦东新区");
  }

  @override
  void onError(error) {print("$error");}

  @override
  void onForecastResponse(String body) {
  }

  /**
   * 获取实况天气
   */
  @override
  void onNewWeatherResponse(String body) {
    weather = body;
    setState(() {});
  }
}