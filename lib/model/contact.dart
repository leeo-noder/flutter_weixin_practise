import 'package:flutter/material.dart';

class Contact {
  const Contact({
    @required this.avatar,
    @required this.name,
    this.isNetwork = false
  })  : assert(avatar != null),
        assert(name != null);
  final String avatar;
  final String name;
  final bool isNetwork;
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      avatar: json['picture']['thumbnail'],
      name: json['name']['first'] + ' ' + json['name']['last'],
      isNetwork: true
    );
  }
}

List<Contact> mockContact = [];
List<Contact> preContact = [
  const Contact(avatar: 'static/images/zushou.jpg', name: '文件传输助手'),
  const Contact(avatar: 'static/images/xinwen.jpg', name: '腾讯新闻'),
  const Contact(avatar: 'static/images/dianxin.jpg', name: '中国电信'),
];
