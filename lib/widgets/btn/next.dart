import 'package:flutter/material.dart';
import 'package:leadee/share/app_colors.dart';

class NextBtn extends StatelessWidget {
  final Function onPress;
  const NextBtn({Key key, @required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      height: 30,
      onPressed: onPress,
      child: Text(
        'next'.toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      color: AppColors.blue[50],
    );
  }
}
