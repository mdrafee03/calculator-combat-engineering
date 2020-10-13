import 'package:flutter/material.dart';

import './background_container.dart';

class ListBuilder extends StatelessWidget {
  final String title;
  final String input;
  final String output;
  final List list;
  final Function onDelete;
  final Object args;
  ListBuilder({
    Key key,
    @required this.title,
    @required this.input,
    this.output,
    @required this.onDelete,
    @required this.list,
    @required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            input,
            arguments: args,
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.pushNamed(
          context,
          input,
          arguments: args,
        ),
      ),
      body: Stack(
        children: [
          BackgroundContainer(),
          list.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: list
                        .asMap()
                        .map(
                          (i, model) => MapEntry(
                            i,
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.green, spreadRadius: 1),
                                ],
                              ),
                              child: ListTile(
                                key: ValueKey(i),
                                title: Text(
                                  "$title ${i + 1}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (output != null)
                                      IconButton(
                                        icon: const Icon(Icons.remove_red_eye),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () => Navigator.pushNamed(
                                          context,
                                          output,
                                          arguments: model,
                                        ),
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: Color(0xffffc107),
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        input,
                                        arguments: model,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Color(0xffdc3545),
                                      onPressed: () => onDelete(i),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                )
              : Container(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(color: Colors.green, spreadRadius: 1),
                        ],
                      ),
                      child: Text(
                        "No $title",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
