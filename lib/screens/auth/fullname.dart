import 'package:flutter/material.dart';
import 'package:leadee/share/app_colors.dart';
import 'package:leadee/widgets/btn/next.dart';
import 'package:leadee/widgets/bullet_step.dart';

class FullName extends StatefulWidget {
  FullName({Key key}) : super(key: key);

  @override
  _FullNameState createState() => _FullNameState();
}

class _FullNameState extends State<FullName> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What's your\nfull name?".toUpperCase(),
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Your name can also be a nickname that presents your visual identity',
                      style:
                          TextStyle(fontSize: 12, color: AppColors.blue[300]),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your full name',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              isDense: true,
                              hintText: 'John Doe',
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide:
                                    BorderSide(color: AppColors.grey[50]),
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            NextBtn(
                              onPress: () => print('Next'),
                            )
                          ],
                        )
                      ],
                    )),
                    SizedBox(
                      height: 50,
                    ),
                    BulletStep(
                      step: 2,
                    )
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
