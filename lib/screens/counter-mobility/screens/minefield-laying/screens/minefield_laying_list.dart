import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../models/counter_mobility.dart';
import '../models/minefield_laying.dart';

class MinefieldLayingList extends StatefulWidget {
  @override
  _MinefieldLayingListState createState() => _MinefieldLayingListState();
}

class _MinefieldLayingListState extends State<MinefieldLayingList> {
  final List<MinefieldLaying> _listOfMinefieldLaying =
      CounterMobility.listOfMinefieldLaying;
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Minefield Laying'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            minefieldLayingInput,
            arguments: MinefieldLaying(),
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, minefieldLayingInput,
            arguments: MinefieldLaying()),
      ),
      body: _listOfMinefieldLaying.length > 0
          ? Column(
              children: _listOfMinefieldLaying
                  .asMap()
                  .map(
                    (i, minefield) => MapEntry(
                      i,
                      ListTile(
                        title: Text("Minefield Laying ${i + 1}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                minefieldLayingOutput,
                                arguments: minefield,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                minefieldLayingInput,
                                arguments: minefield,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => setState(() => CounterMobility
                                  .listOfMinefieldLaying
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
                child: Text("No minefield"),
              ),
            ),
    );
  }
}
