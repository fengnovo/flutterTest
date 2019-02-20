import 'package:flutter/material.dart';
import 'navigation_icon_view.dart';

import '../pages/about/index.dart';
import '../pages/home/index.dart';
import '../pages/message/index.dart';
import '../pages/my/index.dart';

class RootIndex extends StatefulWidget {

  @override
  State<RootIndex> createState() => new _RootState();
}

class _RootState extends State<RootIndex> with TickerProviderStateMixin{

  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: new Icon(Icons.home),
        title: new Text("主页"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.add_alert),
        title: new Text("消息"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.save_alt),
        title: new Text("关于"),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.my_location),
        title: new Text("我的"),
        vsync: this,
      ),
    ];
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _pageList = <StatefulWidget>[
      new HomePage(),
      new MessagePage(),
      new AboutPage(),
      new MyPage()
    ];
    _currentPage = _pageList[_currentIndex];
  }

  void _rebuild() {
    setState((){});
  }

  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationIconView) => navigationIconView.item)
            .toList(),
        currentIndex: _currentIndex,
        fixedColor: new Color.fromARGB(255,128,189,1),
        type: BottomNavigationBarType.fixed,

        onTap: (int index) {
          setState((){
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
            _currentPage = _pageList[_currentIndex];
          });
        }
    );

    return new MaterialApp(
        home: new Scaffold(
          body: new Center(
              child: _currentPage
          ),
          bottomNavigationBar: bottomNavigationBar,
        ),
    );
  }

}