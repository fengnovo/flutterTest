import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';


class JokeDetailPage extends StatefulWidget {

  JokeDetailPage ({var key,this.mapd}):super(key:key);//接收从上一个页面传来的值
  var mapd;

  @override
  _JokeDetailPageState createState() => new _JokeDetailPageState(mapd, mapd);

}


class _JokeDetailPageState extends State<JokeDetailPage>  {

  _JokeDetailPageState(var key, this.mapd);
  var mapd;
  int PAGE = 1;

  bool _isPlaying = false;


  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(

      home: new Scaffold(
        appBar: new AppBar(
          leading: new FlatButton(
            onPressed:(){
              Navigator.pop(context);
            },
            color: Colors.white,
            child: new Icon(Icons.keyboard_backspace,color: new Color.fromARGB(255,128,189,1), ),
          ),
          title: new Text('详情', style: new TextStyle(fontSize: 17.0, color: Colors.black), ),
          backgroundColor: Colors.white,
        ),

        body: new Container(
            child:
              new ListView.builder(
                itemCount: 1,
                itemBuilder: buildCellTopItem,
              )
        ),
    )
    );
  }




  ////顶部的详情
  Widget buildCellTopItem (BuildContext context, int index) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double lableWidth = ScreenWidth-30.0-40.0-10.0;

    var cellItemInfo = new GestureDetector(
        onTap: ()=>{},
        child: new Column(

          children: <Widget>[


            //时间+用户名
            new Container(
              color: Colors.white,
              width: ScreenWidth,
              height: 70.0,
              child: new Row(
                children: <Widget>[
                  //头像
                  new Container(
                    margin: new EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                    width: 40.0,
                    height: 40.0,
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(mapd.author.avatar_url,),
                      radius: 40.0/2.0,
                    ),
                  ),
                  new Column(
                    children: <Widget>[
                      new Container(
                        width: lableWidth,
                        margin: new EdgeInsets.only(left: 10.0, top: 18.0),
                        child: new Text(mapd.author.loginname, style: new TextStyle(fontSize: 13.0, color: Colors.blue), softWrap:false, overflow: TextOverflow.ellipsis),
                      ),

                      new Container(
                        width: lableWidth,
                        margin: new EdgeInsets.only(left: 10.0, top: 5.0),
                        child: new Text(mapd.create_at, style: new TextStyle(fontSize: 12.0, color: Colors.grey), softWrap:false, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  )

                ],
              ),
            ),

            /////text
            new Container(
                width: ScreenWidth,
                color: Colors.white,
                child: Container(
                  margin: new EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: new Text(mapd.content, style: new TextStyle(fontSize: 14.0, color: Colors.black), softWrap: true,),
                )
            ),

            //中间图片
            // new Container(
            //     color: Colors.white,
            //     width: ScreenWidth,
            //     child: new Container(
            //         margin: new EdgeInsets.only(left: 15.0, right: 20.0, bottom: 15.0),
            //         child: new FadeInImage.memoryNetwork(
            //           alignment: Alignment.centerLeft,
            //           placeholder: kTransparentImage,
            //           image: mapd["thumbnail"], //== null ?*/ "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1236557510,3858779538&fm=27&gp=0.jpg",
            //         )
            //     )

            // ),

            new Divider(height: 1.0),
          ],


        )
    );

      return cellItemInfo;
  }
}