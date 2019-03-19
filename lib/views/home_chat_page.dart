import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/conversation.dart' show Conversation;
import 'package:flutter_weixin/components/UserIconWidget.dart';

class HomeChatPage extends StatefulWidget {
  final Conversation conversation;

  HomeChatPage({Key key, this.conversation}) : super(key: key);

  @override
  _HomeChatPageState createState() => _HomeChatPageState(conversation);
}

class _HomeChatPageState extends State<HomeChatPage>
    with TickerProviderStateMixin {
  Conversation _conversation;

  _HomeChatPageState(this._conversation);

  List<ChatItem> items = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChatItem message = new ChatItem(
        'Hello, nice to meet you',
        1,
        new AnimationController(
            vsync: this, duration: Duration(milliseconds: 500)));
    items.add(message);
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatItem message in items)
      message.animationController.dispose(); //  释放动效
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    //定义发送文本事件的处理函数
    void _handleSubmitted(String text) {
      if (controller.text.length > 0) {
        controller.clear(); //清空输入框
        ChatItem message = new ChatItem(
            text,
            0,
            new AnimationController(
                vsync: this, duration: Duration(milliseconds: 500)));
        //状态变更，向聊天记录中插入新记录
        setState(() {
          items.add(message);
        });
        message.animationController.forward();
      }
    }

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
            Divider(height: 1.0, color: Color(0xFFF7F8F8),),
            Container(
              padding:
                  EdgeInsets.only(top: 5.0, bottom: 15.0, right: 8.0, left: 15.0),
              color: Color(0xFFF7F7F7),
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
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.green,
                      onChanged: (text) {
                        //内容改变的回调
                        print('change=================== $text');
                      },
                      onSubmitted: _handleSubmitted,
                      enabled: true, //是否禁用
                    ),
                  )),
                  new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 4.0),
                    child: new IconButton(
                        //发送按钮
                        icon: new Icon(Icons.send), //发送按钮图标
                        onPressed: () => _handleSubmitted(
                            controller.text)), //触发发送消息事件执行的函数_handleSubmitted
                  )
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
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: this.chatItem.animationController, curve: Curves.easeOutCirc),
      axisAlignment: 0.0,
      child: chatItem.type == 0
          ? Container(
              margin: EdgeInsets.only(top: 8.0, left: 8.0),
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    // Column被Expanded包裹起来，使其内部文本可自动换行
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          //image: DecorationImage(image: AssetImage('static/images/chat_bg.png'), fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Color(0xFF9EEA6A),
                        ),
                        child: Text(
                          chatItem.msg,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      )
                    ],
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
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
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
                      )
                    ],
                  )),
                ],
              ),
            ),
    );
  }
}

class ChatItem {
  var msg;
  int type;
  AnimationController animationController;

  ChatItem(this.msg, this.type, this.animationController);

  String getMsg() {
    return msg;
  }
}
