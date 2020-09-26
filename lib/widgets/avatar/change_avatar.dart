import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/avatar.dart';
import 'package:path/path.dart' as path;

class ChangeAvatar extends StatelessWidget {
  File photoUrl;
  final double border;
  final double radius;
  final editable;
  final picker = ImagePicker();

  ChangeAvatar(
      {Key key,
      this.photoUrl,
      this.editable = false,
      this.border = 5.0,
      this.radius = 50})
      : super(key: key);

  Future getImage() async {
    File file;
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 80, maxWidth: 200);

    if (pickedFile != null) {
      String fileName = pickedFile.path.split('/').last.split('.').first;
      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(
          dir, '${md5.convert(utf8.encode(fileName)).toString()}.jpg');

      file = await File(pickedFile.path).copy(newPath);
    }

    if (file != null) {
      photoUrl = file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return editable
        ? GestureDetector(
            onTap: getImage,
            child: CircleAvatar(
                backgroundColor: Palette.blue[50],
                backgroundImage: photoUrl != null ? FileImage(photoUrl) : null,
                radius: radius,
                child: photoUrl == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 24,
                      )
                    : null))
        : Avatar(
            border: border,
            photoUrl: photoUrl,
          );
  }
}
