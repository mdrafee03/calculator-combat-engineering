import 'package:flutter/material.dart';

class ButtonWithImage extends StatelessWidget {
  final String imageUrl;
  final String routeName;
  const ButtonWithImage({
    BuildContext context,
    this.imageUrl,
    this.routeName,
  });

  @override
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: () => Navigator.pushNamed(context, routeName),
        padding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).primaryColor,
        child: Image.asset(
          imageUrl,
          width: 150,
        ),
      ),
    );
  }
}
