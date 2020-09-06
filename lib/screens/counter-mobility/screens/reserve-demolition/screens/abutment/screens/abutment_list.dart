import 'package:flutter/material.dart';

import '../../../../../../../router/route_const.dart';
import '../../../models/reserve_demolition.dart';
import '../models/abutment.dart';

class AbutmentList extends StatefulWidget {
  @override
  _AbutmentListState createState() => _AbutmentListState();
}

class _AbutmentListState extends State<AbutmentList> {
  @override
  Widget build(BuildContext context) {
    ReserveDemolition _currentReserveDemolition =
        ReserveDemolition.currentReserveDemolition;
    List<Abutment> _listOfAbutment = _currentReserveDemolition.listOfAbutment;
    final appBar = AppBar(
      title: Text('Abutment Demolition'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            abutmentInput,
            arguments: Abutment(),
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
          abutmentInput,
          arguments: Abutment(),
        ),
      ),
      body: _listOfAbutment.length > 0
          ? Column(
              children: _listOfAbutment
                  .asMap()
                  .map(
                    (i, _abutment) => MapEntry(
                      i,
                      ListTile(
                        title: Text("Abutment ${i + 1}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                abutmentOutput,
                                arguments: _abutment,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                abutmentInput,
                                arguments: _abutment,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  setState(() => _listOfAbutment.removeAt(i)),
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
                child: Text("No  Abutment"),
              ),
            ),
    );
  }
}
