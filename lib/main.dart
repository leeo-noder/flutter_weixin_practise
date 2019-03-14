import 'package:flutter/material.dart';
import 'components/BottomNavigationBar/bar.dart';
import 'routers/routers.dart';
import 'package:fluro/fluro.dart';
import 'routers/application.dart';
import 'package:flutter_weixin/utils/provider.dart';
import 'package:flutter_weixin/utils/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;


SpUtil sp;
var db;

void main() async {
  final provider = new Provider();
  await provider.init(true);
  sp = await SpUtil.getInstance();
  db = Provider.db;
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(new MyApp());
}

Color themeDef = Color(0xffEDEDED);

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WeiXin Demo',
      theme: ThemeData(primaryColor: themeDef, cardColor: Color(0xff4C4C4C)),
      home: new Scaffold(body: Bar()),
      onGenerateRoute: Application.router.generator,
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}*/

/*class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarFullDefault();
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: '网络错误');
        break;
      case 401:
        Fluttertoast.showToast(msg: '[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]');
        break;
      case 403:
        Fluttertoast.showToast(msg: '403权限错误');
        break;
      case 404:
        Fluttertoast.showToast(msg: '404错误');
        break;
      case Code.NETWORK_TIMEOUT:
      //超时
        Fluttertoast.showToast(msg: '请求超时');
        break;
      default:
        Fluttertoast.showToast(msg: '其他异常');
        break;
    }
  }
}*/
