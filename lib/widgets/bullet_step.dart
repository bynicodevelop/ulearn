import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class BulletStep extends StatelessWidget {
  final int step;

  const BulletStep({Key key, @required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
            width: 10,
            height: 10,
            color: step == 1 ? Palette.blue[50] : Palette.grey[50],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ClipOval(
          child: Container(
            width: 10,
            height: 10,
            color: step == 2 ? Palette.blue[50] : Palette.grey[50],
          ),
        )
      ],
    );
  }
}
