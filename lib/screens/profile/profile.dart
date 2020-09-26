import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/avatar.dart';
import 'package:leadee/widgets/avatar/change_avatar.dart';
import 'package:leadee/widgets/profile_stat.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
                        bottom: -60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ChangeAvatar()],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                            icon: Icon(Icons.settings),
                            color: Colors.white,
                            onPressed: () =>
                                Navigator.pushNamed(context, '/settings')),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/id/1/500'),
                          fit: BoxFit.cover)),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  Text(
                    'John Doe'.toUpperCase(),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'about'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC…',
                    style: TextStyle(
                        color: Palette.blue[300],
                        fontSize: 12,
                        letterSpacing: 1.1),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Palette.blue[200])),
                    height: 40,
                    onPressed: () => print('message'),
                    child: SizedBox(
                      width: 120,
                      child: Center(
                        child: Text(
                          'message'.toUpperCase(),
                          style:
                              TextStyle(color: Palette.blue[200], fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    height: 40,
                    onPressed: () => print('follow'),
                    child: SizedBox(
                      width: 120,
                      child: Center(
                        child: Text(
                          'follow'.toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    color: Palette.blue[50],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
