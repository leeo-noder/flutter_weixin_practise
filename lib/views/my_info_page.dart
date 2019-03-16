import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/Style.dart' show ICons;
import 'package:flutter_weixin/components/UserIconWidget.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    Widget buildRow(child, title, isEnd) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: !isEnd
                  ? BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xffd9d9d9), width: .3)))
                  : null,
              padding: EdgeInsets.only(top: 16.0),
              margin: EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 15.0, right: 5.0),
                          child: child,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 15.0, right: 10.0),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(right: 0.0),
        width: 55.0,
        height: 55.0,
        image: 'static/images/default_nor_avatar.png',
        isNetwork: false,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    return new Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildRow(userImage, '头像', false),
              buildRow(Text('leeo', style: TextStyle(color: Colors.grey, fontSize: 18.0),), '昵称', false),
              buildRow(Text('zwleee', style: TextStyle(color: Colors.grey, fontSize: 18.0),), '微信号', false),
              buildRow(
                  Icon(
                    ICons.QR,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                  '二维码名片',
                  false),
              buildRow(Text(''), '更多', true),
            ],
          ),
        ),
      ),
    );
  }
}
