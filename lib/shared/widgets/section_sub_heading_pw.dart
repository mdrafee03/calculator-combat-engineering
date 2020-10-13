import 'package:pdf/widgets.dart';

class SectionSubHeadingPw extends StatelessWidget {
  final String sl;
  final String heading;
  SectionSubHeadingPw(this.sl, this.heading);
  @override
  Widget build(Context context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            Text(
              sl,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              heading,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}
