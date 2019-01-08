/**
 *wdiget的删除和添加更好的实现方式  包括material提供的字体属性 
 */
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new LogoApp());
}

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LogoAppState();
  }
}

class LogoAppState extends State<LogoApp> {
  var _visible = true;

  @override
  Widget build(BuildContext context) {
    //通过Opacity的透明度值来控制 widget显示和隐藏 这比在树中删除和添加widget效率更高
    return new Opacity(
        opacity: _visible ? 1.0 : 0.0,
        child: new Center(
          child: new GestureDetector(
            onTap: () {
              //每次点击文本就在隐藏和显示之间切换
              _visible = _visible ? false : true;
              setState(() {});
            },
            child: new Text('当你点击我的时候 你会失去我',
              textDirection: TextDirection.ltr,style: const TextStyle(fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),),
          ),
        ));
  }
}