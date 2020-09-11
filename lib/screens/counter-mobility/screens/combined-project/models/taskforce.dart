import 'package:flutter/material.dart';

class Taskforce {
  String name;
  Color color;
  Taskforce(this.name, this.color);
  static List<Taskforce> taskforces = [
    new Taskforce("A", Color(0xffc0504d)),
    new Taskforce("B", Color(0xff0070c0)),
    new Taskforce("C", Color(0xff00b050)),
  ];
}
