import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/screens/loading.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/btn/link.dart';
import 'package:leadee/widgets/btn/next.dart';
import 'package:leadee/widgets/input.dart';

class ValidateCode extends StatefulWidget {
  final String phone;
  const ValidateCode({Key key, @required this.phone}) : super(key: key);

  @override
  _ValidateCodeState createState() => _ValidateCodeState();
}

class _ValidateCodeState extends State<ValidateCode> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  AuthService _authService = AuthService();

  String _code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _authService.registerWithPhone(widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: 295.0, minWidth: 150.0, minHeight: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'code sms'.toUpperCase(),
                      style: TextStyle(color: Palette.blue[100], fontSize: 30),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Input(
                            label: 'Enter the code you received by SMS',
                            placehoder: '123456',
                            onChange: (val) => _code = val,
                            validator: (val) =>
                                val.isEmpty ? 'Enter your code' : null,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              LinkBtn(
                                  label: 'Send a new code',
                                  onPress: () => Navigator.pop(context)),
                              NextBtn(
                                label: 'validate',
                                onPress: () async {
                                  if (_formKey.currentState.validate()) {
                                    UserModel userModel =
                                        await _authService.auth(_code);

                                    if (userModel == null) {
                                      const snackbar = SnackBar(
                                          content:
                                              Text('Your code is note valide'));

                                      _scaffoldKey.currentState
                                          .showSnackBar(snackbar);
                                    }
                                  }
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
