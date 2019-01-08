import 'package:flutter/material.dart';

void main() {
  //runApp接受的widget将成为widget树的根(ps：相当于顶层容器)
  runApp(
    //此处的Center和Text是两个widget,显示效果就是一个Hello, Flutter!在屏幕中央
    new Center(
      child: new Text(
        'Hello, 黄云锋!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}