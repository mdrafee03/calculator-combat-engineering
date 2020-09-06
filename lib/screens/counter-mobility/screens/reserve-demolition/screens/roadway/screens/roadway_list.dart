import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../models/reserve_demolition.dart';
import '../models/roadway.dart';

class RoadwayList extends StatefulWidget {
  @override
  _RoadwayListState createState() => _RoadwayListState();
}

class _RoadwayListState extends State<RoadwayList> {
  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    List<Roadway> _listOfRoadway = _currentReserveDemolition.listOfRoadway;
    final appBar = AppBar(
      title: Text('Demolition of Roadway'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            roadwayInput,
            arguments: Roadway(),
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(
          context,
          roadwayInput,
          arguments: Roadway(),
        ),
      ),
      body: _listOfRoadway.length > 0
          ? Column(
              children: _listOfRoadway
                  .asMap()
                  .map(
                    (i, _roadway) => MapEntry(
                      i,
                      ListTile(
                        title: Text("Roadway ${i + 1}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                roadwayOutput,
                                arguments: _roadway,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                roadwayInput,
                                arguments: _roadway,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  setState(() => _listOfRoadway.removeAt(i)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            )
          : Container(
              child: Center(
                child: Text("No Roadway"),
              ),
            ),
    );
  }
}
