import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/widgets/profile/stat.dart';

class StatBar extends StatelessWidget {
  final UserModel userModel;
  const StatBar({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
