import 'package:flutter/material.dart';
import 'package:plan_task/src/auth/root_page.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        body: RootPage(),
      ),
      routes: <String,WidgetBuilder>{
        '/rootpage':(BuildContext context)=> new RootPage(),
      }
    );
  }
}