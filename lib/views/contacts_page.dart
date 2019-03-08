import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/contact.dart'
    show preContact, Contact;
import 'package:flutter_weixin/components/UserIconWidget.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return _ContactItem(
          contact: preContact[index],
        );
      },
      itemCount: preContact.length,),
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
        padding: const EdgeInsets.only(top: 0.0, right: 8.0, left: 10.0),
        width: 35.0,
        height: 35.0,
        image: contact.avatar,
        isNetwork: contact.isNetwork,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    return Container(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          userImage,
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xffd9d9d9),width: .5))),
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contact.name,
                      style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
