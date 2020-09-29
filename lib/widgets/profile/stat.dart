import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class ProfileStat extends StatelessWidget {
  final String number;
  final String label;
  const ProfileStat({Key key, @required this.label, this.number = '0'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.6,
                color: Palette.blue[300]),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            label.toUpperCase(),
            style: TextStyle(
                color: Palette.grey[50], fontSize: 10, letterSpacing: 1.1),
          )
        ],
      ),
    );
  }
}
