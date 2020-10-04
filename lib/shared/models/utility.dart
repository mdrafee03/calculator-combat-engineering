import 'package:flutter/material.dart';

class Utility {
  static String romanize(int number) {
    Map<String, int> lookup = {
      "M": 1000,
      "CM": 900,
      "D": 500,
      "CD": 400,
      "C": 100,
      "XC": 90,
      "L": 50,
      "XL": 40,
      "X": 10,
      "IX": 9,
      "V": 5,
      "IV": 4,
      "I": 1
    };
    String roman = '';

    lookup.forEach((key, value) {
      while (number >= value) {
        roman += key;
        number -= value;
      }
    });
    return roman;
  }

  static void showPrintedToast(BuildContext context) {
    final snackbar = SnackBar(
      content: Text('Pdf Saved in Downloads'),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
