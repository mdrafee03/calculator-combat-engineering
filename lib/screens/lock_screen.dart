import 'package:combat_engineering/router/route_const.dart';
import 'package:combat_engineering/shared/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final String password = 'ecsme';
  final pwController = TextEditingController();
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundContainer(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'assets/images/icons/logo.png',
                      width: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: Text(
                      'CONCEPT, PLANNING AND SUPERVISED BY ENGINEER CENTRE AND SCHOOL OF MILITARY ENGINEERING, QADIRABAD CANTONMENT',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text('Enter Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 30.0),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 5,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.text,
                      controller: pwController,
                      obscureText: true,
                      onChanged: (value) {
                        if (value.length == 5 && value == password) {
                          Navigator.popAndPushNamed(context, home);
                        } else if (value.length == 5 && value != password) {
                          setState(() {
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              pwController.clear();
                            });
                            isValid = false;
                            HapticFeedback.vibrate();
                          });
                        }
                      },
                    ),
                  ),
                  if (!isValid)
                    Text(
                      'Password not correct',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
