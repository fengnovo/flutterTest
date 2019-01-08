import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

final todos = new List<Todo>.generate(
    20,
        (i) => new Todo(
        "详情$i", "这是第$i个详情页"));
/**
 * 跳转到新页面并携带数据
 */
void main() {
  runApp(new MaterialApp(
    title: "Flutter",
    home: new FirstScreen(todos),
  ));
}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

/**
 * 第一个页面
 */
class FirstScreen extends StatelessWidget {
  final List<Todo> todos;

  FirstScreen(this.todos);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("列表"),
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return new ListTile(
                title: new Text(todos[index].title),
                //item的点击事件 跳转到新的页面并携带一个Todo对象 传参就是通过构造函数了
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new DetailScreen(todo: todos[index])));
                },
              );
            }),
      ),
    );
  }
}

/**
 * 第二个页面
 */
class DetailScreen extends StatelessWidget {
  final Todo todo;

  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("详情页面${todo.title}"),
      ),
      body: new Center(
        child: new GestureDetector(
          child: new Text("第${todo.description}条"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}