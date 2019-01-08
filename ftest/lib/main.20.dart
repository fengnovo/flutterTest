/**
 * 动画实例4-用AnimatedBuilder重构
 */
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new LogoApp());
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      child: new FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return new Center(
//      顾名思义 AnimatedBuilder是用于构建动画的widget
      child: new AnimatedBuilder(
//        动画 没啥好说的
        animation: animation,
//        每次动画改变值时调用
        builder: (BuildContext contextm, Widget child) {
          return new Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
//        执行动画的事件源 这里很简单就是LogoWidget 就是一个Flutter LOGO
        child: child,
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LogoAppState();
  }
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    //CurvedAnimation类可以将曲线应用于另一个动画的动画 有点拗口,通俗点讲是通过Curves提供的多种动画曲线的数组来改变原线性动画 有点类似于android的动画插值器的作用
    //此处将曲线应用于AnimationController生成的线性动画中
    CurvedAnimation curvedAnimation =
    new CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = new Tween(begin: 0.0, end: 300.0).animate(curvedAnimation);
    controller.forward();
  }

  @override
  build(dynamic) {
    return new GrowTransition(
      child: new LogoWidget(),
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}