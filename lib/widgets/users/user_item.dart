import 'package:flutter/material.dart';
import 'package:leadee/screens/auth/avatar.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(),
      title: Text('John Doe'),
    );
  }
}
