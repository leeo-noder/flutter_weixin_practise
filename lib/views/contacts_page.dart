import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/contact.dart' show preContact, mockContact, Contact;
import 'package:flutter_weixin/components/UserIconWidget.dart';
import 'package:flutter_weixin/model/conversation.dart'
    show
    ConversationControlModel,
    Manager;

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ConversationControlModel _conversationControlModel = new ConversationControlModel();
  Manager manager = new Manager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(manager.getState());
    if (manager.getState()) {
      mockContact.clear();
      _conversationControlModel.sql.getAll().then( (result){
        manager.setSate(false);
        setState(() {
          print(result);
          result.forEach((item) {
            mockContact.add(Contact(avatar: item['avatar'], name: item['name'], isNetwork: true));
          });
          mockContact.insertAll(0, preContact);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _ContactItem(
            contact: mockContact[index],
          );
        },
        itemCount: mockContact.length,
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
        width: 35.0,
        height: 35.0,
        image: contact.avatar,
        isNetwork: contact.isNetwork,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    return Container(
      height: 58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          userImage,
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffd9d9d9), width: .5))),
            padding: EdgeInsets.only(top: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contact.name,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
