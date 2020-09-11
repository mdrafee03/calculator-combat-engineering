import 'package:flutter/material.dart';

import '../../../../../router/route_const.dart';
import '../models/combined_project.dart';

class CombinedProjectInput extends StatefulWidget {
  @override
  _CombinedProjectInputState createState() => _CombinedProjectInputState();
}

class _CombinedProjectInputState extends State<CombinedProjectInput> {
  final appBar = AppBar(
    title: Text('Combined Project'),
  );

  CombinedProject _model = CombinedProject();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void handleSubmit(BuildContext context) {
      final form = _formKey.currentState;
      form.save();
      Navigator.pushNamed(context, combinedProjectOutput, arguments: _model);
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Select D-Day Date",
                  ),
                  subtitle: Text("${_model.startDate.toLocal()}".split(' ')[0]),
                  trailing: Icon(Icons.date_range),
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _model.startDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _model.startDate = picked;
                      });
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () => handleSubmit(context),
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
