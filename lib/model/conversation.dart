import 'package:flutter/material.dart';
import 'package:flutter_weixin/utils/util.dart';
class Conversation {
 const Conversation(
      {@required this.avatar,
      @required this.title,
      @required this.createAt,
      this.isMute: false,
      this.titleColor: 0xff353535,
      this.describtion,
      this.unReadMsgCount: 0,
      this.displayDot: false})
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

 factory Conversation.fromJson(Map<String, dynamic> json) {
   return Conversation(
     avatar: json['picture']['thumbnail'],
     createAt: Util.getTimeDuration(json['registered']['date']),
     title: json['name']['first'] + ' ' + json['name']['last'],
     describtion: json['location']['timezone']['description']
   );
 }
}

 List<Conversation> mockConversation = [];
