import 'package:flutter/material.dart';
import 'package:leadee/routes/ProfileArguments.dart';
import 'package:leadee/screens/auth/auth.dart';
import 'package:leadee/services/auth.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        body: StreamBuilder(
            stream: _authService.user,
            builder: (context, snapshot) => Column(
                  children: [
                    FlatButton(
                      child: Text('Logout'),
                      onPressed: () async {
                        await _authService.signOut();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Auth()));
                      },
                    ),
                    FlatButton(
                      child: Text('Profile'),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/profile',
                            arguments: ProfileArguments(snapshot.data.uid,
                                isCurrentUser: true));
                      },
                    ),
                    FlatButton(
                      child: Text('Users'),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/users');
                      },
                    ),
                  ],
                )),
      )),
    );
  }
}
