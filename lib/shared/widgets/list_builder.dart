import 'package:flutter/material.dart';

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
    @required this.output,
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
        onPressed: () => Navigator.pushNamed(
          context,
          input,
          arguments: args,
        ),
      ),
      body: list.length > 0
          ? Column(
              children: list
                  .asMap()
                  .map(
                    (i, model) => MapEntry(
                      i,
                      ListTile(
                        title: Text("$title ${i + 1}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                output,
                                arguments: model,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                input,
                                arguments: model,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => onDelete(i),
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
                child: Text("No $title"),
              ),
            ),
    );
  }
}
