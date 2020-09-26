import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leadee/screens/home.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  AnimationController _ctrlWelcome;
  Animation<double> _animationWelcome;

  AnimationController _ctrlSpace;
  Animation<double> _animationSpace;

  @override
  void initState() {
    super.initState();

    _ctrlWelcome = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _animationWelcome =
        CurvedAnimation(parent: _ctrlWelcome, curve: Curves.easeIn);

    _ctrlWelcome.forward();

    _ctrlSpace = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _animationSpace = CurvedAnimation(
        parent: _ctrlSpace, curve: Interval(.5, 1.0, curve: Curves.easeIn));

    _ctrlSpace.forward();

    Timer(
        Duration(milliseconds: 3000),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

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
                      FadeTransition(
                        opacity: _animationWelcome,
                        child: Text(
                          'Welcome.'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.4),
                        ),
                      ),
                      FadeTransition(
                        opacity: _animationSpace,
                        child: Text(
                          'We prepare your space..',
                          style: TextStyle(fontSize: 12),
                        ),
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
