import 'package:flutter/material.dart';
import 'package:leadee/screens/auth/auth.dart';
import 'package:leadee/services/auth.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        body: FlatButton(
          child: Text('Logout'),
          onPressed: () async {
            await _authService.signOut();

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Auth()));
          },
        ),
      )),
    );
  }
}