import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/btn/next.dart';
import 'package:leadee/widgets/bullet_step.dart';

class Avatar extends StatefulWidget {
  Avatar({Key key}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: 295.0, minWidth: 150.0, minHeight: 50.0),
                child: Column(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: Palette.blue[50],
                      textColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(40),
                      shape: CircleBorder(),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: 234,
                      child: Text(
                        'Posting a photo inspires the confidence of your audience.\nIdeally, it is best if your head is clearly visible.',
                        style: TextStyle(
                            fontSize: 12,
                            color: Palette.blue[200],
                            height: 1.3),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        FlatButton(
                            height: 30,
                            onPressed: () => {},
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  color: Palette.grey[50], fontSize: 12),
                            )),
                        NextBtn(
                          onPress: () => print('Next'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    BulletStep(step: 1)
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
