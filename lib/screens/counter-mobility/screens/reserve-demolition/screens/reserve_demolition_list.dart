import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../../../models/counter_mobility.dart';
import '../models/reserve_demolition.dart';

class ReserveDemolitionList extends StatefulWidget {
  @override
  _ReserveDemolitionListState createState() => _ReserveDemolitionListState();
}

class _ReserveDemolitionListState extends State<ReserveDemolitionList> {
  final List<ReserveDemolition> _listOfReserveDemolition =
      CounterMobility.listOfReserveDemolition;
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Reserve Demolition'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            reserveDemolitionChildren,
            arguments: ReserveDemolition(),
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
          reserveDemolitionChildren,
          arguments: ReserveDemolition(),
        ),
      ),
      body: _listOfReserveDemolition.length > 0
          ? Column(
              children: _listOfReserveDemolition
                  .asMap()
                  .map(
                    (i, _reserveDemolition) => MapEntry(
                      i,
                      ListTile(
                        title: Text("Reserve Demolition ${i + 1}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                reserveDemolitionChildren,
                                arguments: _reserveDemolition,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => setState(() => CounterMobility
                                  .listOfReserveDemolition
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
                child: Text("No Reserve Demolition"),
              ),
            ),
    );
  }
}
