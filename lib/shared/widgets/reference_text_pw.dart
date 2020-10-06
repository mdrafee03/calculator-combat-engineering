import 'package:pdf/widgets.dart';

class ReferenceTextPw extends StatelessWidget {
  final String text;
  ReferenceTextPw(this.text);

  @override
  Widget build(Context context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, top: 2, bottom: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
