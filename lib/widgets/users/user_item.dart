import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/routes/ProfileArguments.dart';
import 'package:leadee/screens/profile/profile.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/avatar.dart';

class UserItem extends StatelessWidget {
  final String photoURL;
  final String displayName;
  final String about;
  final String uid;
  const UserItem(
      {Key key, this.photoURL, this.displayName, this.about, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.pushNamed(context, '/profile',
            arguments: ProfileArguments(uid)),
        dense: true,
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Avatar(
                radius: 20,
                photoUrl: photoURL,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(displayName),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      about,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Palette.grey[50]),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
