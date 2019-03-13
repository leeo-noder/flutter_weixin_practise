import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/Style.dart';
import 'package:flutter_weixin/views/home_page.dart';
import 'package:flutter_weixin/views/contacts_page.dart';
import 'package:flutter_weixin/views/find_page.dart';
import 'package:flutter_weixin/views/my_page.dart';
import 'package:flutter_weixin/common/net/Code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:flutter_weixin/common/event/ThemeChangeEvent.dart'
    show ThemeChangeEvent, ThemeChangeHandle;

class Bar extends StatefulWidget {
  Bar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BarState();
  }
}

class _BarState extends State<Bar> {
  PageController _pageController;
  static String appBarTitle = tabData[0]['text'];
  static List tabData = [
    {'text': '微信', 'icon': new Icon(ICons.HOME)},
    {'text': '通讯录', 'icon': new Icon(ICons.ADDRESS_BOOK)},
    {'text': '发现', 'icon': new Icon(ICons.FOUND)},
    {'text': '我', 'icon': new Icon(ICons.WO)}
  ];
  List<Widget> pages = [];
  int _currentIndex = 0;
  StreamSubscription stream;
  static Color themeDef = Color(0xffEDEDED);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    pages = [HomePage(), ContactsPage(), FindPage(), MyPage()];
    stream = ThemeChangeHandle.eventBus
        .on<ThemeChangeEvent>()
        .listen((ThemeChangeEvent onData) {
      print('监听改变主题事件=========');
      this.changeTheme(onData);
    });
  }

  /**
   * 刷新主题样式
   */
  void changeTheme(ThemeChangeEvent onData) {
    setState(() {
      print(onData);
      themeDef = Color(onData.color);
    });
  }

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
        appBarTitle = tabData[index]['text'];
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text('确定要退出应用?'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text(
                      '取消',
                      style: TextStyle(color: Colors.black54),
                    )),
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child:
                        new Text('确定', style: TextStyle(color: Colors.black54)))
              ],
            ));
  }

  static _buildPopupMenuItem(IconData icon, String title) {
    return Row(children: <Widget>[
      Icon(
        icon,
        color: Color(0xFFFFFFFF),
      ),
      Container(width: 12.0),
      Text(
        title,
        style: TextStyle(color: Color(0xFFFFFFFF)),
      )
    ]);
  }

  Widget defaultAppBar = AppBar(
    backgroundColor: themeDef,
    title: Text(appBarTitle),
    elevation: 0.0,
    actions: <Widget>[
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      Container(width: 14.0),
      PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem<String>>[
            PopupMenuItem(
              child: _buildPopupMenuItem(ICons.HOME_CHECKED, '发起群聊'),
              value: "1",
            ),
            PopupMenuItem(
              child: _buildPopupMenuItem(ICons.ADDRESS_BOOK_CHECKED, '添加朋友'),
              value: "2",
            )
          ];
        },
        icon: Icon(Icons.add_circle_outline),
        onSelected: (String selected) {},
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
            appBar: _currentIndex != 3 ? defaultAppBar : null,
            body: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return pages[index];
              },
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  appBarTitle = tabData[index]['text'];
                  _currentIndex = index;
                  if (index == 3) {
                    ThemeChangeHandle.themeChangeHandle(0xffFFFFFF);
                  } else {
                    ThemeChangeHandle.themeChangeHandle(0xffEDEDED);
                  }
                });
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // BottomNavigationBarType 中定义的类型，有 fixed 和 shifting 两种类型
              iconSize: 24.0,
              // BottomNavigationBarItem 中 icon 的大小
              currentIndex: _currentIndex,
              // 当前所高亮的按钮index
              onTap: _onItemTapped,
              // 点击里面的按钮的回调函数，参数为当前点击的按钮 index
              fixedColor: Colors.green,
              // 如果 type 类型为 fixed，则通过 fixedColor 设置选中 item 的颜色
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    title: Text("微信"),
                    icon: Icon(ICons.HOME),
                    activeIcon: Icon(ICons.HOME_CHECKED)),
                BottomNavigationBarItem(
                    title: Text("通讯录"),
                    icon: Icon(ICons.ADDRESS_BOOK),
                    activeIcon: Icon(ICons.ADDRESS_BOOK_CHECKED)),
                BottomNavigationBarItem(
                    title: Text("发现"),
                    icon: Icon(ICons.FOUND),
                    activeIcon: Icon(ICons.FOUND_CHECKED)),
                BottomNavigationBarItem(
                    title: Text("我"),
                    icon: Icon(ICons.WO),
                    activeIcon: Icon(ICons.WO_CHECKED)),
              ],
            )),
        onWillPop: () {
          return _dialogExitApp(context);
        });
  }

/*  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: '网络错误');
        break;
      case 401:
        Fluttertoast.showToast(msg: '[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]');
        break;
      case 403:
        Fluttertoast.showToast(msg: '403权限错误');
        break;
      case 404:
        Fluttertoast.showToast(msg: '404错误');
        break;
      case Code.NETWORK_TIMEOUT:
      //超时
        Fluttertoast.showToast(msg: '请求超时');
        break;
      default:
        Fluttertoast.showToast(msg: '其他异常');
        break;
    }
  }*/
}
