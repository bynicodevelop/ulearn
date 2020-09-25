import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/screens/auth/auth.dart';
import 'package:leadee/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    return Container(
      child: user == null ? Auth() : Home(),
    );
  }
}
