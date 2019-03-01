import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/GSYStyle.dart';
import 'package:flutter_weixin/model/widget.dart';
import 'package:flutter_weixin/routers/application.dart';

class Bar extends StatefulWidget {
  Bar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BarState();
  }
}

class _BarState extends State<Bar> with SingleTickerProviderStateMixin {
  WidgetControlModel widgetControlModel = new WidgetControlModel();
  TabController tabController;
  String appBarTitle = tabData[0]['text'];
  static List tabData = [
    {'text': '微信', 'icon': new Icon(GSYICons.HOME)},
    {'text': '通讯录', 'icon': new Icon(GSYICons.ADDRESS_BOOK)},
    {'text': '发现', 'icon': new Icon(GSYICons.FOUND)},
    {'text': '我', 'icon': new Icon(GSYICons.WO)}
  ];
  List<Widget> myTabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('xxxx');
    tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = tabController;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[tabController.index]['text'];
      });
    }
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
    return Scaffold(
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
        body: Container(
          child: ListView(
            children: <Widget>[],
          ),
          color: Color(GSYColors.primaryLightValue),
        ),
        bottomNavigationBar: Material(
          color: Color(GSYColors.primaryValue),
          child: SafeArea(
              child: Container(
            child: TabBar(
                controller: tabController,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: myTabs),
          )),
        ));
  }
}
