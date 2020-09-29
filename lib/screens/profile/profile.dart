import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/change_avatar.dart';
import 'package:leadee/widgets/profile/stat.dart';
import 'package:leadee/widgets/profile/contact_btn.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService _authService = AuthService();

  String _photoUrl;
  String _displayName;
  String _about;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: UserModel(
          uid: null,
          phoneNumber: null,
          displayName: '',
          photoURL: '',
          about: ''),
      stream: _authService.user,
      builder: (context, user) {
        return SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 130,
                      child: Stack(
                        overflow: Overflow.visible,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                color: Colors.white,
                                onPressed: () => Navigator.pop(context)),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                                icon: Icon(Icons.settings),
                                color: Colors.white,
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/settings')
                                        // TODO: Pourquoi quand je retire ça, ça ne met plus à jour la vue
                                        .then((dynamic value) async {
                                      if (value != false) {
                                        UserModel user =
                                            await _authService.init();

                                        setState(() {
                                          _photoUrl = user.photoURL;
                                          _displayName = user.displayName;
                                          _about = user.about;
                                        });
                                      }
                                    })),
                          ),
                          Positioned(
                            bottom: -60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ChangeAvatar(
                                  photoUrl: user.data.photoURL,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Palette.blue[50],
                          image: user.data.backgroundImage != ''
                              ? DecorationImage(
                                  image:
                                      NetworkImage(user.data.backgroundImage),
                                  fit: BoxFit.cover)
                              : null),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 70),
                  child: Column(
                    children: [
                      Text(
                        user.data.displayName.toUpperCase(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Palette.blue[300]),
                      ),
                      Text(
                        'Developer',
                        style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.2,
                            color: Palette.blue[300]),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileStat(
                        label: 'feed',
                        number: '187',
                      ),
                      ProfileStat(
                        label: 'follower',
                        number: '23K',
                      ),
                      ProfileStat(
                        label: 'following',
                        number: '1,285',
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'about'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        user.data.about,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Palette.blue[300],
                            fontSize: 12,
                            letterSpacing: 1.1),
                      )
                    ],
                  ),
                ),
                ContactBtn()
              ],
            ),
          ),
        ));
      },
    );
  }
}
