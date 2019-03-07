import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/GSYStyle.dart';
import 'package:flutter_weixin/views/home_page.dart';

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
  String appBarTitle = tabData[0]['text'];
  static List tabData = [
    {'text': '微信', 'icon': new Icon(GSYICons.HOME)},
    {'text': '通讯录', 'icon': new Icon(GSYICons.ADDRESS_BOOK)},
    {'text': '发现', 'icon': new Icon(GSYICons.FOUND)},
    {'text': '我', 'icon': new Icon(GSYICons.WO)}
  ];
  List<Widget> pages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    pages = [
      HomePage(),
      Container(
        color: Colors.green,
      ),
      Container(
        color: Colors.orange,
      ),
      Container(
        color: Colors.pinkAccent,
      )
    ];
  }

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
        appBarTitle = tabData[index]['text'];
        _pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
      });
    }
  }
  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          content: new Text('确定要退出应用?'),
          actions: <Widget>[
            new FlatButton(onPressed: () => Navigator.of(context).pop(false), child: new Text('取消', style: TextStyle(color: Colors.black54),)),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text('确定', style: TextStyle(color: Colors.black54)))
          ],
        ));
  }
  _buildPopupMenuItem(IconData icon, String title) {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child:       Scaffold(
            appBar: AppBar(
              title: Text(appBarTitle),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                Container(width: 14.0),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuItem<String>>[
                      PopupMenuItem(
                        child: _buildPopupMenuItem(GSYICons.HOME_CHECKED, '发起群聊'),
                        value: "1",
                      ),
                      PopupMenuItem(
                        child: _buildPopupMenuItem(
                            GSYICons.ADDRESS_BOOK_CHECKED, '添加朋友'),
                        value: "2",
                      )
                    ];
                  },
                  icon: Icon(Icons.add_circle_outline),
                  onSelected: (String selected) {},
                ),
              ],
            ),
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
                    icon: Icon(GSYICons.HOME),
                    activeIcon: Icon(GSYICons.HOME_CHECKED)),
                BottomNavigationBarItem(
                    title: Text("通讯录"),
                    icon: Icon(GSYICons.ADDRESS_BOOK),
                    activeIcon: Icon(GSYICons.ADDRESS_BOOK_CHECKED)),
                BottomNavigationBarItem(
                    title: Text("发现"),
                    icon: Icon(GSYICons.FOUND),
                    activeIcon: Icon(GSYICons.FOUND_CHECKED)),
                BottomNavigationBarItem(
                    title: Text("我"),
                    icon: Icon(GSYICons.WO),
                    activeIcon: Icon(GSYICons.WO_CHECKED)),
              ],
            )),
        onWillPop: () {
          return _dialogExitApp(context);
        });
  }
}