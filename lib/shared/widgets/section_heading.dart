import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String sl;
  final String heading;
  const SectionHeading(this.sl, this.heading);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(style: TextStyle(color: Colors.black), children: [
              TextSpan(
                text: sl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              TextSpan(
                text: heading,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
