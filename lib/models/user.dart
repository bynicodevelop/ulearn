import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String phoneNumber;
  final String photoURL;
  final String displayName;

  const UserModel(
      {@required this.uid,
      @required this.phoneNumber,
      this.photoURL,
      this.displayName});
}
