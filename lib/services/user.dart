import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:leadee/models/user.dart';

class UserService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<List<UserModel>> getAll() async {
    List<UserModel> users = [];
    DataSnapshot data = await _database.reference().child('users').once();

    Map<dynamic, dynamic> map = data.value;

    map.forEach((key, value) {
      users.add(UserModel(uid: key, displayName: value['display-name']));
    });

    return users;
  }
}
