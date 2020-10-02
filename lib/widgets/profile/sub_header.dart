import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/share/string_extension.dart';

class SubHeader extends StatelessWidget {
  final UserModel userModel;
  const SubHeader({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            userModel.displayName.toUpperCase(),
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Palette.blue[300]),
          ),
          Text(
            userModel.selectedActivity.capitalize(),
            style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.2,
                color: Palette.blue[300]),
          ),
        ],
      ),
    );
  }
}
