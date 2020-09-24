import 'package:flutter/material.dart';
import 'package:leadee/share/app_colors.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'everyone has\n'.toUpperCase(),
                            style: TextStyle(
                                color: AppColors.blue[100], fontSize: 30),
                            children: [
                          TextSpan(
                              text: 'knowladge\n'.toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.blue[50],
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: 'to share'.toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.blue[100],
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
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your phone number',
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
                              hintText: '06584323456',
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide:
                                    BorderSide(color: AppColors.grey[50]),
                              )),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          minWidth: double.infinity,
                          onPressed: () => {},
                          child: Text(
                            'Sign In'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          color: AppColors.blue[50],
                        )
                      ],
                    ))
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
