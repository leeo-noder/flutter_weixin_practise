import 'package:flutter/material.dart';

class Find {
  const Find(
      {@required this.avatar, @required this.name, this.isNetwork = false, this.isWhite = false})
      : assert(avatar != null),
        assert(name != null);
  final String avatar;
  final String name;
  final bool isNetwork;
  final bool isWhite;
}

List<Find> mockContact = [
  const Find(avatar: 'static/images/find_friend_circle.png', name: '朋友圈'),
  const Find(avatar: 'static/images/find_scan.png', name: '扫一扫', isWhite: true),
  const Find(avatar: 'static/images/find_shake.png', name: '摇一摇'),
  const Find(avatar: 'static/images/find_show.png', name: '看一看', isWhite: true),
  const Find(avatar: 'static/images/find_sou.png', name: '搜一搜'),
  const Find(avatar: 'static/images/find_nearby.png', name: '附近的人', isWhite: true),
  const Find(avatar: 'static/images/find_bottle.png', name: '漂流瓶'),
  const Find(avatar: 'static/images/find_shop.png', name: '购物', isWhite: true),
  const Find(avatar: 'static/images/find_game.png', name: '游戏'),
  const Find(avatar: 'static/images/find_xcx.png', name: '小程序', isWhite: true)
];
