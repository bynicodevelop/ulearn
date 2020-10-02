import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/routes/ProfileArguments.dart';
import 'package:leadee/services/user.dart';
import 'package:leadee/widgets/profile/about.dart';
import 'package:leadee/widgets/profile/contact_btn.dart';
import 'package:leadee/widgets/profile/header.dart';
import 'package:leadee/widgets/profile/stat_bar.dart';
import 'package:leadee/widgets/profile/sub_header.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserService _userService = UserService();

  Stream<UserModel> _userModelStream;

  Function updatedProfile(UserModel userModel) {
    if (userModel != null) {
      setState(() {
        _userModelStream =
            _userService.get(userModel.uid, userModel.isCurrentUser);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileArguments profileArguments =
        ModalRoute.of(context).settings.arguments;

    _userModelStream =
        _userService.get(profileArguments.uid, profileArguments.isCurrentUser);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: _userModelStream.asBroadcastStream(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Text('Loading...');
              } else {
                return Column(
                  children: [
                    Header(
                      key: UniqueKey(),
                      userModel: snapshot.data,
                      onChanged: updatedProfile,
                    ),
                    SubHeader(
                      userModel: snapshot.data,
                    ),
                    StatBar(
                      userModel: snapshot.data,
                    ),
                    About(
                      userModel: snapshot.data,
                    ),
                    ContactBtn(
                      userModel: snapshot.data,
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
