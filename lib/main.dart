import 'package:flutter/material.dart';
import 'components/BottomNavigationBar/demo.dart';
import 'components/BottomNavigationBar/bar.dart';
import 'routers/routers.dart';
import 'package:fluro/fluro.dart';
import 'routers/application.dart';
import 'package:flutter_weixin/utils/provider.dart';
import 'package:flutter_weixin/utils/shared_preferences.dart';
import 'package:flutter_weixin/common/style/Style.dart';


SpUtil sp;
var db;

void main() async {
  final provider = new Provider();
  await provider.init(true);
  sp = await SpUtil.getInstance();
  db = Provider.db;
  runApp(new MyApp());
}

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
      theme: ThemeData(
          primarySwatch: Style.primarySwatch, cardColor: Color(0xFF4C4C4C)),
      home: new Scaffold(
          body: Bar()),
      onGenerateRoute: Application.router.generator,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarFullDefault();
  }
}
