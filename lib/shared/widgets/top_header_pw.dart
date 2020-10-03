import 'package:pdf/widgets.dart' as pw;

import '../../shared/models/pdfTheme.dart';

class TopHeaderPw extends pw.StatelessWidget {
  final String heading;
  TopHeaderPw(this.heading);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(
        heading.toUpperCase(),
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 15,
          color: PDFTheme.color,
          decoration: pw.TextDecoration.underline,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }
}
