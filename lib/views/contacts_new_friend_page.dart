import 'package:flutter/material.dart';

class ContactsNewFriend extends StatefulWidget {
  @override
  _ContactsNewFriendState createState() => _ContactsNewFriendState();
}

class _ContactsNewFriendState extends State<ContactsNewFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新的朋友'),
        elevation: 0.0,
        actions: <Widget>[
          RawMaterialButton(
            child: Text('添加朋友'),
              onPressed: (){

          })
        ],
      ),
    );
  }
}
