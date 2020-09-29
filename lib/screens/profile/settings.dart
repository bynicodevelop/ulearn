import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/screens/loading.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/services/storage.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/change_avatar.dart';
import 'package:leadee/widgets/input.dart';
import 'package:leadee/widgets/profile/Background.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthService _authService = AuthService();
  StorageService _storageService = StorageService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> activities = <String>['developer', 'musician', 'marketer'];
  int _selectedActivity = 0;

  String _fullname;
  String _about;
  File _photoUrl;
  File _backgroundImage;

  String _photoProfile;

  Future<void> setBackground(File file) {
    setState(() {
      _backgroundImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: UserModel(
          uid: null,
          phoneNumber: null,
          displayName: '',
          photoURL: '',
          about: ''),
      stream: _authService.user,
      builder: (context, user) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 180,
                    child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          child: Container(
                            height: 130,
                            decoration: BoxDecoration(
                                color: Palette.blue[50],
                                image: _backgroundImage != null ||
                                        user.data.backgroundImage != ''
                                    ? DecorationImage(
                                        image: _backgroundImage != null
                                            ? FileImage(_backgroundImage)
                                            : NetworkImage(
                                                user.data.backgroundImage),
                                        fit: BoxFit.cover)
                                    : null),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context, false)),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Background(
                            onChanged: setBackground,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChangeAvatar(
                                editable: true,
                                photoUrl: user.data.photoURL,
                                onChanged: (file) {
                                  setState(() => _photoUrl = file);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Input(
                                label: 'Fullname',
                                placehoder: 'John Doe',
                                value: user.data.displayName,
                                onChange: (val) => _fullname = val,
                                validator: (val) => val.isEmpty
                                    ? 'Please enter your full name'
                                    : null,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Input(
                                    label: 'About',
                                    placehoder: 'About you...',
                                    value: user.data.about,
                                    onChange: (val) => _about = val,
                                    multiline: true,
                                    maxLine: 3,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Activity',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 9.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Palette.grey[50])),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          onChanged: (val) {
                                            setState(() {
                                              _selectedActivity =
                                                  activities.indexOf(val);
                                            });
                                          },
                                          value: activities[_selectedActivity],
                                          hint: Text("Select activity"),
                                          isDense: true,
                                          style: TextStyle(
                                              color: Palette.blue[300]),
                                          items: activities.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                                height: 40,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    if (_fullname != null) {
                                      await _authService
                                          .updateDiaplayName(_fullname);
                                    }

                                    if (_about != null) {
                                      await _authService.updateAbout(_about);
                                    }

                                    if (_backgroundImage != null) {
                                      String backgroundImage =
                                          await _storageService
                                              .uploadFile(_backgroundImage);

                                      await _authService
                                          .updateBackground(backgroundImage);
                                    }

                                    if (_photoUrl != null) {
                                      String photoUrl = await _storageService
                                          .uploadFile(_photoUrl);

                                      if (photoUrl != null) {
                                        await _authService
                                            .updatePhotoUrl(photoUrl);

                                        setState(() {
                                          _photoProfile = photoUrl;
                                        });
                                      }
                                    }

                                    Navigator.pop(context, true);
                                  }
                                },
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      'Save'.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ),
                                color: Palette.blue[50],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
