import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/services/auth.dart';

class UserService {
  final AuthService _authService = AuthService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<List<UserModel>> getAll(String searchValue) async {
    List<UserModel> users = [];
    UserModel user = await _authService.user.first;

    DataSnapshot data = await _database
        .reference()
        .child('users')
        .orderByChild('display-name')
        .startAt(searchValue)
        .endAt(searchValue + "\uf8ff")
        .once();

    Map<dynamic, dynamic> map = data.value;

    if (map != null && map.length > 0) {
      map.forEach((key, value) {
        if (key != user.uid) {
          users.add(UserModel(
              uid: key,
              displayName:
                  value['display-name'] != null ? value['display-name'] : '',
              photoURL: value['photo-url'] != null ? value['photo-url'] : '',
              about: value['about'] != null ? value['about'] : ''));
        }
      });
    }

    return users;
  }
}
