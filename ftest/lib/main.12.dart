import 'package:flutter/material.dart';

/**
 * 用户输入交互
 */
class Product {
  final String name;

  //常量构造函数 其目的是让类生成的对象永远不会改变 变成编译时常量 类似于java的final
  const Product({this.name});
}

/**
 * 不知道我理解的对不对 这个类似于Android的接口回调 至少在本文中是这个思路
 */
typedef void CartChangedCallback(Product prodect, bool icCart);

/**
 * 该ShoppingListItem是无状态的widget
 * 该类的作用就是构建listview的item
 */
class ShoppingListItem extends StatelessWidget {
  /**
   * 将构造中接收的值存储在final成员变量中
   */
  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: new ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("ShoppingListItem-build");
    print(product.name);
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      //这个之前写material widget时讲过 标题之前显示的widget 这里就显示了一个圆形
      leading: new CircleAvatar(
        //颜色是根据inCart来定义的
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]), //显示在圆形图片上的文本首字符
      ),
      title: new Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

/**
 * _ShoppingListState继承自StatefulWidget
 *  相当于一个临时对象 用于构建当前状态下的应用程序
 */
class ShoppingList extends StatefulWidget {
  final List<Product> products;

  @override
  State<StatefulWidget> createState() {
    print("createState");
    return new _ShoppingListState();
  }

  ShoppingList({Key key, this.products});
}

/**
 *_ShoppingListState对象继承自state 它具备一个特性就是在两次build之间可以保持不变 允许它们记录住状态
 */
class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  /**
   * 可以完成一些仅需要执行一次的工作 比如初始化操作
   */
  @override
  void initState() {
    print("initState");
    super.initState();
  }

  /**
   * 当一个状态对象不再需要时调用 可以做recycle
   */
  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  void _handlerCartChanged(Product product, bool incart) {
    //setState标记为dirty 是为了通知框架该对象的内部状态已发生改变 setState调用后会触发build
    setState(() {
      print("setState");
      if (incart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("应用商城"),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handlerCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: "应用商城",
    home: new ShoppingList(
      products: <Product>[
        new Product(name: "王者农药"),
        new Product(name: "吃鸡战场"),
        new Product(name: "全军吃鸡"),
      ],
    ),
  ));
}

/**
  .首先在runApp中我们new了ShoppingList,并在构造中传入一个List这个很简单
  .ShoppingList继承自StatefulWidget,也就是说他是一个有状态的widget
  在ShoppingList的createState函数中我们创建了_ShoppingListState,他继承自State，State可以记录住状态ps:现在不太了解这个State没关系,后面使用非常多
  在State中他需要返回一个widget，这里我们就从Body开始看起
  在Body中我们创建一个ListView,注意那个widget就是ShoppingList
  childRen这里,不太好理解
  首先我们通过ShoppingList.products,这个products就是我们的List.map将触发多次调用(Product product) 函数,这里我们每次调用就创建一个ShoppingListItem
  ShoppingListItem的实现是ListTitl，这里就比较明确了,这个List中我们通过构造传入了三个元素
  这里也将构建三个ListTitl，这三个参数我们简单了解一下, 
  第一个product用来获取名称name
  第二个inCart,通过判断是否在购物车(容器中)来决定显示item颜色
  第三个简单说就是item的点击事件,为什么在这里实现？因为我们要在用户点击后调用setState来重新build ListView,也就是说build会多次构建,这里不考虑性能问题,你是不是想到了item复用？hia hia hia(一种笑声 很难模仿)
  在_handlerCartChanged函数中我们只要点击就判断容器内有没有该item来决定是否添加和删除,inCart就是通过判断item是否在这个容器中来决定显示什么颜色,
  清晰了吗？
  补充一下_ShoppingListState只会创建一次,但build会构建多次 所以使用变量时注意应该放在什么位置
 */