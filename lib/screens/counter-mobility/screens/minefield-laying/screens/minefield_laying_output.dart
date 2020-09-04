import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../../../shared/widgets/heading_output.dart';
import '../../../../../shared/widgets/section_heading.dart';
import '../models/moon_lit.dart';
import '../models/minefield_laying.dart';

class MinefieldLayingOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MinefieldLaying _minefieldLaying =
        ModalRoute.of(context).settings.arguments;
    final AppBar appbar = new AppBar(
      title: Text('Minefield Laying Result'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () => Navigator.popUntil(
            context,
            ModalRoute.withName(minefieldLayingList),
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              HeadingOutput('Summary of the minefield laying calculation'),
              SectionHeading('1. ', 'Strips'),
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
              SectionHeading('2. ', 'Mines'),
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
              SectionHeading('3. ', 'Stores'),
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
              SectionHeading('4. ', 'Transport'),
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
                        Text("d. For Personnel "),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "= ${_minefieldLaying.totalLorryForPersonnel}x 3-ton lorry",
                            ),
                            Text("= 1x 1/4-ton Jeep"),
                            Text("= 1x 1-ton pickup"),
                            Text("= 1x Ambulance"),
                          ],
                        )
                      ],
                    ),
                    Text(
                      "e. Total 3-ton Require = ${(_minefieldLaying.totalLorryForPersonnel + _minefieldLaying.totalLorryForAntiTankMine + _minefieldLaying.totalLorryForAntiPersonnelMine + _minefieldLaying.totalLorryForStores)}",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("f. Total Other Vehicles Require"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("= 1x 1/4-ton Jeep"),
                            Text("= 1x 1-ton pickup"),
                            Text("= 1x Ambulance"),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SectionHeading('5. ', 'Time'),
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
              SectionHeading('6. ', 'Layout of Conventional Minefield'),
              Container(
                child: Image.asset(
                  'assets/images/minefield_layout.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
