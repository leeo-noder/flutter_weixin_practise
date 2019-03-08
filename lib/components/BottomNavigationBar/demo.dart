
import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/Style.dart';
/*
* BottomNavigationBar 默认的实例
* */
class BottomNavigationBarFullDefault extends StatefulWidget {
  const BottomNavigationBarFullDefault() : super();
  @override
  State<StatefulWidget> createState() => _BottomNavigationBarFullDefault();
}

/*
* BottomNavigationBar 默认的实例,有状态
* */
class _BottomNavigationBarFullDefault extends State {
   int _currentIndex = 1;

  void _onItemTapped(int index) {
    if(mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // BottomNavigationBarType 中定义的类型，有 fixed 和 shifting 两种类型
      iconSize: 24.0, // BottomNavigationBarItem 中 icon 的大小
      currentIndex: _currentIndex, // 当前所高亮的按钮index
      onTap: _onItemTapped, // 点击里面的按钮的回调函数，参数为当前点击的按钮 index
      fixedColor: Colors.green, // 如果 type 类型为 fixed，则通过 fixedColor 设置选中 item 的颜色
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
            title:  Text("微信"), icon:  Icon(ICons.HOME), activeIcon: Icon(ICons.HOME_CHECKED)),
        BottomNavigationBarItem(
            title:  Text("通讯录"), icon:  Icon(ICons.ADDRESS_BOOK), activeIcon: Icon(ICons.ADDRESS_BOOK_CHECKED)),
        BottomNavigationBarItem(
            title:  Text("发现"), icon:  Icon(ICons.FOUND), activeIcon: Icon(ICons.FOUND_CHECKED)),
        BottomNavigationBarItem(
            title:  Text("我"), icon:  Icon(ICons.WO), activeIcon: Icon(ICons.WO_CHECKED)),
      ],
    );
  }
}

