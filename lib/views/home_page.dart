import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/conversation.dart'
    show Conversation, mockConversation, preConversation;
import 'package:flutter_weixin/utils/net_utils.dart';
import 'package:flutter_weixin/components/PullLoadWidget.dart';
import 'package:flutter_weixin/components/ListState.dart';
import 'package:flutter_weixin/components/UserIconWidget.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        AutomaticKeepAliveClientMixin<HomePage>,
        ListState<HomePage>,
        WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return PullLoadWidget(
      pullLoadWidgetControl,
      (BuildContext context, int index) => _ConversationItem(
          conversation: pullLoadWidgetControl.dataList[index]),
      handleRefresh,
      onLoadMore,
      refreshKey: refreshIndicatorKey,
    );
  }

  @override
  bool get isRefreshFirst => false;

  @override
  bool get wantKeepAlive => true;

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    mockConversation.clear();
    mockConversation.addAll(preConversation);
    await getIndexListData(page);
    setState(() {
      pullLoadWidgetControl.needLoadMore =
          (mockConversation != null && mockConversation.length == 13);
    });
    isLoading = false;
    return null;
  }

  // 紧跟在initState之后调用
  @override
  void didChangeDependencies() {
    mockConversation.addAll(preConversation);
    pullLoadWidgetControl.dataList = mockConversation;
    getIndexListData(1);
    setState(() => {pullLoadWidgetControl.needLoadMore = true});
    super.didChangeDependencies();
  }

  @override
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    await getIndexListData(page);
    setState(() {
      pullLoadWidgetControl.needLoadMore =
          (mockConversation != null && mockConversation.length < 23);
    });
    isLoading = false;
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getIndexListData(1);
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  getIndexListData(page) async {
    try {
      var response =
          await NetUtils.get('https://randomuser.me/api/?results=10');
      setState(() {
        for (int i = 0; i < response['results'].length; i++) {
          
          response['results'][i]['unReadMsgCount'] = i == Random().nextInt(10) ? Random().nextInt(20) : 0;
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
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(top: 0.0, right: 8.0, left: 10.0),
        width: 50.0,
        height: 50.0,
        image: conversation.avatar,
        isNetwork: conversation.isNetwork,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    // 维度消息角标 bg = 0xffff3e3e
    Widget unReadMsgCountText;
    if (conversation.unReadMsgCount > 0) {
      unReadMsgCountText = Positioned(
        child: Container(
          width: 18.0,
          height: 18.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20 / 2.0),
              color: Color(0xffff3e3e)),
          child: Text(
            conversation.unReadMsgCount.toString(),
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff)),
          ),
        ),
        right: 0.0,
        top: -5.0,
      );
    } else if (conversation.displayDot) {
      unReadMsgCountText = Positioned(
        child: Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20 / 2.0),
              color: Color(0xffff3e3e)),
        ),
        right: 2.0,
        top: -5.0,
      );
    } else {
      unReadMsgCountText = Positioned(
        child: Container(),
        right: 0.0,
        top: -5.0,
      );
    }

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffd9d9d9)))),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              userImage,
              unReadMsgCountText,
            ],
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  conversation.title,
                  style: TextStyle(fontSize: 17.5),
                ),
                Container(
                  height: 2.0,
                ),
                Text(
                  conversation.describtion,
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey, fontSize: 13.0),
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
