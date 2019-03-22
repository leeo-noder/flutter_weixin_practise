import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/contact.dart' show Contact;
import 'package:flutter_weixin/model/conversation.dart' show Conversation;
import 'package:flutter_weixin/common/style/Style.dart' show Style;
import 'package:flutter_weixin/components/UserIconWidget.dart';
import 'package:flutter_weixin/views/home_chat_page.dart';

class ContactsDetail extends StatefulWidget {
  final Contact contact;

  ContactsDetail({Key key, this.contact})
      : assert(contact != null),
        super(key: key);

  @override
  _ContactsDetailState createState() => _ContactsDetailState(this.contact);
}

class _ContactsDetailState extends State<ContactsDetail> {
  Contact _contact;
  Conversation _conversation;
  _ContactsDetailState(this._contact);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _conversation = new Conversation(avatar: this._contact.avatar, title: this._contact.name, createAt: '', isNetwork: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(top: 0.0, right: 18.0, left: 15.0),
        width: 55.0,
        height: 55.0,
        image: _contact.avatar,
        isNetwork: true,
        onPressed: () {});
    Widget buildMainRow() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          userImage,
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _contact.name,
                  style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 2.0,
                ),
                Text(
                  '微信号：xxx',
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey, fontSize: 13.0),
                ),
                Container(
                  height: 2.0,
                ),
                Text(
                  '地区：xxxxxxx',
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey, fontSize: 13.0),
                )
              ],
            ),
          )),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 0.0, bottom: 15.0, right: 15.0),
                child: Icon(
                  Icons.camera,
                  color: Colors.grey,
                  size: 18.0,
                ),
              )
            ],
          )
        ],
      );
    }

    Widget buildRow(title, isEnd) {
      return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    child: title,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              onPressed: null)
        ],
      ),
      body: Container(
          color: Color(Style.primaryValue),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffd9d9d9), width: .3))),
                padding: EdgeInsets.only(bottom: 28.0),
                child: buildMainRow(),
              ),
              Container(
                color: Colors.white,
                child: buildRow(
                    Text(
                      '设置备注和标签',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                    true),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffd9d9d9), width: .3))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      color: Color(0xffEDEDED),
                      height: 10.0,
                    ),
                    buildRow(
                        Text(
                          '朋友圈',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        false),
                    buildRow(
                        Text(
                          '更多信息',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        true),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffd9d9d9), width: .3))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Color(0xffEDEDED),
                      height: 10.0,
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return new HomeChatPage(conversation: _conversation);
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffd9d9d9), width: .3))),
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Text(
                          '发消息',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Text(
                        '音视频通话',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
