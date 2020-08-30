import 'package:flutter/material.dart';

class HeadingOutput extends StatelessWidget {
  final String heading;
  HeadingOutput(this.heading);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        heading.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
