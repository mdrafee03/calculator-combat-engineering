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
      content: Text('PDF Saved in Downloads'),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  static Container buildTableCell(String cell, {bool isCenter = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
        ),
      ),
      padding: !isCenter ? EdgeInsets.only(left: 5) : null,
      alignment: isCenter ? Alignment.center : Alignment.centerLeft,
      child: Text(cell),
    );
  }

  static Container buildTableHeader(String text) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
