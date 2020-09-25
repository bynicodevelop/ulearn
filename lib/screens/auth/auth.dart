import 'package:flutter/material.dart';
import 'package:leadee/services/auth.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/input.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();

  String _phone;
  String _code;
  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();

    // Function dialog = (String verificationId, [int forceResendingToken]) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             title: Text('Enter SMS Code'),
    //             content: Column(
    //               children: [
    //                 Input(
    //                   label: 'Enter your code',
    //                   placehoder: '123456',
    //                   onChange: (val) => _code = val,
    //                 )
    //               ],
    //             ),
    //             actions: [
    //               FlatButton(
    //                   onPressed: () {
    //                     _authService.auth(verificationId, _code);
    //                   },
    //                   child: Text('Validate'))
    //             ],
    //           ));
    // };

    // _authService.addCodeSentCb(dialog);

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: 295.0, minWidth: 150.0, minHeight: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'everyone has\n'.toUpperCase(),
                            style: TextStyle(
                                color: Palette.blue[100], fontSize: 30),
                            children: [
                          TextSpan(
                              text: 'knowladge\n'.toUpperCase(),
                              style: TextStyle(
                                  color: Palette.blue[50],
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: 'to share'.toUpperCase(),
                                    style: TextStyle(
                                        color: Palette.blue[100],
                                        fontWeight: FontWeight.normal))
                              ]),
                        ])),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'It all start here',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Input(
                              label: 'Enter your phone number',
                              placehoder: '+33652737153',
                              onChange: (val) => _phone = val,
                              validator: (value) =>
                                  value.isEmpty ? 'enter_phone_number' : null,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            MaterialButton(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              minWidth: double.infinity,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {}
                              },
                              child: Text(
                                'Sign In'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              color: Palette.blue[50],
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
