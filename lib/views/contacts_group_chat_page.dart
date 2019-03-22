import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/Style.dart' show Style;

class ContactsGroupChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('群聊'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: Container(
        color: Color(Style.primaryValue),
        child: Center(
          child: Text('暂无群聊', style: TextStyle(color: Colors.grey,fontSize: 18.0),),
        ),
      ),
    );
  }
}
