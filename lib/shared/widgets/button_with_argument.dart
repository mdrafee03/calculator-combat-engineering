import 'package:flutter/material.dart';

class ButtonWithArgument extends StatelessWidget {
  final String text;
  final String routeName;
  final Object argument;
  const ButtonWithArgument(
      BuildContext context, this.text, this.routeName, this.argument);

  @override
  Widget build(context) {
    return Container(
      child: RaisedButton(
        onPressed: () =>
            Navigator.pushNamed(context, routeName, arguments: argument),
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textColor: Colors.white,
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: 320,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
