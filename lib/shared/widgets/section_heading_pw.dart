import 'package:pdf/widgets.dart' as pw;

class SectionHeadingPw extends pw.StatelessWidget {
  final String sl;
  final String heading;
  SectionHeadingPw(this.sl, this.heading);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.topLeft,
      child: pw.Column(
        children: [
          pw.SizedBox(
            height: 20,
          ),
          pw.Row(
            children: [
              pw.Text(
                sl,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              pw.Text(
                heading,
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 15,
                    decoration: pw.TextDecoration.underline),
              ),
            ],
          ),
          pw.SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
