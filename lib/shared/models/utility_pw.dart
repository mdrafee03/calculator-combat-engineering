import 'package:pdf/widgets.dart';

class UtilityPw {
  static Container buildTableCell(String cell, {bool isCenter = false}) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder(
          top: true,
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
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
