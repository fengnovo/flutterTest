/**
 * 动画实例1 -渲染动画
 */
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new AnimationApp());
}

class AnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Animation",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Animation"),
        ),
        body: new MyAnimation(),
      ),
    );
  }
}

class MyAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyLogoState();
  }
}

class MyLogoState extends State<MyAnimation> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  /**
   *重写此方法以执行初始化 每次构建State调用此方法一次 注意如果重写此方法 必须加 super.initState();
   */
  initState() {
    print("initState初始化");
    //如果重写此方法 必须加super
    super.initState();
    //动画控制器
    controller = new AnimationController(
      //vsync 需要实现TickerProviderStateMixin or SingleTickerProviderStateMixin 可以避免动画不在当前屏幕显示时消耗资源
        duration: const Duration(milliseconds: 2000),//持续时间
        vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        //..代表的是给animate方法的返回值添加addListener监听
        setState(() {}); //build重新构建
      });
    //开始执行此动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }

  /**
   * 从树种删除此对象时调用释放资源
   */
  dispose() {
    //释放此对象使用的资源以防止内存泄漏,调用该方法后,此对象不再可用
    controller.dispose();
    super.dispose();
  }
}

/**
  开始学习Flutter动画

  渲染动画
  AnimatedWidget简化
  监视动画的过程（根据动画的状态 例如启动 停止 和翻转方向）
  用AnimatedBuilder重构
  并行动画 
 */