import 'dart:io';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final File photoUrl;
  final double radius;
  final double border;
  const Avatar({Key key, this.radius = 55.0, this.border = 5.0, this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: (radius + border),
      child: CircleAvatar(
        backgroundImage: photoUrl != null ? FileImage(photoUrl) : null,
        radius: radius,
        child: Text(
          'ND',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
