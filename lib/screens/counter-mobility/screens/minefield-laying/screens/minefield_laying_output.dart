import '../models/moon_lit.dart';
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'SUMMARY OF THE MINIFIED LAYING CALCULATION',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            '1. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'Strips',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
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
                            "a. Number of Strips = ${_minefieldLaying.numberOfStrips}",
                          ),
                          Text(
                            "b. Number of Anti-Tank Strips = ${_minefieldLaying.numberOfAntiTankStrips}",
                          ),
                          Text(
                            "c. Number of Mixed Strips = ${_minefieldLaying.numberOfMixedStrip.ceil()}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            '2. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Mines',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
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
                            "a. Number of Anti-Tank Mines = ${_minefieldLaying.antiTankMines}",
                          ),
                          Text(
                            "b. Number of Anti-Personnel Mines = ${_minefieldLaying.antiPersonnelMines}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            '3. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Stores',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
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
                            "a. Long Pickets = ${_minefieldLaying.longPicket}",
                          ),
                          Text(
                            "b. Short Pickets = ${_minefieldLaying.shortPicket}",
                          ),
                          Text(
                            "c. Barbed Wire = ${_minefieldLaying.barbedWire}",
                          ),
                          Text(
                            "d. Perimeter Sign Posting = ${_minefieldLaying.perimeterSignPosting}",
                          ),
                          Text(
                            "e. Tracing Tape = ${_minefieldLaying.tracingTape}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            '4. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Transport',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
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
                            "a. For Anti-Tank Mines = ${_minefieldLaying.totalLorryForAntiTankMine}x 3-ton lorry",
                          ),
                          Text(
                            "b. For Anti-Personnel Mines = ${_minefieldLaying.totalLorryForAntiPersonnelMine}x 3-ton lorry",
                          ),
                          Text(
                            "c. For Perimeter Fencing = ${_minefieldLaying.totalLorryForStores}x 3-ton lorry",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("d. For Personnel = "),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_minefieldLaying.totalLorryForPersonnel}x 3-ton lorry",
                                  ),
                                  Text("1x 1/4-ton Jeep"),
                                  Text("1x 1-ton pickup"),
                                  Text("1x Ambulance"),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "e. Total 3-ton Require = ${(_minefieldLaying.totalLorryForPersonnel + _minefieldLaying.totalLorryForAntiTankMine + _minefieldLaying.totalLorryForAntiPersonnelMine + _minefieldLaying.totalLorryForStores)}",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("f. Total Other Vehicles Require = "),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("1x 1/4-ton Jeep"),
                                  Text("1x 1-ton pickup"),
                                  Text("1x Ambulance"),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            '5. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Time',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
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
                            "a. Start Time = ${_minefieldLaying.hourFormat(_minefieldLaying.lastLight)} D-Day (${listOfMoonlit.firstWhere((option) => option.value == _minefieldLaying.dDay).title})",
                          ),
                          Text(
                            "b. Completion Time = ${_minefieldLaying.timeRequired.completionTime}",
                          ),
                          Text(
                            "c. Total Time Require = ${_minefieldLaying.timeRequired.timeRequiredInMinutes}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            '6. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Layout of Conventional Minefield',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        'assets/images/minefield_layout.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
