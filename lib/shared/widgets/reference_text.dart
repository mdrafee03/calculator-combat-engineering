import 'package:flutter/material.dart';

class ReferenceText extends StatelessWidget {
  final String text;
  ReferenceText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, top: 2, bottom: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
