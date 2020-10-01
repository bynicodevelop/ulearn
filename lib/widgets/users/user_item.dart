import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/avatar.dart';

class UserItem extends StatelessWidget {
  final String photoURL;
  final String displayName;
  final String about;
  const UserItem({Key key, this.photoURL, this.displayName, this.about})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => print('onTap'),
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
