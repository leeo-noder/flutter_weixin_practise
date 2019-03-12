import 'package:flutter/material.dart';
import 'package:flutter_weixin/model/find.dart' show Find, mockContact;
import 'package:flutter_weixin/components/UserIconWidget.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: mockContact.length,
          itemBuilder: (BuildContext context, int index) {
           return _FindItem(
              find: mockContact[index],
            );
          }),
    );
  }
}

class _FindItem extends StatelessWidget {
  final Find find;

  _FindItem({Key key, this.find})
      : assert(find != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding: const EdgeInsets.only(top: 0.0, right: 14.0, left: 14.0),
        width: 25.0,
        height: 25.0,
        image: find.avatar,
        isNetwork: find.isNetwork,
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    Widget itemRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        userImage,
        Expanded(
          child: Container(
            decoration: find.isWhite ? BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffd9d9d9), width: .3))): null,
            padding: EdgeInsets.only(top: 16.0),
            child: Container(
              // alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 15.0),
              child: Text(
                find.name,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),
        Container(

          decoration: find.isWhite ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xffd9d9d9), width: .3))): null,
          padding: EdgeInsets.only(top: 15.0,bottom: 15.0, right: 10.0),
          child:
          Icon(Icons.chevron_right, color: Colors.grey,),
        )
      ],
    );
    return Container(
      height: find.isWhite? 85 : 55,
      child: find.isWhite ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            color: Color(0xffEDEDED),
            height: 20.0,
          ),
          itemRow,
        ],
      ): itemRow,
    );
  }
}
