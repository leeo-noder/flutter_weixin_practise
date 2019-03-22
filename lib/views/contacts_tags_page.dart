import 'package:flutter/material.dart';
import 'package:flutter_weixin/common/style/Style.dart' show Style;

class ContactsTagsChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('所有标签'),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(Style.primaryValue),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('暂无标签', style: TextStyle(color: Colors.grey,fontSize: 18.0),),
              Text('你可以通过给朋友添加标签来进行分类', style: TextStyle(color: Colors.grey,fontSize: 14.0),),
              Container(
                width: 300.0,
                height: 45.0,
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  color: Colors.green,
                  elevation: 0.0,
                  child: Text('新建标签', style: TextStyle(fontSize: 16.0),),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
