import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/conversation.dart' show Conversation;
import 'package:flutter_weixin/components/UserIconWidget.dart';

class HomeChatPage extends StatefulWidget {
  final Conversation conversation;

  HomeChatPage({Key key, this.conversation}) : super(key: key);

  @override
  _HomeChatPageState createState() => _HomeChatPageState(conversation);
}

class _HomeChatPageState extends State<HomeChatPage> {
  Conversation _conversation;

  _HomeChatPageState(this._conversation);

  List<ChatItem> items = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items
      ..add(new ChatItem('你好', 1))
      ..add(new ChatItem('你好', 1))
      ..add(new ChatItem('你好', 0));
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener(() {
      print('input ${controller.text}');
    });
    return new Scaffold(
      appBar: AppBar(
        title: Text(_conversation.title),
        elevation: 0.0,
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ChatContentView(
                    chatItem: items[index], conversation: _conversation);
              },
              itemCount: items.length,
            )),
            Container(
              padding:
                  EdgeInsets.only(top: 5.0, bottom: 5.0, right: 8.0, left: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        color: Colors.white),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration.collapsed(hintText: null),
                      autocorrect: true,
                      //是否自动更正
                      autofocus: false,
                      //是否自动对焦
                      textAlign: TextAlign.left,
                      //文本对齐方式
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      //输入文本的样式
                      onChanged: (text) {
                        //内容改变的回调
                        print('change $text');
                      },
                      onSubmitted: (text) {
                        //内容提交(按回车)的回调
                        print('submit $text');
                      },
                      enabled: true, //是否禁用
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatContentView extends StatelessWidget {
  final ChatItem chatItem;
  final Conversation conversation;

  ChatContentView({Key key, this.chatItem, this.conversation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: EdgeInsets.only(
            top: 0.0,
            right: (chatItem.type == 0 ? 0.0 : 5.0),
            left: (chatItem.type == 0 ? 5.0 : 0.0)),
        width: 35.0,
        height: 35.0,
        image: chatItem.type == 0
            ? 'static/images/default_nor_avatar.png'
            : conversation.avatar,
        isNetwork: (chatItem.type == 1 && conversation.isNetwork),
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    return chatItem.type == 0
        ? Container(
            margin: EdgeInsets.only(top: 8.0, left: 8.0),
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 5.0),
                  decoration: BoxDecoration(
                      //image: DecorationImage(image: AssetImage('static/images/chat_bg.png'), fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      color: Color.fromRGBO(145, 238, 111, 1),
                      gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(145, 238, 11, 1),
                            Color.fromRGBO(145, 238, 11, 1)
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft)),
                  child: Text(
                    chatItem.msg,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                )),
                userImage
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 8.0, right: 8.0),
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                userImage,
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      color: Colors.white),
                  child: Text(
                    chatItem.msg,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                )),
              ],
            ),
          );
  }
}

class ChatItem {
  var msg;
  int type;

  ChatItem(this.msg, this.type);

  String getMsg() {
    return msg;
  }
}
