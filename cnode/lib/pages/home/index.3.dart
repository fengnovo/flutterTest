import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'jokesDetail.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

import 'DataModel/jianyouquanData.dart';
import 'Liked.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String tabName = 'all';
  Map TAB_PAGE = {
    'all': 1,
    'ask': 1,
    'share': 1,
    'job': 1,
    'good': 1,
  };
  Map TAB_DATA = {
    'all': allArticleLists,
    'ask': askArticleLists,
    'share': shareArticleLists,
    'job': jobArticleLists,
    'good': goodArticleLists,
    'allData': [],
    'askData': [],
    'shareData': [],
    'jobData': [],
    'goodData': [],
  };

  final List<Tab> myTabs = <Tab>[
    new Tab(text: '全部'),
    new Tab(text: '精华'),
    new Tab(text: '分享'),
    new Tab(text: '问答'),
    new Tab(text: '招聘'),
  ];



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 7);
    print('_tabController----------------------->');
    _httpClient(TAB_PAGE[tabName], tabName);
  }

  void _httpClient(var page, String tab) async {
    var responseBody;

    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(
        Uri.parse("https://cnodejs.org/api/v1/topics?limit=10&mdrender=false&tab=${tab}&page=${page}"));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      List newData = jsonDecode(responseBody)["data"];
      List<Article> articleListsTemp = [];
      newData.forEach((item) {
        Article article = Article.fromJSON(item);
        articleListsTemp.add(article);
      });
      if(page == 1 && TAB_DATA[tab+'Data'] != null) {
        TAB_DATA[tab+'Data'].clear();
      }
      //更新数据
      setState(() {
        if(page == 1) {
          TAB_DATA[tab+'Data'] = newData;
          TAB_DATA[tab] = articleListsTemp;
        }else {
          for (int a = 0; a<newData.length; a++){
            TAB_DATA[tab+'Data'].add(newData[a]);
          }
          for (int b = 0; b<articleListsTemp.length; b++){
            TAB_DATA[tab].add(articleListsTemp[b]);
          }
        }
      });
      
    } else {
      print("error");
    }
  }

  // 顶部刷新
  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        TAB_PAGE[tabName] = 1;
        _httpClient(TAB_PAGE[tabName], tabName);
      });
    });
  }
  // 底部刷新
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        TAB_PAGE[tabName] += 1;
        _httpClient(TAB_PAGE[tabName], tabName);
      });
    });
  }


  Widget build(BuildContext context) {

      return new DefaultTabController(
        length: myTabs.length,
        child: new Scaffold(
          appBar: new AppBar(
          title: new Image.asset('images/logo.png',
                                    fit: BoxFit.cover,
                                    width: 140.0,
                                    height: 40.0,),
          centerTitle: false,
          backgroundColor: Colors.white,
          actions: <Widget>[
            new Row(
              children: <Widget>[
                  new Container(
                    child: new FlatButton(onPressed: (){}, child: new Icon(Icons.people)),
                    width: 44.0,
                  ),
                  new Container(
                    child: new FlatButton(onPressed: (){}, child: new Icon(Icons.search)),
                    width: 64.0,
                  ),
              ],
            )
          ],

          bottom: new TabBar(
              tabs: myTabs,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              // indicatorWeight: 15.0,
              indicator: new ShapeDecoration(
                  color: new Color.fromARGB(255,128,189,1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0.0),

                    ),
                  ),
              ),
              controller: _tabController,
              isScrollable: true,
          ),

        ),

          body: new TabBarView(
            controller: _tabController,
            children: myTabs.map((Tab tab) {
              if(tab.text == "全部"){
                return 
                // new ChoiceTab(
                //   tab: tab, 
                //   data: TAB_DATA, 
                //   onFooterRefresh: onFooterRefresh, 
                //   onHeaderRefresh: onHeaderRefresh, 
                //   buildCellItem: buildCellItem
                // );
                new Container(
                  child: TAB_DATA['allData']!= null ?
                    new Refresh(
                      onFooterRefresh: onFooterRefresh,
                      onHeaderRefresh: onHeaderRefresh,
                      child: new ListView.builder(
                        itemCount: TAB_DATA['all'].length,
                        itemBuilder: buildCellItem,
                        addRepaintBoundaries: false,
                      )
                    ): Center(child: new Text(tab.text)),

                );
              }else if(tab.text == "精华"){
                return new Container(
                  child: TAB_DATA['goodData']!= null ?
                    new Refresh(
                      onFooterRefresh: onFooterRefresh,
                      onHeaderRefresh: onHeaderRefresh,
                      child: new ListView.builder(
                        itemCount: TAB_DATA['good'].length,
                        itemBuilder: buildCellItem,
                        addRepaintBoundaries: false,
                      )
                    ): Center(child: new Text(tab.text)),

                );
              }else if(tab.text == "分享"){
                return new Container(
                  child: TAB_DATA['shareData']!= null ?
                    new Refresh(
                      onFooterRefresh: onFooterRefresh,
                      onHeaderRefresh: onHeaderRefresh,
                      child: new ListView.builder(
                        itemCount: TAB_DATA['share'].length,
                        itemBuilder: buildCellItem,
                        addRepaintBoundaries: false,
                      )
                    ): Center(child: new Text(tab.text)),
                );
              }else if(tab.text == "问答"){
                return new Container(
                  child: TAB_DATA['askData']!= null ?
                    new Refresh(
                      onFooterRefresh: onFooterRefresh,
                      onHeaderRefresh: onHeaderRefresh,
                      child: new ListView.builder(
                        itemCount: TAB_DATA['ask'].length,
                        itemBuilder: buildCellItem,
                        addRepaintBoundaries: false,
                      )
                    ): Center(child: new Text(tab.text)),
                );
              }else if(tab.text == "招聘"){
                return new Container(
                  child: TAB_DATA['jobData']!= null ?
                    new Refresh(
                      onFooterRefresh: onFooterRefresh,
                      onHeaderRefresh: onHeaderRefresh,
                      child: new ListView.builder(
                        itemCount: TAB_DATA['job'].length,
                        itemBuilder: buildCellItem,
                        addRepaintBoundaries: false,
                      )
                    ): Center(child: new Text(tab.text)),
                );
                
              }
              return new Center(child: new Text(tab.text));

            }).toList(),
          ),
        ),

      );
    }




  ////跳转段子详情
  pushAnotherView(Article article){
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) {
              var data = article;
              return new JokeDetailPage(mapd: data);
            }
        )
    );
  }





  void showAlertDialog(BuildContext context) {

  }

  //点击用户名 查看用户主页
  pushUserHomePage(int index, String message) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text("提示"),
            content: new Text(message),
            actions:<Widget>[
              new FlatButton(child:new Text("好的"), onPressed: (){

              },),
//              new FlatButton(child:new Text("OK"), onPressed: (){
//                Navigator.of(context).pop();
//
//              },)
            ]
        ));
  }




  //全部关注的Cell
  Widget buildCellItem (BuildContext context, int index) {

    double ScreenWidth = MediaQuery.of(context).size.width;
    double backImageWidthHeight = 50.0+40.0;
    var cellItem = new GestureDetector(
      onTap: () => pushAnotherView(TAB_DATA[tabName][index]),

      child: new Column(

        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                color: Colors.white,
                width: backImageWidthHeight,
                height: backImageWidthHeight,

                child: new Container(
                  width: backImageWidthHeight-40,
                  height: backImageWidthHeight-40,
                  padding: new EdgeInsets.all(20.0),
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(TAB_DATA[tabName][index].author.avatar_url),
                    radius: (backImageWidthHeight-20.0)/2.0,
                  ),
                ),
              ),
              new Container(
                width: ScreenWidth-backImageWidthHeight,
                height: backImageWidthHeight,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin:new EdgeInsets.only(right: 20.0, top: 25.0),
                      width: ScreenWidth-backImageWidthHeight-20.0,
                      height: 20.0,
                      child: new Text(TAB_DATA[tabName][index].title, style: new TextStyle(fontSize: 15.0, color: Colors.black),softWrap:false, overflow: TextOverflow.ellipsis),
                    ),
                    new Container(
                      margin:new EdgeInsets.only(right: 20.0, top: 5.0),
                      width: ScreenWidth-backImageWidthHeight-20.0,
                      height: 20.0,
                      child: new Text(TAB_DATA[tabName][index].author.loginname, style: new TextStyle(fontSize: 12.0, color: Colors.grey),softWrap:false, overflow: TextOverflow.ellipsis),
                    ),

                  ],
                ),
            ),
        ],
    ),
          new Divider(height: 1.0,),

        ],


      ),

    );

      return cellItem;
    }
}

class ChoiceTab extends StatelessWidget {
  ChoiceTab({Key key, this.tab, this.data, this.onFooterRefresh, this.onHeaderRefresh, this.buildCellItem}) : super(key: key);
  var tab;
  var data;
  var onFooterRefresh;
  var onHeaderRefresh;
  var buildCellItem;
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: data['allData']!= null ?
        new Refresh(
          onFooterRefresh: onFooterRefresh,
          onHeaderRefresh: onHeaderRefresh,
          child: new ListView.builder(
            itemCount: data['all'].length,
            itemBuilder: buildCellItem(tab),
            addRepaintBoundaries: false,
            
          )
        ): Center(child: new Text(tab.text)),
    );;
  }
}