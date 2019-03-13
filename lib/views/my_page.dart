import 'package:flutter/material.dart';
import 'package:flutter_weixin/components/UserIconWidget.dart';
import 'package:flutter_weixin/common/style/Style.dart' show ICons;

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(top: 28.0, right: 18.0, left: 25.0),
        width: 55.0,
        height: 55.0,
        image: 'static/images/default_nor_avatar.png',
        isNetwork: false,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    Widget buildRow(icon, title, isEnd) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new UserIconWidget(
              padding: const EdgeInsets.only(top: 0.0, right: 14.0, left: 14.0),
              width: 22.0,
              height: 22.0,
              image: icon,
              isNetwork: false,
              onPressed: () {
                // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
              }),
          Expanded(
            child: Container(
              decoration: !isEnd ? BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xffd9d9d9), width: .3))): null,
              padding: EdgeInsets.only(top: 16.0),
              child: Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffd9d9d9), width: .3))),
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10.0),
            child: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          )
        ],
      );
    }

    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              height: 180.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  userImage,
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 83.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'leeo',
                          style: TextStyle(
                              fontSize: 22.5, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 2.0,
                        ),
                        Text(
                          '微信号：zwleee',
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        )
                      ],
                    ),
                  )),
                  Row(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(top: 65.0, bottom: 15.0, right: 10.0),
                        child: Icon(
                          ICons.QR,
                          color: Colors.grey,
                          size: 15.0,
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.only(top: 65.0, bottom: 15.0, right: 10.0),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  color: Color(0xffEDEDED),
                  height: 10.0,
                ),
                buildRow('static/images/me_pay.png', '支付', true),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    color: Color(0xffEDEDED),
                    height: 10.0,
                  ),
                  buildRow('static/images/me_college.png', '收藏', false),
                  buildRow('static/images/me_gallary.png', '相册', false),
                  buildRow('static/images/me_wallet.png', '卡包', false),
                  buildRow('static/images/me_face.png', '表情', true),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  color: Color(0xffEDEDED),
                  height: 10.0,
                ),
                buildRow('static/images/me_setting.png', '设置', true),
              ],
            ),
          ],
        )
      ],
    );
  }
}
