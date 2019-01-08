/**
 * 动画实例5 并行动画
 */
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new LogoApp());
}

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      //Opacity 使子项部分透明的小组件
      child: new Opacity(
        //不透明度1.0是完全不透明的也就是完全可见的 0.0是完全透明的也就是完全不可见的,最好使用0.0-1.0 否则将付出更大的代价
        opacity: _opacityTween.evaluate(animation),
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: new FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LogoAppState();
  }
}

class LogoAppState extends State<LogoApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation = new CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        controller.reverse();
      } else if (state == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedLogo(
      animation: animation,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}