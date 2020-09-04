import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../models/counter_mobility.dart';
import '../models/anti_tank.dart';

class AntiTankList extends StatefulWidget {
  @override
  _AntiTankListState createState() => _AntiTankListState();
}

class _AntiTankListState extends State<AntiTankList> {
  final List<AntiTank> _listOfAntiTank = CounterMobility.listOfAntiTank;
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Anti Tank Ditch'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            antiTankInput,
            arguments: AntiTank(),
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
          antiTankInput,
          arguments: AntiTank(),
        ),
      ),
      body: _listOfAntiTank.length > 0
          ? Column(
              children: _listOfAntiTank
                  .asMap()
                  .map(
                    (i, _antiTank) => MapEntry(
                      i,
                      ListTile(
                        title: Text("Anti Tank ${i + 1}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                antiTankOuput,
                                arguments: _antiTank,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                antiTankInput,
                                arguments: _antiTank,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => setState(() =>
                                  CounterMobility.listOfAntiTank.removeAt(i)),
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
                child: Text("No Anti Tank"),
              ),
            ),
    );
  }
}
