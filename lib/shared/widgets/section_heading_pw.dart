import 'package:pdf/widgets.dart';

class SectionHeadingPw extends StatelessWidget {
  final String sl;
  final String heading;
  SectionHeadingPw(this.sl, this.heading);
  @override
  Widget build(Context context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                sl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                heading,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
