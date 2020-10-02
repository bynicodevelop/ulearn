import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/routes/ProfileArguments.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/change_avatar.dart';
import 'package:leadee/widgets/profile/Background.dart';

class Header extends StatefulWidget {
  final UserModel userModel;
  final isEditable;
  final Function onChangedAvatar;
  final Function onChangedBackground;
  final Function onChanged;

  Header(
      {Key key,
      this.userModel,
      this.isEditable = false,
      this.onChangedAvatar,
      this.onChangedBackground,
      this.onChanged})
      : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _backgroundImage;
  String _photoURL;
  List<Widget> widgets = [];

  Positioned _getBackBtn(Function onPressed) {
    return Positioned(
      top: 10,
      left: 10,
      child: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: onPressed),
    );
  }

  Positioned _getSettingsBtn(Function onPressed) {
    return Positioned(
      top: 10,
      right: 10,
      child: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white,
          onPressed: onPressed),
    );
  }

  Positioned _getChangeBackgroundBtn(Function onChanged) {
    return Positioned(
      top: 10,
      right: 10,
      child: Background(
        onChanged: onChanged,
      ),
    );
  }

  Positioned _getAvatar(String photoURL, bool isEditable, Function onChanged) {
    return Positioned(
      bottom: -10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChangeAvatar(
            editable: isEditable,
            photoUrl: _photoURL,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }

  Positioned _getBackground() {
    return Positioned(
      child: Container(
        height: 130,
        decoration: BoxDecoration(
            color: Palette.blue[50],
            image: _backgroundImage != ''
                ? DecorationImage(
                    image: _backgroundImage.startsWith('/')
                        ? FileImage(File(_backgroundImage))
                        : CachedNetworkImageProvider(_backgroundImage),
                    fit: BoxFit.cover)
                : null),
      ),
    );
  }

  _updateBackground(File file) {
    setState(() {
      _backgroundImage = file.path;
    });

    widget.onChangedBackground(file);
  }

  _updatePhotoURL(File file) {
    setState(() {
      _photoURL = file.path;
    });

    widget.onChangedAvatar(file);
  }

  @override
  void initState() {
    super.initState();
    _backgroundImage = widget.userModel.backgroundImage;
    _photoURL = widget.userModel.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    widgets.add(_getBackground());
    widgets.add(_getBackBtn(() => Navigator.pop(context)));
    widgets.add(_getAvatar(
        widget.userModel.photoURL, widget.isEditable, _updatePhotoURL));

    // Ne s'affiche que dans le cas on l'utilisateur est sur son profil
    if (widget.userModel.isCurrentUser) {
      widgets.add(_getSettingsBtn(() async {
        final result = await Navigator.pushNamed(context, '/settings',
            arguments: ProfileArguments(widget.userModel.uid));

        if (result != null) {
          (result as UserModel).backgroundImage = _backgroundImage;
          (result as UserModel).photoURL = _photoURL;

          widget.onChanged(result);
        }
      }));
    }

    if (widget.isEditable) {
      widgets.add(_getChangeBackgroundBtn(_updateBackground));
    }

    return SizedBox(
      height: 180,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: widgets,
      ),
    );
  }
}
