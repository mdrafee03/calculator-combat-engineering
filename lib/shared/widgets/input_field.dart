import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  InputField(this.label);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
              decoration: InputDecoration(
                  hintText: label, labelText: label,
            ),
    );
  }
}