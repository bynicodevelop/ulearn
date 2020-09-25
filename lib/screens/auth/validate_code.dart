import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/btn/link.dart';
import 'package:leadee/widgets/btn/next.dart';

class ValidateCode extends StatefulWidget {
  ValidateCode({Key key}) : super(key: key);

  @override
  _ValidateCodeState createState() => _ValidateCodeState();
}

class _ValidateCodeState extends State<ValidateCode> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter the code you received by SMS',
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
                                hintText: '123456',
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide:
                                      BorderSide(color: Palette.grey[50]),
                                )),
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
                                onPress: () => print('Next'),
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
