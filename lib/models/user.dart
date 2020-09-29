import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final String photoURL;
  final String displayName;
  final String about;
  final String backgroundImage;

  const UserModel(
      {@required this.uid,
      @required this.phoneNumber,
      this.photoURL,
      this.displayName,
      this.about = '',
      this.backgroundImage = ''});
}
