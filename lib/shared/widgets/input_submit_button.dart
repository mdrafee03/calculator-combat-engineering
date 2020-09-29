import 'package:flutter/material.dart';

class InputSubmitButton extends StatelessWidget {
  final Function handleSubmit;
  InputSubmitButton(this.handleSubmit);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () => handleSubmit(context),
      child: Text('Submit'),
    );
  }
}
