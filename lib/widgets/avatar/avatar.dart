import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final String photoUrl;
  final double radius;
  final double border;
  const Avatar({Key key, this.radius = 55.0, this.border = 5.0, this.photoUrl})
      : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: (widget.radius + widget.border),
      child: CircleAvatar(
        backgroundImage: widget.photoUrl != null
            ? CachedNetworkImageProvider(widget.photoUrl)
            : null,
        radius: widget.radius,
        child: widget.photoUrl == null
            ? Text(
                'ND',
                style: TextStyle(fontSize: 22),
              )
            : null,
      ),
    );
  }
}
