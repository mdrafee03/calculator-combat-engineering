import 'package:flutter/material.dart';
import '../screens/home.dart';
import './route-const.dart';

class Router {
  static Map<String, WidgetBuilder> mainRouter() {
    return <String, WidgetBuilder>{
      home: (BuildContext ctx) => Home(),
    };
  }
}
