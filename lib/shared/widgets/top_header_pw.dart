import 'package:pdf/widgets.dart';

import '../../shared/models/pdfTheme.dart';

class TopHeaderPw extends StatelessWidget {
  final String heading;
  TopHeaderPw(this.heading);

  @override
  Widget build(Context context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        heading.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: PDFTheme.color,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
