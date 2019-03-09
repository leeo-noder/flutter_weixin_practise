import 'package:flutter/material.dart';
import 'package:flutter_weixin/utils/util.dart';
import 'package:flutter_weixin/utils/sql.dart';

class Conversation {
  const Conversation(
      {@required this.avatar,
      @required this.title,
      @required this.createAt,
      this.isMute: false,
      this.titleColor: 0xff353535,
      this.describtion,
      this.unReadMsgCount: 0,
      this.displayDot: false,
      this.isNetwork: false})
      : assert(avatar != null),
        assert(title != null),
        assert(createAt != null);
  final String avatar;
  final String title;
  final String describtion;
  final String createAt;
  final bool isMute;
  final int titleColor;
  final int unReadMsgCount;
  final bool displayDot;
  final bool isNetwork;

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
        avatar: json['picture']['thumbnail'],
        createAt: Util.getTimeDuration(json['registered']['date']),
        title: json['name']['first'] + ' ' + json['name']['last'],
        describtion: json['location']['timezone']['description'],
        unReadMsgCount: json['unReadMsgCount'],
        isNetwork: true);
  }
}

class ConversationControlModel {

  final String table = 'conversation';
  Sql sql;

  ConversationControlModel() {
    sql = Sql.setTable(table);
  }

  Future clear() {
   return sql.clearTable(table);
  }
  Future insert(Conversation conversation) {
    return sql.insert({'avatar': conversation.avatar, 'name': conversation.title});
  }

  Future<List<Conversation>> getAllConversation() async {
    List list = await sql.getByCondition();
    List<Conversation> resultList = [];
    list.forEach((item){
      resultList.add(Conversation.fromJson(item));
    });
    return resultList;
  }
}

List<Conversation> mockConversation = [];
List<Conversation> preConversation = [
  const Conversation(
      avatar: '',
      title: '',
      createAt: '',
      describtion: ''),
  const Conversation(
      avatar: 'static/images/zushou.jpg',
      title: '文件传输助手',
      createAt: '08:12',
      describtion: ''),
  const Conversation(
      avatar: 'static/images/xinwen.jpg',
      title: '腾讯新闻',
      createAt: '12:09',
      describtion: '微视频：人民代表xxx履职记',
      displayDot: true),
  const Conversation(
      avatar: 'static/images/dianxin.jpg',
      title: '中国电信',
      createAt: '14:01',
      describtion: '月度账单提醒',
      unReadMsgCount: 1),
];
class Manager {
  // 工厂模式
  factory Manager() =>_getInstance();
  static Manager get instance => _getInstance();
  static Manager _instance;
  bool _hasNewData = false;
  Manager._internal() {
    // 初始化
  }
  static Manager _getInstance() {
    if (_instance == null) {
      _instance = new Manager._internal();
    }
    return _instance;
  }
  setSate(bool hasNewData) {
    this._hasNewData = hasNewData;
  }
  getState() {
    return this._hasNewData;
  }
}