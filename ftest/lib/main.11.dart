import 'package:flutter/material.dart';

/**
 * GestureDetector 处理手势
 */
// ignore: argument_type_not_assignable
void main() {
  /**
   * Center控件使其子控件在中间位置
   * Text控件显示各种文本
   * runApp函数将根控件显示在屏幕上
   */
  runApp(new MaterialApp(
    title: "我的应用",
    home: new MyButton(),
  ));
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //GestureDetector并不具有显示效果，而是检测由用户做出的手势(点击拖动和缩放)
    return new GestureDetector(
      //发生点击事件后回调
      onTap: () {
        print("hia");
      },
      //发生双击时间后回调
      onDoubleTap: (){
        print("hia hia");
      },
//      长按事件
      onLongPress: (){
        print("hia hia hia........");
      },
      child: new Container(
        height: 36.0,
        //EdgeInsets 这个类就比较diao了 通过他可以很好的控制widget上下左右的偏移量 有.all全部设置 也有.symmetric水平和垂直可选  也有.only上下左右可选
        //官网对EdgeInsets的说明 Typically used for an offset from each of the four sides of a box. For example, the padding inside a box can be represented using this class.
        //这里的padding对Center是操作无效的 但如果改为EdgeInsets.only(left:8.0),就可以看到明显的偏移
        padding: const EdgeInsets.all(8.0),
        //上下左右都偏移8像素边距
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        //symmetric的参数是可选的 水平方向
//        背景装饰
        decoration: new BoxDecoration(
          //圆角和颜色
            borderRadius: new BorderRadius.circular(5.0),
            color: Colors.lightGreen[500]),
        child: new Center(child: new Text("点击监听")),
      ),
    );
  }
}