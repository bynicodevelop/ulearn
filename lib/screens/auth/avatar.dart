import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/screens/auth/fullname.dart';
import 'package:leadee/screens/loading.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/services/storage.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/btn/link.dart';
import 'package:leadee/widgets/btn/next.dart';
import 'package:leadee/widgets/bullet_step.dart';
import 'package:path/path.dart' as path;

class Avatar extends StatefulWidget {
  Avatar({Key key}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  bool _isLoading = false;
  final picker = ImagePicker();
  File _file;

  Future getImage() async {
    File file;
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      String fileName = pickedFile.path.split('/').last.split('.').first;
      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(
          dir, '${md5.convert(utf8.encode(fileName)).toString()}.jpg');

      print(newPath);

      file = await File(pickedFile.path).copy(newPath);
    }

    setState(() {
      if (file != null) {
        _file = file;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Container(
            child: SafeArea(
                child: Scaffold(
                    body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: 295.0, minWidth: 150.0, minHeight: 50.0),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: getImage,
                          child: CircleAvatar(
                              backgroundColor: Palette.blue[50],
                              backgroundImage:
                                  _file != null ? FileImage(_file) : null,
                              radius: 55,
                              child: _file == null
                                  ? Icon(
                                      Icons.camera_alt,
                                      size: 24,
                                    )
                                  : null)),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        width: 234,
                        child: Text(
                          'Posting a photo inspires the confidence of your audience.\nIdeally, it is best if your head is clearly visible.',
                          style: TextStyle(
                              fontSize: 12,
                              color: Palette.blue[200],
                              height: 1.3),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          LinkBtn(
                              onPress: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullName()))),
                          NextBtn(
                            onPress: () async {
                              setState(() => this._isLoading = true);
                              String photoUrl =
                                  await _storageService.uploadFile(_file);

                              UserModel user =
                                  await _authService.updatePhotoUrl(photoUrl);

                              setState(() => this._isLoading = false);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullName()));
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      BulletStep(step: 1)
                    ],
                  ),
                ),
              ),
            ))),
          );
  }
}
