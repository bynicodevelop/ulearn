import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Background extends StatelessWidget {
  final picker = ImagePicker();
  final Function onChanged;

  Background({Key key, this.onChanged}) : super(key: key);

  Future getImage() async {
    File file;
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 80, maxWidth: 400);

    if (pickedFile != null) {
      String fileName = pickedFile.path.split('/').last.split('.').first;
      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(
          dir, '${md5.convert(utf8.encode(fileName)).toString()}.jpg');

      file = await File(pickedFile.path).copy(newPath);
    }

    if (file != null) {
      onChanged(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: Icon(Icons.image), color: Colors.white, onPressed: getImage),
    );
  }
}
