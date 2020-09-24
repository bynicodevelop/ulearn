import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Welcome.'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.4),
                      ),
                      Text(
                        'We prepare your space..',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
