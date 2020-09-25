import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class LinkBtn extends StatelessWidget {
  final String label;
  final Function onPress;
  const LinkBtn({Key key, @required this.onPress, this.label = 'Skip'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        height: 30,
        onPressed: onPress,
        child: Text(
          label,
          style: TextStyle(color: Palette.grey[50], fontSize: 12),
        ));
  }
}
