
/**
 * 动画实例3-监视动画的过程（根据动画的状态 例如启动 停止 和翻转方向）
 */
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new LogoApp());
}

/**
 * AnimatedWidget会自动调用addlistener和setState
 */
class AnimatedLogo extends AnimatedWidget {
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
}

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LogoAppState();
  }
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
    //添加了状态监听
      ..addStatusListener((state) {
        //当动画结束时执行动画反转
        if (state == AnimationStatus.completed) {
          controller.reverse();
          //当动画在开始处停止再次从头开始执行动画
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  build(dynamic) {
    return new AnimatedLogo(animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}