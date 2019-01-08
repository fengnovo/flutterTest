import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:path/path.dart';

void main() {
  //  debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Stack",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Stack"),
        ),
        body: new MyStack(),
      ),
    );
  }
}

class MyStack extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyStackState();
  }
}

class MyStackState extends State<MyStack> {
  @override
  Widget build(BuildContext context) {
    //以简单的方式重叠多个子项 缺点是无法以特定模式放置多个子项,特别是当使用Stack时你无法根据大小或Stack自身大小来定位子项
    return new Stack(
      //控制其子项位置
      //alignment: AlignmentDirectional.center,
      //通过绝对坐标来控制子项位置
      alignment: const Alignment(0.0, -0.6),
      children: [
        //圆形图像
        //第一个widget为Base widget 随后的widget将会覆盖在base widget上 位置alignment控制
        new CircleAvatar(
          backgroundColor: Colors.black,
          backgroundImage: new AssetImage("lib/images/1.png"),
          radius: 100.0,
        ),
        new Container(
          child: new Text(
            "xiaoshuang",
            style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}