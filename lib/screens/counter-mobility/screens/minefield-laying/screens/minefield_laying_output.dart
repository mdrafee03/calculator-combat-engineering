import 'package:flutter/material.dart';

import '../models/minefield_laying.dart';

class MinefieldLayingOutput extends StatelessWidget {
  final AppBar appbar = new AppBar(
    title: Text('Minefield Laying Result'),
  );
  @override
  Widget build(BuildContext context) {
    final MinefieldLaying _minefieldLaying =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appbar,
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Calculation',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Number of Strips: '),
                      Text(_minefieldLaying.numberOfStrips.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Number of Cluster Per Strip: '),
                      Text(
                        _minefieldLaying.numberOfClusterPerStrip.toString(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
