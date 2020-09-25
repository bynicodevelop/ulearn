import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class NextBtn extends StatelessWidget {
  final String label;
  final Function onPress;
  const NextBtn({Key key, @required this.onPress, this.label = 'next'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      height: 30,
      onPressed: onPress,
      child: Text(
        label.toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      color: Palette.blue[50],
    );
  }
}
