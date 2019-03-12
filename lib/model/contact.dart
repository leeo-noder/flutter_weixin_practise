import 'package:flutter/material.dart';

class Contact {
  const Contact({
    @required this.avatar,
    @required this.name,
    this.nameIndex,
    this.isNetwork = false
  })
      : assert(avatar != null),
        assert(name != null);
  final String avatar;
  final String name;
  final String nameIndex;
  final bool isNetwork;

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        avatar: json['picture']['thumbnail'],
        name: json['name']['first'] + ' ' + json['name']['last'],
        nameIndex: json['name']['first'].toString().substring(0, 1),
        isNetwork: true
    );
  }
}

List<Contact> mockContact = [];
List<Contact> preContact = [
  const Contact(avatar: 'static/images/contact_new_friend.png', name: '新的朋友'),
  const Contact(avatar: 'static/images/contact_group.png', name: '群聊'),
  const Contact(avatar: 'static/images/contact_tag.png', name: '标签'),
  const Contact(avatar: 'static/images/contact_public_number.png', name: '公众号')
];
