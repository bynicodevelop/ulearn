import 'package:flutter/material.dart';

class UserModel {
  String uid;
  String phoneNumber;
  String photoURL;
  String displayName;
  String about;
  String backgroundImage;
  String selectedActivity;
  bool isCurrentUser;

  UserModel(
      {@required this.uid,
      this.phoneNumber = '',
      this.photoURL = '',
      this.displayName = '',
      this.about = '',
      this.backgroundImage = '',
      this.selectedActivity = '',
      this.isCurrentUser = false});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'phoneNumber': phoneNumber,
        'photoURL': photoURL,
        'displayName': displayName,
        'about': about,
        'backgroundImage': backgroundImage,
        'selectedActivity': selectedActivity,
        'isCurrentUser': isCurrentUser,
      };
}
