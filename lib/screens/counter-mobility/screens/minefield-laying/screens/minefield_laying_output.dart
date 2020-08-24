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
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Mines',
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
                      Text('Anti Tank Mines: '),
                      Text(_minefieldLaying.antiTankMines.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Anti Personnel Mines: '),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Store Calculation',
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
                      Text('Long Pickets: '),
                      Text(_minefieldLaying.longPicket.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Short Pickets: '),
                      Text(
                        _minefieldLaying.shortPicket.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Barbed Wire: '),
                      Text(_minefieldLaying.barbedWire.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Perimeter Sign Posting: '),
                      Text(
                        _minefieldLaying.perimeterSignPosting.toString(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Tracing Tape: '),
                      Text(
                        _minefieldLaying.tracingTape.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Transport',
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
                      Text('Anti Tank Mines: '),
                      Text(_minefieldLaying.totalLorryForAntiTankMine
                          .toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Anti Personnel Mines: '),
                      Text(_minefieldLaying.totalLorryForAntiPersonnelMine
                          .toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Perimeter Fencing: '),
                      Text(
                        _minefieldLaying.totalLorryForStores.toString(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('For Personnel: '),
                      Text(
                        _minefieldLaying.totalLorryForPersonnel.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transport required for manpower',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "(1) ${_minefieldLaying.totalLorryForPersonnel}x 3-ton lorry"),
                  Text("(2) 1x 1/4-ton jeep"),
                  Text("(3) 1x 1-ton pick up"),
                  Text("(4) 1x Ambulance"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
