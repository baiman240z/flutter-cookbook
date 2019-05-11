import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'widgets/splash.dart';
import 'widgets/home.dart';
import 'widgets/alert.dart';
import 'widgets/tabs.dart';
import 'widgets/childscreen.dart';
import 'widgets/layout.dart';
import 'widgets/drag.dart';
import 'widgets/camera.dart';
import 'widgets/audio.dart';
import 'widgets/httpconn.dart';
import 'widgets/location.dart';
import 'widgets/web.dart';
import 'widgets/fcm.dart';
import 'counter_model.dart';

void main() {
  runApp(MyApp(model: CounterModel()));
}

class MyApp extends StatelessWidget {
  final CounterModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Splash(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => Home(),
          '/fcm': (BuildContext context) => Fcm(),
          '/alert': (BuildContext context) => Alert(),
          '/tabs': (BuildContext context) => Tabs(),
          '/childscreen': (BuildContext context) => ListScreen(),
          '/layout': (BuildContext context) => Layout(),
          '/splash': (BuildContext context) => Splash(),
          '/drag': (BuildContext context) => Drag(),
          '/camera': (BuildContext context) => Camera(),
          '/audio': (BuildContext context) => AudioApp(),
          '/httpconn': (BuildContext context) => HttpConn(),
          '/location': (BuildContext context) => Location(),
          '/web': (BuildContext context) => Web(),
        },
      ),
    );
  }

}
