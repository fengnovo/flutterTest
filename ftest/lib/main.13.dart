import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/**
 * 跳转到新页面并返回
 */
void main() {
  runApp(new MaterialApp(
    title: "Flutter",
    home: new FirstScreen(),
  ));
}
/**
 * 第一个页面
 */
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter"),
      ),
      body: new Center(
        child: new RaisedButton(
            child: new Text("登录"),
            onPressed: () {
              //跳转到新的 页面我们需要调用 navigator.push方法
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Second()));
            }),
      ),
    );
  }
}

/**
 * 第二个页面
 */
class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter"),
      ),
      body: new Center(
        //onPressed  点击事件
        child: new RaisedButton(child: new Text("注销"), onPressed: () {
          //回到上一个页面 该pop将Route从导航器管理的路由栈中移除当前路径
          Navigator.pop(context);
        }),
      ),
    );
  }
}