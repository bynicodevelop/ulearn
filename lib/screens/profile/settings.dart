import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:leadee/models/activity.dart';
import 'package:leadee/routes/ProfileArguments.dart';
import 'package:leadee/services/common.dart';
import 'package:leadee/services/user.dart';
import 'package:leadee/share/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/services/storage.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/change_avatar.dart';
import 'package:leadee/widgets/input.dart';
import 'package:leadee/widgets/profile/Header.dart';
import 'package:leadee/widgets/profile/background.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthService _authService = AuthService();
  UserService _userService = UserService();
  StorageService _storageService = StorageService();
  CommonService _commonService = CommonService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> activities = <String, dynamic>{};
  String _selectedActivity;

  UserModel _userModel;

  File _photoURL;
  File _backgroundImage;

  @override
  Widget build(BuildContext context) {
    ProfileArguments profileArguments =
        ModalRoute.of(context).settings.arguments;

    return StreamBuilder(
      stream: _userService.get(profileArguments.uid, false),
      builder: (context, snapshot) {
        return FutureBuilder(
          future: _commonService.getActivties('en'),
          builder: (context, AsyncSnapshot<dynamic> activities) {
            if (snapshot.data != null) {
              _userModel = UserModel(uid: snapshot.data.uid);
              _userModel.selectedActivity = snapshot.data.selectedActivity == ''
                  ? 'developer'
                  : _selectedActivity != null
                      ? _selectedActivity
                      : snapshot.data.selectedActivity;
              _userModel.backgroundImage = snapshot.data.backgroundImage;
              _userModel.photoURL = snapshot.data.photoURL;
              _userModel.displayName = snapshot.data.displayName;
              _userModel.about = snapshot.data.about;
            }

            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: snapshot.data == null || activities.data == null
                      ? Text('Loading...')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Header(
                              key: UniqueKey(),
                              userModel: snapshot.data,
                              isEditable: true,
                              onChangedAvatar: (file) => _photoURL = file,
                              onChangedBackground: (file) =>
                                  _backgroundImage = file,
                            ),
                            Form(
                              key: _formKey,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Input(
                                      label: 'Fullname',
                                      placehoder: 'John Doe',
                                      value: snapshot.data.displayName,
                                      onChange: (val) =>
                                          _userModel.displayName = val,
                                      validator: (val) => val.isEmpty
                                          ? 'Please enter your full name'
                                          : null,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Input(
                                      label: 'About',
                                      placehoder: 'About you...',
                                      value: snapshot.data.about,
                                      onChange: (val) => _userModel.about = val,
                                      multiline: true,
                                      maxLine: 3,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                                  _selectedActivity = val;
                                                });
                                              },
                                              value:
                                                  _userModel.selectedActivity,
                                              isDense: true,
                                              style: TextStyle(
                                                  color: Palette.blue[300]),
                                              items: activities.data.entries
                                                  .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (MapEntry data) {
                                                return DropdownMenuItem<String>(
                                                  value: data.key,
                                                  child: Text(data.value.value
                                                      .toString()
                                                      .capitalize()),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero),
                                          height: 40,
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              if (_photoURL != null) {
                                                _userModel.photoURL =
                                                    await _storageService
                                                        .uploadFile(_photoURL);
                                              }

                                              if (_backgroundImage != null) {
                                                _userModel.backgroundImage =
                                                    await _storageService
                                                        .uploadFile(
                                                            _backgroundImage);

                                                print(
                                                    _userModel.backgroundImage);
                                              }

                                              await _authService
                                                  .updateUer(_userModel);

                                              _userModel.isCurrentUser = true;

                                              Navigator.pop(
                                                  context, _userModel);
                                            }
                                          },
                                          child: SizedBox(
                                            child: Center(
                                              child: Text(
                                                'save'.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          color: Palette.blue[50],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
            );
          },
        );
      },
    );

    //   return StreamBuilder(
    //     initialData: UserModel(
    //         uid: null,
    //         phoneNumber: null,
    //         displayName: '',
    //         photoURL: '',
    //         about: ''),
    //     stream: _authService.user,
    //     builder: (context, user) {
    //       return SafeArea(
    //         child: Scaffold(
    //           body: SingleChildScrollView(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   height: 180,
    //                   child: Stack(
    //                     clipBehavior: Clip.none,
    //                     alignment: Alignment.topCenter,
    //                     children: [
    //                       Positioned(
    //                         child: Container(
    //                           height: 130,
    //                           decoration: BoxDecoration(
    //                               color: Palette.blue[50],
    //                               image: _backgroundImage != null ||
    //                                       user.data.backgroundImage != ''
    //                                   ? DecorationImage(
    //                                       image: _backgroundImage != null
    //                                           ? FileImage(_backgroundImage)
    //                                           : NetworkImage(
    //                                               user.data.backgroundImage),
    //                                       fit: BoxFit.cover)
    //                                   : null),
    //                         ),
    //                       ),
    //                       Positioned(
    //                         top: 10,
    //                         left: 10,
    //                         child: IconButton(
    //                             color: Colors.white,
    //                             icon: Icon(Icons.arrow_back),
    //                             onPressed: () => Navigator.pop(context, false)),
    //                       ),
    //                       Positioned(
    //                         top: 10,
    //                         right: 10,
    //                         child: Background(
    //                           onChanged: setBackground,
    //                         ),
    //                       ),
    //                       Positioned(
    //                         bottom: 0,
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             ChangeAvatar(
    //                               editable: true,
    //                               photoUrl: user.data.photoURL,
    //                               onChanged: (file) {
    //                                 setState(() => _photoUrl = file);
    //                               },
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   padding: EdgeInsets.all(20.0),
    //                   child: Column(
    //                     children: [
    //                       Form(
    //                         key: _formKey,
    //                         child: Column(
    //                           children: [
    //                             Input(
    //                               label: 'Fullname',
    //                               placehoder: 'John Doe',
    //                               value: user.data.displayName,
    //                               onChange: (val) => _fullname = val,
    //                               validator: (val) => val.isEmpty
    //                                   ? 'Please enter your full name'
    //                                   : null,
    //                             ),
    //                             Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 SizedBox(
    //                                   height: 20,
    //                                 ),
    //                                 Input(
    //                                   label: 'About',
    //                                   placehoder: 'About you...',
    //                                   value: user.data.about,
    //                                   onChange: (val) => _about = val,
    //                                   multiline: true,
    //                                   maxLine: 3,
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(
    //                               height: 20,
    //                             ),
    //                             Column(
    //                               crossAxisAlignment: CrossAxisAlignment.stretch,
    //                               children: [
    //                                 Text(
    //                                   'Activity',
    //                                   style: TextStyle(fontSize: 12),
    //                                 ),
    //                                 SizedBox(
    //                                   height: 9.0,
    //                                 ),
    //                                 Container(
    //                                   padding: EdgeInsets.symmetric(
    //                                       vertical: 10.0, horizontal: 20.0),
    //                                   decoration: BoxDecoration(
    //                                       border: Border.all(
    //                                           color: Palette.grey[50])),
    //                                   child: DropdownButtonHideUnderline(
    //                                     child: DropdownButton(
    //                                         onChanged: (val) {
    //                                           setState(() {
    //                                             _selectedActivity = val;
    //                                           });
    //                                         },
    //                                         value:
    //                                             user.data.selectedActivity != ''
    //                                                 ? user.data.selectedActivity
    //                                                 : _selectedActivity,
    //                                         hint: Text("Select activity"),
    //                                         isDense: true,
    //                                         style: TextStyle(
    //                                             color: Palette.blue[300]),
    //                                         items: activities.entries
    //                                             .map((MapEntry data) {
    //                                           return DropdownMenuItem<String>(
    //                                             value: data.key,
    //                                             child: Text(data.value['en']
    //                                                 .toString()
    //                                                 .capitalize()),
    //                                           );
    //                                         }).toList()),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(
    //                               height: 20,
    //                             ),
    //                             MaterialButton(
    //                               shape: RoundedRectangleBorder(
    //                                   borderRadius: BorderRadius.zero),
    //                               height: 40,
    //                               onPressed: () async {
    //                                 if (_formKey.currentState.validate()) {
    //                                   if (_fullname != null) {
    //                                     await _authService
    //                                         .updateDiaplayName(_fullname);
    //                                   }

    //                                   if (_about != null) {
    //                                     await _authService.updateAbout(_about);
    //                                   }

    //                                   if (_backgroundImage != null) {
    //                                     String backgroundImage =
    //                                         await _storageService
    //                                             .uploadFile(_backgroundImage);

    //                                     await _authService
    //                                         .updateBackground(backgroundImage);
    //                                   }

    //                                   if (_selectedActivity != null) {
    //                                     await _authService
    //                                         .updateActivity(_selectedActivity);
    //                                   }

    //                                   if (_photoUrl != null) {
    //                                     String photoUrl = await _storageService
    //                                         .uploadFile(_photoUrl);

    //                                     if (photoUrl != null) {
    //                                       await _authService
    //                                           .updatePhotoUrl(photoUrl);

    //                                       setState(() {
    //                                         _photoProfile = photoUrl;
    //                                       });
    //                                     }
    //                                   }

    //                                   Navigator.pop(context, true);
    //                                 }
    //                               },
    //                               child: SizedBox(
    //                                 child: Center(
    //                                   child: Text(
    //                                     'Save'.toUpperCase(),
    //                                     style: TextStyle(
    //                                         color: Colors.white, fontSize: 14),
    //                                   ),
    //                                 ),
    //                               ),
    //                               color: Palette.blue[50],
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   );
  }
}
