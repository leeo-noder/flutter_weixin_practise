import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/contact.dart'
    show preContact, mockContact, Contact;
import 'package:flutter_weixin/components/UserIconWidget.dart';
import 'package:flutter_weixin/model/conversation.dart'
    show ConversationControlModel, Manager;

class ContactsPage extends StatefulWidget {
  Color _indexBarBg = Colors.transparent;

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

const INDEX_BAR_WORDS = [
  "↑",
  "☆",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];

class _ContactsPageState extends State<ContactsPage> {
  ConversationControlModel _conversationControlModel =
      new ConversationControlModel();
  Manager manager = new Manager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(manager.getState());
    if (manager.getState()) {
      mockContact.clear();
      _conversationControlModel.sql.getAll().then((result) {
        manager.setSate(false);
        List<Contact> arr = [];
        result.forEach((item) {
          arr.add(Contact(
              avatar: item['avatar'],
              name: item['name'],
              nameIndex: item['name'].toString().substring(0, 1).toUpperCase(),
              isNetwork: true));
        });
        arr.sort((Contact a, Contact b) => a.nameIndex.compareTo(b.nameIndex));
        arr.insertAll(0, preContact);
        setState(() {
          mockContact.addAll(arr);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
      return Expanded(child: Text(word));
    }).toList();
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            bool isNameIndex = true;
            if (index >= preContact.length &&
                mockContact[index].nameIndex ==
                    mockContact[index - 1].nameIndex) {
              isNameIndex = false;
            }
            return _ContactItem(
                contact: mockContact[index], isNameIndex: isNameIndex);
          },
          itemCount: mockContact.length,
        ),
        Positioned(
            width: 24.0,
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Container(
              color: widget._indexBarBg,
              child: GestureDetector(
                onVerticalDragDown: (DragDownDetails details) {
                  setState(() {
                    widget._indexBarBg = Colors.black26;
                  });
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  print('end');
                  setState(() {
                    widget._indexBarBg = Colors.transparent;
                  });
                },
                onVerticalDragCancel: () {
                  print('cancel');
                  setState(() {
                    widget._indexBarBg = Colors.transparent;
                  });
                },
              child: Column(
                children: _letters,
              ),
              ),
            ))
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({Key key, this.contact, this.isNameIndex})
      : assert(contact != null),
        super(key: key);
  final Contact contact;
  final bool isNameIndex;

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
    Widget itemRow = Row(
      children: <Widget>[
        userImage,
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffd9d9d9), width: .5))),
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              // alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 12.0),
              child: Text(
                contact.name,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
    Widget contactItem = contact.isNetwork
        ? (isNameIndex
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 12.0, bottom: 0.0),
                    color: Color(0xffE7E8EA),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                    child: Text(contact.nameIndex),
                  ),
                  itemRow
                ],
              )
            : itemRow)
        : itemRow;

    return Container(
      height: contact.isNetwork && isNameIndex ? 86 : 56,
      child: contactItem,
    );
  }
}
