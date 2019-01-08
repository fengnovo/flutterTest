import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new MaterialApp(
    title: "input",
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("输入事件"),
      ),
      body: new LogoApp(),
    ),
  ));
}

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LogoAppState();
  }
}

class LogoAppState extends State<LogoApp> {
  // material包下的类 可编辑文本控制器 text将被作为初始文本显示在TextField中
//  final TextEditingController _controller = new TextEditingController(text: "duo_shine");
  //text将被作为初始文本显示在TextField中
  final TextEditingController _controller =
  new TextEditingController.fromValue(new TextEditingValue(text: "duo_shine"));

  @override
  Widget build(BuildContext context) {
    //通过Opacity的透明度值来控制 widget显示和隐藏 这比在树中删除和添加widget效率更高
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
            controller: _controller,
            decoration: new InputDecoration(
              hintText: "用户名",
            )),
        new RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                //_controller.text 用户正在编辑的当前字符串
                child: new AlertDialog(
                  title: new Text("用户名"),
                  content: new Text(_controller.text),
                ));
             _controller.clear(); // 将值设置为空
              
          },
          child: new Text("登录"),
        )
      ],
    );
  }
}