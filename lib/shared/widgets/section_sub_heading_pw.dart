import 'package:pdf/widgets.dart' as pw;

class SectionSubHeadingPw extends pw.StatelessWidget {
  final String sl;
  final String heading;
  SectionSubHeadingPw(this.sl, this.heading);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.topLeft,
      child: pw.Container(
        padding: pw.EdgeInsets.only(top: 8, bottom: 8),
        child: pw.Row(
          children: [
            pw.Text(
              sl,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 14,
              ),
            ),
            pw.Text(
              heading,
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  decoration: pw.TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}
