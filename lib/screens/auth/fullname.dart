import 'package:flutter/material.dart';
import 'package:leadee/screens/auth/welcome.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/btn/next.dart';
import 'package:leadee/widgets/bullet_step.dart';
import 'package:leadee/widgets/input.dart';

class FullName extends StatefulWidget {
  FullName({Key key}) : super(key: key);

  @override
  _FullNameState createState() => _FullNameState();
}

class _FullNameState extends State<FullName> {
  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _displayName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
              body: Center(
        child: SingleChildScrollView(
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
                  style: TextStyle(fontSize: 12, color: Palette.blue[300]),
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Input(
                            label: 'Enter your full name',
                            placehoder: 'John Doe',
                            onChange: (val) => _displayName = val,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your full name'
                                : null),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            NextBtn(
                              onPress: () async {
                                if (_formKey.currentState.validate()) {
                                  await _authService
                                      .updateDiaplayName(_displayName);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Welcome()));
                                }
                              },
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
        ),
      ))),
    );
  }
}
