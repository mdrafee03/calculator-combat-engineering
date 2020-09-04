import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../models/counter_mobility.dart';
import '../models/wire_obstacle.dart';

class WireObstacleList extends StatefulWidget {
  @override
  _WireObstacleListState createState() => _WireObstacleListState();
}

class _WireObstacleListState extends State<WireObstacleList> {
  final List<WireObstacle> _listOfWireObstacle =
      CounterMobility.listOfWireObstacle;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Wire Obstacle'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            wireObstacleInput,
            arguments: WireObstacle(),
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
          wireObstacleInput,
          arguments: WireObstacle(),
        ),
      ),
      body: _listOfWireObstacle.length > 0
          ? Column(
              children: _listOfWireObstacle
                  .asMap()
                  .map(
                    (i, wireObstacle) => MapEntry(
                      i,
                      ListTile(
                        title: Text("Wire Obstacle ${i + 1}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                wireObstacleOuput,
                                arguments: wireObstacle,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                wireObstacleInput,
                                arguments: wireObstacle,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => setState(() => CounterMobility
                                  .listOfWireObstacle
                                  .removeAt(i)),
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
                child: Text("No Wire Obstacle"),
              ),
            ),
    );
  }
}
