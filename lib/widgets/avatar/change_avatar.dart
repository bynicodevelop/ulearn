import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/avatar.dart';
import 'package:path/path.dart' as path;

class ChangeAvatar extends StatefulWidget {
  String photoUrl;
  final double border;
  final double radius;
  final editable;
  Function(File) onChanged;

  ChangeAvatar(
      {Key key,
      this.photoUrl,
      this.editable = false,
      this.border = 5.0,
      this.radius = 50,
      this.onChanged})
      : super(key: key);

  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  final picker = ImagePicker();
  bool _updated = false;
  File _file;

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
      setState(() {
        _updated = true;
        _file = file;
      });

      widget.onChanged(_file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.editable
        ? GestureDetector(
            onTap: getImage,
            child: CircleAvatar(
                backgroundColor: Palette.blue[50],
                backgroundImage: widget.photoUrl != null
                    ? _updated == false
                        ? widget.photoUrl != ''
                            ? NetworkImage(widget.photoUrl)
                            : null
                        : FileImage(_file)
                    : null,
                radius: widget.radius,
                child: widget.photoUrl == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 24,
                      )
                    : null))
        : Avatar(
            border: widget.border,
            photoUrl: widget.photoUrl != '' ? widget.photoUrl : null,
          );
  }
}
