import 'package:flutter/material.dart';

/**
 * 在flutter中构建布局

 * flutter的布局机制如何工作
 * 如何垂直和水平布局widget
 *如何构建一个flutter布局
 */
void main() {
  runApp(new MaterialApp(
    title: "",
    home: new MyApp(),
  ));
}

/**
 * 实现标题行
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      //整体是一个水平布局
      child: new Row(
        children: [
          //这里用Expanded的好处就是 会占用icon之外的剩余空间
          new Expanded(
            //在Expanded内创建一个垂直布局 放置两个文本
              child: new Column(
                //文本是起始端对齐
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      "处理器",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  new Text(
                    "深圳, 广东",
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  )
                ],
              )),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('41')
        ],
      ),
    );

    /**
     * 抽取button行的代码复用
     */
    Column getText(IconData icon, String text) {
      return new Column(
        //聚集widgets
        mainAxisSize: MainAxisSize.min,
        //child 居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: Colors.blue[500]),
          new Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: new Text(
                text,
                style: new TextStyle(
                  color: Colors.blue[500],
                ),
              ))
        ],
      );
    }

    /**
     * 实现按钮部分
     */
    Widget buttonSection = new Container(
      child: new Row(
        //MainAxisAlignment.spaceEvenly平均分配子空间  他会在每个子项之间,之前,之后平均分配空闲空间 当然也可以使用Expanded来实现
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getText(Icons.call, "电话"),
          getText(Icons.near_me, "留言"),
          getText(Icons.share, "分享")
        ],
      ),
    );

    /**
     * 实现文本部分

     */
    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
          "一插上电,50平米内都暖和了!3天一度电,今日特惠!一插上电,50平米内都暖和了!3天一度电,今日特惠!一插上电,50平米内都暖和了!3天一度电,今日特惠!一插上电,50平米内都暖和了!3天一度电,今日特惠!",
          softWrap: true),//softWrap: true 文本是否在换行符处中断
    );

    /**
     * 整合
     */
    return new MaterialApp(
      title: "Flutter Layout",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("商品详情页"),
        ),
        body: new ListView(
          children: [
            new Image.asset(
              "lib/images/1.png",
              width: 600.0,
              height: 240.0,
              //类似于Android的scaleType 此处让图片尽可能小 以覆盖整个widget
              fit: BoxFit.contain,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }
}