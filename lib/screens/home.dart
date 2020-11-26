import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:passcode_screen/passcode_screen.dart';

import '../router/route_const.dart';
import '../shared/widgets/background_container.dart';
import '../shared/widgets/button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool isAuthenticated = false;
  requestPermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined || status.isDenied) {
      if (await Permission.storage.request().isGranted) {
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _onPasscodeEntered(String enteredPassword) {
    bool isValid = '123456' == enteredPassword;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isAuthenticated
        ? Container(
            child: PasscodeScreen(
              title: Text('Lock Screen'),
              passwordEnteredCallback: _onPasscodeEntered,
              deleteButton:
                  Text('Delete', style: TextStyle(color: Colors.white)),
              cancelButton:
                  Text('Cancel', style: TextStyle(color: Colors.white)),
              shouldTriggerVerification: _verificationNotifier.stream,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Combat Engineering'),
            ),
            body: BackgroundContainer(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Button(context, 'COUNTER MOBILITY TASK',
                        counterMobilityScreen),
                    SizedBox(height: 10),
                    Button(context, 'MOBILITY TASK', mobilityScreen),
                  ],
                ),
              ),
            ),
          );
  }
}
