import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:leadee/share/palette.dart';

class LoadingComponent extends StatefulWidget {
  LoadingComponent({Key key}) : super(key: key);

  @override
  _LoadingComponentState createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  double _opacity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(milliseconds: 500), changeOpacity);
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = _opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: 100.0,
                  maxWidth: 233.0,
                  minWidth: 150.0,
                  minHeight: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    color: Colors.black.withOpacity(.5),
                                    offset: Offset(0, 1),
                                    blurRadius: 2)
                              ]),
                          text: 'lead'.toUpperCase(),
                          children: [
                        TextSpan(
                            text: 'ee'.toUpperCase(),
                            style: TextStyle(color: Palette.orange[50]))
                      ])),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(seconds: 1),
                    child: Text(
                      FlutterI18n.translate(context, 'loading'),
                      style: TextStyle(letterSpacing: 2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
