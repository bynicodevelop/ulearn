import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/share/palette.dart';

class About extends StatelessWidget {
  final UserModel userModel;
  const About({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'about'.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.4),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            userModel.about,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Palette.blue[300], fontSize: 12, letterSpacing: 1.1),
          )
        ],
      ),
    );
  }
}
