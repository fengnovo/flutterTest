import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Card",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Card"),
        ),
        body: new MyCard(),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyCardState();
  }
}

class MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    //sizedBox部件会强制子项具有给定的宽度和高度(父级允许的话),如果没有给定宽度|高度,将
    //自行调整以维护子项大小
    return new SizedBox(
      height: 420.0,
      child: buildCard(),
    );
  }
}

Widget buildCard() {
  return new Card(
    //背景色
    color: Colors.cyan,
    //阴影大小-默认2.0
    elevation: 5.0,
    child: new Column(
      //横轴起始测对齐
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStackImgBack(),
        _buildText(),
        _buildRowText(),
      ],
    ),
  );
}

/**
 * 3.水平文本部分
 */
Widget _buildRowText() {
  return new Row(
    children: [
      _buildContainer("SHARE"),
      _buildContainer("EXPLORE"),
    ],
  );
}

Widget _buildContainer(String text) {
  return new Container(
      margin: const EdgeInsets.only(left: 10.0, bottom: 10.0),
      child: new Text(
        text,
        style: new TextStyle(
            fontSize: 15.0, color: Colors.blue, fontWeight: FontWeight.bold),
      ));
}

/**
 * 2.垂直文本部分
 */
Widget _buildText() {
  return new Expanded(
      child: new Container(
    margin: const EdgeInsets.only(left: 10.0, top: 10.0),
    padding: const EdgeInsets.all(5.0),
    child: new Column(
      //横轴对齐方式 起始测对齐
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text("数量10个",style: const TextStyle(color: Colors.white),),
        new Text("深圳 广东",style: const TextStyle(color: Colors.white),),
        new Text("测试项目，测试商品",style: const TextStyle(color: Colors.white),),
      ],
    ),
  ));
}

/**
 * 1.图片部分
 */
Widget _buildStackImgBack() {
  return new Stack(
    //开始一侧的底角 当然我们也可以通过绝对坐标来控制
    alignment: AlignmentDirectional.bottomStart,
    children: [
      new Image.asset("lib/images/1.png",
              width: 600.0,
              height: 240.0,
              //类似于Android的scaleType 此处让图片尽可能小 以覆盖整个widget
              fit: BoxFit.fill),
      new Container(
          padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
          child: new Text(
            "intel高端处理器",
            style: new TextStyle(color: Colors.black, fontSize: 20.0),
          ))
    ],
  );
}