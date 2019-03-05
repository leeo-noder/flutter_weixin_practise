import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/conversation.dart'
    show Conversation, mockConversation;
import 'package:flutter_weixin/utils/net_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _ConversationItem(conversation: mockConversation[index]);
      },
      itemCount: mockConversation.length,
    );
  }
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIndexListData();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  getIndexListData([Map<String, dynamic> params]) async {
    try {
      var response = await NetUtils.get('https://randomuser.me/api/?results=15');
      setState(() {
        for (int i = 0; i < response['results'].length; i++) {
          mockConversation.add(Conversation.fromJson(response['results'][i]));
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key key, this.conversation})
      : assert(conversation != null),
        super(key: key);
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffd9d9d9)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Image.network(
              conversation.avatar,
              width: 60.0,
              height: 60.0,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  conversation.title,
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  conversation.describtion,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                )
              ],
            ),
          )),
          Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    conversation.createAt,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
