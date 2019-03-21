import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/Style.dart' show Style;
import 'package:flutter_weixin/model/contact.dart';
import 'package:flutter_weixin/components/UserIconWidget.dart';
import 'package:flutter_weixin/model/conversation.dart'
    show ConversationControlModel;

class ContactsNewFriend extends StatefulWidget {
  @override
  _ContactsNewFriendState createState() => _ContactsNewFriendState();
}

class _ContactsNewFriendState extends State<ContactsNewFriend> {
  ConversationControlModel _conversationControlModel =
      new ConversationControlModel();
  List<Contact> mockContacts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _conversationControlModel.sql.getAll().then((result) {
        List<Contact> arr = [];
        result.forEach((item) {
            arr.add(Contact(
                avatar: item['avatar'],
                name: item['name'],
                nameIndex: item['name'].toString().substring(0, 1).toUpperCase(),
                isNetwork: true));
        });
        arr.sort((Contact a, Contact b) => a.nameIndex.compareTo(b.nameIndex));
        setState(() {
          mockContacts.addAll(arr);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新的朋友',
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        elevation: 0.0,
        actions: <Widget>[
          RawMaterialButton(
              child: Text(
                '添加朋友',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              onPressed: () {})
        ],
      ),
      body: Container(
        color: Color(Style.primaryValue),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              color: Colors.white,
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5.0),
                    margin: EdgeInsets.only(left: 10.0, right: 5.0),
                    height: MediaQuery.of(context).padding.top * 1.3,
                    child: Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                  ),
                  Text(
                    '微信号/QQ号/手机号',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12.0, bottom: 0.0),
              margin: EdgeInsets.only(top: 10.0),
              color: Color(0xffEDEDED),
              height: 30.0,
              alignment: Alignment.centerLeft,
              child: Text(
                '新的朋友',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _ContactItem(contact: mockContacts[index]);
                  },
                  itemCount: mockContacts.length,
                )),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({Key key, this.contact})
      : assert(contact != null),
        super(key: key);
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(top: 0.0, right: 12.0, left: 12.0),
        width: 40.0,
        height: 40.0,
        image: contact.avatar,
        isNetwork: contact.isNetwork,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    Widget itemRow = Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          userImage,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xffd9d9d9), width: .3))),
              padding: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      contact.name,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 30.0,
                    margin: EdgeInsets.only(right: 10.0,bottom: 8.0),
                    child: RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      color: Colors.green,
                      elevation: 0.0,
                      child: Text('接受'),
                    ),
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );

    return Container(
      height: 64.0,
      child: itemRow,
    );
  }
}
