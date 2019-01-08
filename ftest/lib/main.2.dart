import 'package:flutter/material.dart';

// ignore: argument_type_not_assignable
void main() {
  /**
   * Center控件使其子控件在中间位置
   * Text控件显示各种文本
   * runApp函数将根控件显示在屏幕上
   */
  runApp(new MaterialApp(
    title: "我的应用",
    home: new MyAppBar(),
  ));
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Scaffold是Material中主要的布局组件
    return new Scaffold(
      //appBar用于显示一个应用栏在其Scaffold顶部
      appBar: new AppBar(
        //leading在标题之前显示的组件 IconButton 交互图标
        leading: new IconButton(
          //Icons是一个包含多个可用图标的列表
            icon: new Icon(Icons.menu),
            tooltip: "导航菜单",
            onPressed: null),
        title: new Text("京西商城"),
        //在标题之后显示的组件 注意是数组形式 可以有多个widget
        actions: <Widget>[
          new IconButton(
            //icon：在按钮中显示的图标
              icon: new Icon(Icons.shopping_cart),
              //tooltip:提示信息，当用户长按按钮时将显示此文本
              tooltip: "open shopping cart",
              //点击该按钮时的回调  类似于Andorid的onClick 如果设置为null将禁用该按钮(不妨碍tooltip)
              onPressed: openCart)
        ],
      ),
      //body将占屏幕的大部分 Scaffold中的主要内容
      body: new Center(
        //Center会将其子widget置于其中心位置  这是官方对他的说明 A widget that centers its child within itself.
        child: new Text("hello flutter"),
//        widthFactor: 5.0,//可以小于1.0但必须是正数 todo 现在这个我也没玩熟 还有待研究
//        heightFactor:50.0,/
      ),
      //FloatingActionButton 浮动按钮 将悬停在内容以上 note:每个页面最多一个浮动按钮 可以用于共享或导航等案例
      //和上面的iconbutton类似 属性就类似了不再做描述 其还有很多属性 比如backgroundColor 可以指定背景颜色 老夫的粉红少女心..
      floatingActionButton: new FloatingActionButton(
        tooltip: "增加",
        child: new Icon(Icons.add),
        onPressed: null,
        backgroundColor: Colors.pink,
      ),
    );
  }

  /**
   * 打开购物车的点击事件回调函数
   */
  void openCart() {
    print("open shopping cart");
  }
}

class MyAppBar extends StatelessWidget {
  final Widget title;
  final num test;

  /**
   * 两者的区别在于
   * 第一种必须传参
   * 第二种可选 看我的实现即可
   */
//  MyAppBar(this.title);
  MyAppBar({this.title, this.test});

  @override
  Widget build(BuildContext context) {
    //创建Container容器
    return new Container(
        height: 56.0, //高度为56像素(并非真实的像素 类似于浏览器中的像素)
        padding: const EdgeInsets.symmetric(horizontal: 8.0), //左侧和右侧均有8像素填充
        decoration: new BoxDecoration(color: Colors.blue[500]),
        //Row 水平方向的线性布局 children 所有子widget按水平方向排列
        child: new Row(children: <Widget>[
          //水平布局
          new IconButton(
            //onPressed：null会禁用Button
              icon: new Icon(Icons.menu),
              tooltip: "导航菜单",
              onPressed: null),
          new Expanded(child: title),
          //被标记为Expanded的widget 这意味着他会填充尚未被其他widget占用的剩余可用空间
          new IconButton(
              icon: new Icon(Icons.search), tooltip: "搜索", onPressed: null)
        ]));
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      //Column 垂直方向的线性布局
      child: new Column(
        //children类型为widget 所有子widget以垂直方向排列
        children: <Widget>[
          //在Column的顶部将MyAppBar传入, 将widget作为参数传递给其他widget 是比较常用的一种技术 可以创建各种复杂的widget
          new MyAppBar(
            title: new Text("京西商城",
                style: Theme.of(context).primaryTextTheme.title),
          ),
          //使用所有剩余空间 Center：居中显示
          new Expanded(
              child: new Center(
                child: new Text("hello flutter"),
              ))
        ],
      ),
    );
  }
}